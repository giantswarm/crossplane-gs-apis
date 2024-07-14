import regex
_oxr = option("params").oxr
_dxr = option("params").dxr
_ocs = option("params").ocds

get = lambda x: any, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

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
_requestedSets = [
    c.public.count + c.private.count
    for c in get(_oxr, "spec.subnetsets.cidrs", [])
]

_zones = get(_oxr, "spec.availabilityZones", [ "a", "b", "c" ])

assert sum(_requestedSets)*len(_zones) < 200, """
    The number of subnet sets you are requesting will exceed the maximum number
    of subnets allowed by AWS. The sum of all counts multiplied by the number of
    availability zones must be less than 200.
"""

# The first entry in the `subnetsets.cidrs` list is the primary CIDR range for
# the VPC.
#
# The remaining entries are additional CIDR ranges that can be attached with AWS
# allowing up to 4 additional CIDR ranges.
_additionalCidrs = [
    s.prefix
    for s in _oxr.spec.subnetsets.cidrs[1:]
]

# The name of the application is used to prefix all resources
_calculatedCidrs = get(_oxr, "status.calculatedCidrs", {})
_claimRef = get(_oxr, "spec.claimRef", {})
_appName = get(_claimRef, "name", "")

_clusterTags = get(_oxr, "spec.tags.cluster", {})
_dp = get(_oxr, "spec.deletionPolicy", "Delete")
_labels = get(_oxr, "metadata.labels", {})
_pcr = get(_oxr, "spec.providerConfigRef", {})
_region = get(_oxr, "spec.region", "eu-central-1")

_peeringEnabled = get(_oxr, "spec.peering.enabled", False)
_tags = _labels | get(_oxr, "spec.tags.common", {}) | {
    region: _region,
}

# Created checks
_vpcs = get(_oxr, "status.vpcs", {})
_self = get(_vpcs, "self", {})

_peeringConnections = [
    p.Resource for _, p in _ocs if _ocs and p.Resource.kind == "VPCPeeringConnection"
]
_peeringCreated = len(_peeringConnections) == len(_peering)

_ngw = [
    ngw.Resource for _, ngw in _ocs if _ocs and ngw.Resource.kind == "NATGateway"
]
_natgatewaysCreated = len([ngw for ngw in _ngw if ngw]) == len(_zones)

_pubRtblFilter = []
_priRtblFilter = []

# Separate out created public and private subnets
_pubsn = [
    x
    for _, x in get(_self, "publicSubnets", [])
    if _self and get(_self, "publicSubnets", False)
]
_prisn = [
    x
    for _, x in get(_self, "privateSubnets", [])
    if _self and get(_self, "privateSubnets", False)
]

# Create the SubnetSets
#
# SubnetSets are a collection of Subnets and RouteTables per availability zone
# Each set logically belongs together as they share consecutive CIDR ranges
# and have one subnet and one route table per requested availability zone (3)
_subnetsets = [
    {
        _subnets = chunksplit(len(_zones), _calculatedCidrs[s.prefix])
        _visibility = "public" if i < s.public.count else "private"
        _index = i if _visibility == "public" else i - s.public.count

        # this is needed for tagging the subnet sets independently of each other
        # it creates a '-' (hyphen) separated copy of the IP address from the first
        # subnet + the last 2 octets from the last subnet, e.g. 192-168-0-0-2-0
        _s1 = regex.split(_subnets[i][0], "/")[0]
        _s1hyphened = regex.replace(_s1, "\.", "-")

        _s2 = regex.split(_subnets[i][len(_zones)-1], "/")[0]
        _s2octs = regex.split(_s2, "\.")
        _suffix = _s1hyphened + "-" + _s2octs[2] + "-" + _s2octs[3]
        _snlbtag = {
            **_clusterTags
            "kubernetes.io/role/elb": "1"
        } if _index == s.public.lbSetIndex and _visibility == "public" else {
            **_clusterTags
            "kubernetes.io/role/internal-elb": "1"
        } if _index == s.private.lbSetIndex and _visibility == "private" else {}

        apiVersion: "xnetworks.crossplane.giantswarm.io/v1alpha1"
        kind: "SubnetSet"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "subnetset-${_visibility}-cidr${c}-${_index}"
            }
            labels = _labels | {access: _visibility, index: _index}
        }
        spec: {
            appIndex: _suffix
            claimRef: _claimRef
            deletionPolicy: _dp
            region: _region
            providerConfigRef: _pcr
            subnets: {
                "a": {
                    cidrBlock: _subnets[i][0]
                    zone: _zones[0]
                }
                "b": {
                    cidrBlock: _subnets[i][1]
                    zone: _zones[1]
                }
                "c": {
                    cidrBlock: _subnets[i][2]
                    zone: _zones[2]
                }
            }
            type: _visibility
            tags: {
                "all": _tags | get(_oxr, "spec.tags.subnet", {})
                "subnet": _snlbtag
            }
            vpcId: _self.id
        }
    }
    for c, s in _oxr.spec.subnetsets.cidrs
    for i in range(s.public.count + s.private.count)
    if _calculatedCidrs and _self and _self.id
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
_subnetsets = _fpubss + _fpriss

