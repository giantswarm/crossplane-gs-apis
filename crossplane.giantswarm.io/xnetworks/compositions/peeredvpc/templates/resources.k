chunksplit = lambda size: int subnets: [] -> [] {
    # split the subnets array into chunks of size `size`
    [] if not subnets or subnets == Undefined else [
        subnets[i:i + size:]
        for i in range(0, len(subnets), size)
    ]
}

allowsPublic = lambda vpc: str -> bool {
    a = [
        get(x, "allowPublic", False)
        for x in get(_oxr, "spec.peering.remoteVpcs", [])
        if x.name == vpc
    ]

    a[0] if len(a) == 1 else False
}

# Collect the number of requested subnet sets - you can have up to 200 subnets
# in a VPC - this total must be below that
requestedSets = [
    c.public.count + c.private.count
    for c in get(_oxr, "spec.subnetsets.cidrs", [])
]

zones = sorted(get(_oxr, "spec.availabilityZones", [ "a", "b", "c" ]))

assert sum(requestedSets)*len(zones) < 200, """
    The number of subnet sets you are requesting will exceed the maximum number
    of subnets allowed by AWS. The sum of all counts multiplied by the number of
    availability zones must be less than 200.
"""

# The first entry in the `subnetsets.cidrs` list is the primary CIDR range for
# the VPC.
#
# The remaining entries are additional CIDR ranges that can be attached with AWS
# allowing up to 4 additional CIDR ranges.
additionalCidrs = [
    s.prefix
    for s in _oxr.spec.subnetsets.cidrs[1:]
]

calculatedCidrs = get(_oxr, "status.calculatedCidrs", {})
clusterTags = get(_oxr, "spec.tags.cluster", {})

# Created checks
vpcs = get(_oxr, "status.vpcs", {})
self = get(vpcs, "self", {})

_ngw = [
    ngw.Resource for _, ngw in _ocs if _ocs and get(ngw, "Resource.kind", "") == "NATGateway"
]
natgatewaysCreated = len([ngw for ngw in _ngw if ngw]) == len(zones)

# Separate out created public and private subnets
pubsn = [
    x
    for _, x in get(self, "publicSubnets", [])
    if self and get(self, "publicSubnets", False)
]

prisn = [
    x
    for _, x in get(self, "privateSubnets", [])
    if self and get(self, "privateSubnets", False)
]

# Create the SubnetSets
#
# SubnetSets are a collection of Subnets and RouteTables per availability zone
# Each set logically belongs together as they share consecutive CIDR ranges
# and have one subnet and one route table per requested availability zone (3)
_subnetsets = [
    {
        _subnets = chunksplit(len(zones), calculatedCidrs[s.prefix])
        _visibility = "public" if i < get(s, "public.count", 0) else "private"
        _index = i if _visibility == "public" else i - s.public.count

        # this is needed for tagging the subnet sets independently of each other
        # it creates a '-' (hyphen) separated copy of the IP address from the first
        # subnet + the last 2 octets from the last subnet, e.g. 192-168-0-0-2-0
        _s1 = regex.split(_subnets[i][0], "/")[0]
        _s1hyphened = regex.replace(_s1, "\.", "-")

        _s2 = regex.split(_subnets[i][len(zones)-1], "/")[0]
        _s2octs = regex.split(_s2, "\.")
        _suffix = _s1hyphened + "-" + _s2octs[2] + "-" + _s2octs[3]
        _snlbtag = {
            **clusterTags
            "kubernetes.io/role/elb": "1"
        } if _index == s.public.lbSetIndex and _visibility == "public" else {
            **clusterTags
            "kubernetes.io/role/internal-elb": "1"
        } if _index == s.private.lbSetIndex and _visibility == "private" else {}

        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "SubnetSet"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "subnetset-${_visibility}-cidr${c}-${_index}"
                "krm.kcl.dev/ready" = ready(_ocs, "subnetset-${_visibility}-cidr${c}-${_index}")
            }
            "labels": labels | {access: _visibility, index: _index}
        }
        "spec": {
            "appIndex": _suffix
            "claimRef": claimRef
            "deletionPolicy": dp
            "region": region
            "providerConfigRef": pcr
            "subnets": {
                zones[j]: _subnets[i][j]
                for j in range(len(zones))
            }
            "type": _visibility
            "tags": {
                "all": tags | get(_oxr, "spec.tags.subnet", {})
                "subnet": _snlbtag
            }
            "vpcId": self.id
        }
    }
    for c, s in get(_oxr, "spec.subnetsets.cidrs", [])
    for i in range(get(s, "public.count", 0) + get(s, "private.count", 0))
    if all_true([
        calculatedCidrs, self,
        self.id,
        get(_oxr, "spec.subnetsets.cidrs", False)
    ])
]

# Set the subnetset tag and labels
# This needs to be set for later separation of public and private subnets
# into their respective groups but cannot be done as part of the creation due
# to language limitations.

