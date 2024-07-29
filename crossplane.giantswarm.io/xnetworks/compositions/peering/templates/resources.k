appName = get(_oxr, "spec.claimRef.name", "")
dp = get(_oxr, "spec.deletionPolicy", "Delete")
labels = get(_oxr, "metadata.labels", {})
pcr = get(_oxr, "spec.localVpcDetails.providerConfigRef", get(_oxr, "spec.providerConfigRef", {}))

if not get(_oxr, "spec.localVpcDetails.region", False):
    assert False, "localVpcDetails.region is required"

localVpcName = get(_oxr, "spec.localVpcDetails.name", "")
region = get(_oxr, "spec.localVpcDetails.region", "eu-central-1")
remoteRegion = get(_oxr, "spec.peerVpcDetails.region", region)
remoteVpcName = get(_oxr, "spec.peerVpcDetails.name", "")
tags = labels | get(_oxr, "spec.tags.common", {}) | {
    region: region,
}

# Create Peering connections
#
# One peering connection per remote VPC is created
peering = [
    {
        _resourceName = "peering-${remoteVpcName}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "VPCPeeringConnection"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpcName
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                if remoteRegion == region:
                    "autoAccept": True
                else:
                    "autoAccept": False
                    "peerRegion": remoteRegion
                "peerVpcId": get(_oxr, "spec.peerVpcDetails.vpcId", "")
                "region": region
                "tags": tags | {
                    Name: "${appName}-${region}-${remoteVpcName}"
                }
                "vpcId": get(_oxr, "spec.localVpcDetails.vpcId", "")
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True] if pcr
]

accepters = [
    {
        _resourceName = "accepter-${remoteVpcName}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "VPCPeeringConnectionAccepter"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpcName
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "autoAccept": True
                "accepter": [
                    {
                        "allowRemoteVpcDnsResolution": True
                    }
                ]
                "region": remoteRegion
                "vpcPeeringConnectionId": ocdsstatus("peering-${remoteVpcName}", "id", "")
                "tags": tags | {
                    Name: "${appName}-${region}-${remoteVpcName}"
                }
            }
            "providerConfigRef": pcr
        }
    }
    for _, x in get(_oxr, "spec.peering.remoteVpcs", [])
    if all_true([
        remoteRegion != region
        ready("peering-${remoteVpcName}")
    ])
]

peeringIds = [
    ocdsstatus("peering-${remoteVpcName}", "id", "")
    for _ in [True]
    if ready("peering-${remoteVpcName}")
]
peeringCreated = all_true([
    id != False
    for id in peeringIds
])

# Routes in the Remote VPC
rmtRoutes = [
    {
        _resourceName = "peering-rt-${routeTableId}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "Route"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": labels | {
                routeType = "peering",
                routeValue = "remote",
                vpcName = "${remoteVpcName}",
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "destinationCidrBlock": cidr
                "routeTableId": routeTableId
                "region": remoteRegion
                "vpcPeeringConnectionId": id
            }
            "providerConfigRef": pcr
        }
    }
    for cidr in get(_oxr, "spec.localVpcDetails.cidrBlocks", [])
    for routeTableId in get(_oxr, "spec.peerVpcDetails.routeTableIds", [])
    for id in peeringIds
    if all_true([
        peeringCreated,
        get(_oxr, "spec.localVpcDetails.cidrBlocks", False),
        get(_oxr, "spec.peerVpcDetails.routeTableIds", False),
    ])
]

localRoutes  = [
    {
        _resourceName = "peering-rt-${routeTableId}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "Route"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": labels | {
                "routeType" = "peering",
                "routeValue" = "local",
                "vpcName" = "${localVpcName}"
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "destinationCidrBlock": cidr
                "routeTableId": routeTableId
                "region": remoteRegion
                "vpcPeeringConnectionId": id
            }
            "providerConfigRef": pcr
        }
    }
    for cidr in get(_oxr, "spec.peerVpcDetails.cidrBlocks", [])
    for routeTableId in get(_oxr, "spec.localVpcDetails.routeTableIds", [])
    for id in peeringIds
    if all_true([
        peeringCreated,
        get(_oxr, "spec.peerVpcDetails.cidrBlocks", False),
        get(_oxr, "spec.localVpcDetails.routeTableIds", False),
    ])
]

_items = [
    i for r in [peering, accepters, rmtRoutes, localRoutes]
    for i in r
    if i
]