# Create Additional VPC CIDRs
#
# Each VPC may have up to 4 additional CIDRs attached
_acs = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "VPCIPv4CidrBlockAssociation"
        metadata: {
            labels: _labels
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "cidrassoc-${i}"
            }
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                cidrBlock: cidr
                region: _region
                vpcIdSelector: {
                    matchControllerRef: True
                }
            }
            _providerConfigRef: _pcr
        }
    }
    for i, cidr in _additionalCidrs
]

# Create Elastic IPs for the nat gateways
#
# Each NAT Gateway must be associated with an EIP
_eips = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "EIP"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "eip-${i}"
            }
            labels: _labels | {
                availabilityZone: az
                utilization: "nat-gateway"
            }
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                domain: "vpc"
                region: _region
                tags: _tags | {Name: "${_appName}-${_region}${az}-${i}"}
            }
            _providerConfigRef: _pcr
        }
    }
    for i, az in _zones if _pubsn
]

# NAT Gateways
#
# One NatGateway per availability zone is created and attached
# to the first available public subnet set
_keys = [k for k in _pubsn[0]] if _pubsn and len(_pubsn) > 0 and len(_pubsn[0]) == len(_zones) else []
_natgateways = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "NATGateway"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "ngw-${i}"
            }
            labels: {availabilityZone: az} | _labels
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                allocationIdSelector: {
                    matchControllerRef: True
                    matchLabels: {availabilityZone: az}
                }
                region: _region
                subnetId: _pubsn[0][_keys[i]]
                tags: {Name: "${_appName}-${_region}${az}"} | _tags
            }
            _providerConfigRef: _pcr
        }
    }
    for i, az in _zones
    if all_true([
        _pubsn,
        len(_keys) > 0,
        len(_pubsn) > 0,
        _eips
    ])
]

_prirtbls = [
    x
    for _, x in get(_self, "privateRouteTables", [])
    if _self and get(_self, "privateRouteTables", False)
]

# Nat Gateway Routes
#
# One route per private route table
_ngwRoutes = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "Route"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "ngw-rt-${rtbl[1]}-${i}"
            }
            labels: {availabilityZone: rtbl[0]} | _labels | {routeType: "ngw"}
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                destinationCidrBlock: "0.0.0.0/0"
                natGatewayIdSelector: {
                    matchControllerRef: True
                    matchLabels: {availabilityZone: rtbl[0]}
                }
                region: _region
                routeTableId: rtbl[1]
            }
            providerConfigRef: _pcr
        }
    }
    for i, x in _prirtbls
    for _, rtbl in zip(_zones, [r for _, r in x])
    if _pubsn and _natgatewaysCreated
]

_pubrtbls = [
    x
    for _, x in get(_self, "publicRouteTables", [])
    if _self and get(_self, "publicRouteTables", False)
]

# Internet Gateway Routes
#
# One IGW route per public route table
_igwRoutes = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "Route"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "igw-rt-${rtbl[1]}-${i}"
            }
            labels: {availabilityZone: rtbl[0]} | _labels | {routeType: "igw"}
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                destinationCidrBlock: "0.0.0.0/0"
                gatewayIdSelector: {
                    matchControllerRef: True
                }
                region: _region
                routeTableId: rtbl[1]
            }
            providerConfigRef: _pcr
        }
    }
    for i, x in _pubrtbls
    for _, rtbl in zip(_zones, [r for _, r in x])
]

# Create Peering connections
#
# One peering connection per remote VPC is created
_peering = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "VPCPeeringConnection"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "peering-${x.name}"
            }
            labels: _labels | {vpcName: x.name}
        }
        spec: {
            deletionPolicy: _dp
            _peerRegion = get(_vpcs, "${x.name}.region", _region)
            forProvider: {
                if _peerRegion == _region:
                    autoAccept: True
                if _peerRegion != _region:
                    autoAccept: False
                    peerRegion: _peerRegion
                peerVpcId: get(_vpcs, "${x.name}.id", "")
                region: _region
                tags: {Name: "${_appName}-${_region}-${x.name}"} | _tags
                vpcId: _self.id
            }
            providerConfigRef: _pcr
        }
    }
    for x in get(_oxr, "spec.peering.remoteVpcs", [])
    if all_true([
        _vpcs, _self,
        _vpcs[x.name],
        get(_oxr, "spec.peering.enabled", False),
        _self.id
    ])
]

_accepters = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "VPCPeeringConnectionAccepter"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "accepter-${x.name}"
            }
            labels: _labels | {vpcName: x.name}
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                autoAccept: True
                accepter: [
                    {
                        allowRemoteVpcDnsResolution: True
                    }
                ]
                region: x.region
                vpcPeeringConnectionId: get(_ocs, "peering-${x.name}.Resource.status.atProvider.id", "")
                tags: {Name: "${_appName}-${_region}-${x.name}"} | _tags
            }
            providerConfigRef: _pcr
        }
    }
    for _, x in get(_oxr, "spec.peering.remoteVpcs", [])
    if all_true([
        get(x, "region", _region) != _region
        get(_ocs, "peering-${x.name}.Resource.status.atProvider.id", False)
    ])
]