_pubss = [s for s in _subnetsets if get(s, "spec.type", "") == "public"]
_fpubss = [
    {
        **s
        **{
            "metadata": {
                labels: {
                    subnetset: "${i}"
                }
            }
            "spec": {
                tags: {
                    "all": {"giantswarm.io/subnetset": "${i}"}
                }
            }
        }
    }
    for i, s in _pubss
]

_priss = [s for s in _subnetsets if get(s, "spec.type", "") == "private"]
_fpriss = [
    {
        **s
        **{
            "metadata": {
                labels: {
                    subnetset: "${i}"
                }
            }
            "spec": {
                tags: {
                    "all": {"giantswarm.io/subnetset": "${i}"}
                }
            }
        }
    }
    for i, s in _priss
]
subnetsets = _fpubss + _fpriss

# Create Additional VPC CIDRs
#
# Each VPC may have up to 4 additional CIDRs attached
acs = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "VPCIPv4CidrBlockAssociation"
        "metadata": {
            "labels": labels
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "cidrassoc-${i}"
                "krm.kcl.dev/ready" = ready(_ocs, "cidrassoc-${i}")
            }
        }
        spec: {
            "deletionPolicy": dp
            "forProvider": {
                "cidrBlock": cidr
                "region": region
                "vpcIdSelector": {
                    "matchControllerRef": True
                }
            }
            "providerConfigRef": pcr
        }
    }
    for i, cidr in additionalCidrs
]

# Create Elastic IPs for the nat gateways
#
# Each NAT Gateway must be associated with an EIP
eips = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "EIP"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "eip-${i}"
                "krm.kcl.dev/ready" = ready(_ocs, "eip-${i}")
            }
            "labels": labels | {
                "availabilityZone": az
                "utilization": "nat-gateway"
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "domain": "vpc"
                "region": region
                "tags": tags | {"Name": "${appName}-${region}${az}-${i}"}
            }
            "providerConfigRef": pcr
        }
    }
    for i, az in zones if pubsn
]

# NAT Gateways
#
# One NatGateway per availability zone is created and attached
# to the first available public subnet set
keys = [k for k in pubsn[0]] if pubsn and len(pubsn) > 0 and len(pubsn[0]) == len(zones) else []
natgateways = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "NATGateway"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "ngw-${i}"
                "krm.kcl.dev/ready" = ready(_ocs, "ngw-${i}")
            }
            "labels": {
                "availabilityZone": az
            } | labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "allocationIdSelector": {
                    "matchControllerRef": True
                    "matchLabels": {availabilityZone: az}
                }
                "region": region
                "subnetId": pubsn[0][keys[i]].id
                "tags": labels | {
                    "Name": "${appName}-${region}${az}"
                } | tags
            }
            "providerConfigRef": pcr
        }
    }
    for i, az in zones
    if all_true([
        pubsn,
        len(keys) > 0,
        len(pubsn) > 0,
        eips
    ])
]

_prirtbls = [
    x
    for _, x in get(self, "privateRouteTables", [])
    if self and get(self, "privateRouteTables", False)
]

_pubrtbls = [
    x
    for _, x in get(self, "publicRouteTables", [])
    if self and get(self, "publicRouteTables", False)
]

# Nat Gateway Routes
#
# One route per private route table
ngwRoutes = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "Route"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "ngw-rt-${rtbl[1].id}"
                "krm.kcl.dev/ready" = ready(_ocs, "ngw-rt-${rtbl[1].id}")
            }
            "labels": {
                "availabilityZone": rtbl[0]
                "routeType": "ngw"
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "destinationCidrBlock": "0.0.0.0/0"
                "natGatewayIdSelector": {
                    "matchControllerRef": True
                    "matchLabels": {availabilityZone: rtbl[0]}
                }
                "region": region
                "routeTableId": rtbl[1].id
            }
            "providerConfigRef": pcr
        }
    }
    for i, x in _prirtbls
    for _, rtbl in zip(zones, [r for _, r in x])
    if pubsn and natgatewaysCreated
]

# Internet Gateway Routes
#
# One IGW route per public route table
igwRoutes = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "Route"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "igw-rt-${rtbl[1].id}"
                "krm.kcl.dev/ready" = ready(_ocs, "igw-rt-${rtbl[1].id}")
            }
            "labels": {
                "availabilityZone": rtbl[0]
                "routeType": "igw"
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "destinationCidrBlock": "0.0.0.0/0"
                "gatewayIdSelector": {
                    "matchControllerRef": True
                }
                "region": region
                "routeTableId": rtbl[1].id
            }
            "providerConfigRef": pcr
        }
    }
    for i, x in _pubrtbls
    for _, rtbl in zip(zones, [r for _, r in x])
]

# Create the list of items to return
_items = [
    i for x in [
        subnetsets, acs, eips, natgateways,
        ngwRoutes, igwRoutes
    ]
    for i in x if i
]