# Set up filters for the route tables.
#
# These are used to filter out subnets that should not be peered with
# the remote VPCs
_pubRtblFilter = [
    c not in get(_oxr, "spec.subnetsets.${k}.public.excludeFromPeering", [])
    for i, k in [k for k in get(_oxr, "spec.subnetsets", {})]
    for c in range(get(_oxr, "spec.subnetsets.${k}.public.count", 0))
]
_peeringFilteredPubRtbls = [
    x
    for i, x in get(_self, "publicRouteTables", [])
    if _self and get(_self, "publicRouteTables", False) and _peeringEnabled # and _pubRtblFilter[i]
]

_priRtblFilter = [
    c not in get(_oxr, "spec.subnetsets.${k}.private.excludeFromPeering", [])
    for i, k in [k for k in get(_oxr, "spec.subnetsets", {})]
    for c in range(get(_oxr, "spec.subnetsets.${k}.private.count", 0))
]
_peeringFilteredPriRtbls = [
    x
    for i, x in get(_self, "privateRouteTables", [])
    if _self and get(_self, "privateRouteTables", False) and _peeringEnabled # and _priRtblFilter[i]
]

# This is the most complicated part of the setup, adding the peering connections
# to the route tables
#
# The following blocks of code map route tables to CIDR ranges on either side of
# the VPC peering connection.
#
# Remote VPC route tables take the CIDR range(s) of the VPC created by this
# composition whilst route tables created by this composition take the remote
# CIDR range(s)
#
# It is possible to disable peering on public route tables but not private route
# tables in this composition. The options available are: public+private or
# private only

# First lets build a mapping from our own CIDR blocks to every route table that
# is not ours
_rmtTables = [] if not _vpcs else [
    {"id" = id, "vpcCidr" = cidr, "selector" = name, "region" = get(vpc, "region", _region)}
    for cidr in [_self.cidrBlock] + _additionalCidrBlocks
    for name, vpc in _vpcs
    for id in [
        i for r in get(vpc, "publicRouteTables", [])
        for _, i in r
        if allowsPublic(name)
    ] + [
        i for r in get(vpc, "privateRouteTables", [])
        for _, i in r
    ]
    if all_true([
        vpc,
        cidr,
        get(vpc, "publicRouteTables", False),
        get(vpc, "privateRouteTables", False),
        name != "self"
    ])
]

# Then map all remote CIDRs to our own route tables
#
# This is slightly different to the above as the `allowPublic` flag doesn't
# need to be discovered for the current VPC (static location)
_additionalCidrBlocks = _self.additionalCidrBlocks if _self and "additionalCidrBlocks" in _self else []
_myRouteTables = [
    {
        id = i,
        vpcCidr = cidr,
        selector = name
        region = _region
    }
    for _, index in [
        r for r in _peeringFilteredPubRtbls
        if get(_oxr, "spec.peering.allowPublic", False) and _peeringFilteredPubRtbls
    ] + [
        r for r in _peeringFilteredPriRtbls
        if _peeringFilteredPriRtbls
    ]
    for _, i in index
    for name, vpc in _vpcs
    for cidr in [get(vpc, "cidrBlock", "")] + get(vpc, "additionalCidrBlocks", [])
    # There is no peering connection with `self` as a selector
    if all_true([
        _vpcs,
        _self,
        name != "self",
        cidr
    ])
]

# Create the Peering routes
#
# This is achieved by combining the two lists _rmtTables and _myRouteTables
# and then creating a route for each, with the peering ID selector set to the
# name of the peering connection for that VPC
_peeringRoutes = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "Route"
        metadata: {
            annotations: {
                _c = regex.replace(r.vpcCidr, "\.", "-")
                "krm.kcl.dev/composition-resource-name" = "peering-rt-${_c}-${r.id}"
            }
            labels: _labels | {routeType: "peering", vpcName: r.selector}
        }
        spec: {
            deletionPolicy: _dp
            forProvider: {
                destinationCidrBlock: r.vpcCidr
                routeTableId: r.id
                region: r.region
                vpcPeeringConnectionIdSelector: {
                    matchControllerRef: True
                    matchLabels: {
                        vpcName: r.selector
                    }
                }
            }
            providerConfigRef: _pcr
        }
    }
    for i, r in _rmtTables + _myRouteTables
    # only create if peering is enabled and we have a VPC ID and peering
    # connections have been created
    if all_true([
        _self,
        _self.id,
        _oxr.spec.peering.enabled,
        _peeringCreated
    ])
]

# Create the list of items to return
_items = [
    _subnetsets, _acs, _eips, _natgateways,
    _ngwRoutes, _igwRoutes, _peering,
    _accepters, _peeringRoutes
]

# flatten items and exclude any empty elements
items = [i for x in _items for i in x if i]
