appName = get(oxr, "spec.claimRef.name", "")
dp = get(oxr, "spec.deletionPolicy", "Delete")
labels = get(oxr, "metadata.labels", {})
pcr = get(oxr, "spec.localVpcDetails.providerConfigRef", get(oxr, "spec.providerConfigRef", {}))

if not get(oxr, "spec.localVpcDetails.region", False):
    assert False, "localVpcDetails.region is required"

localVpcName = get(oxr, "spec.localVpcDetails.name", "")
region = get(oxr, "spec.localVpcDetails.region", "eu-central-1")
remoteRegion = get(oxr, "spec.peerVpcDetails.region", region)
remoteVpcName = get(oxr, "spec.peerVpcDetails.name", "")
tags = labels | get(oxr, "spec.tags.common", {}) | {
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
                "peerVpcId": get(oxr, "spec.peerVpcDetails.vpcId", "")
                "region": region
                "tags": tags | {
                    Name: "${appName}-${region}-${remoteVpcName}"
                }
                "vpcId": get(oxr, "spec.localVpcDetails.vpcId", "")
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True] if all_true([
        get(oxr, "spec.localVpcDetails.vpcId", False),
        get(oxr, "spec.peerVpcDetails.vpcId", False),
        region,
        remoteRegion,
        pcr,
    ])
]

peeringId = ocdsstatus("peering-${remoteVpcName}", "id", False)
peeringCreated = peeringId and ready("peering-${remoteVpcName}")

options = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "VPCPeeringConnectionOptions"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "${appName}-peering-options"
                "krm.kcl.dev/ready": readystr("${appName}-peering-options")
            }
        }
        "spec": {
            "deletionPolicy": dp,
            "forProvider": {
                "accepter": [
                    {
                        "allowRemoteVpcDnsResolution": True
                    }
                ]
                "region": region,
                "requester": [
                    {
                        "allowRemoteVpcDnsResolution": True
                    }
                ]
                "vpcPeeringConnectionId": ocdsstatus("peering-${remoteVpcName}", "id", "")
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr,
        }
    }
    for _ in [True]
    if peeringCreated
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
                "vpcPeeringConnectionId": peeringId
                "tags": tags | {
                    Name: "${appName}-${region}-${remoteVpcName}"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _, x in get(oxr, "spec.peering.remoteVpcs", [])
    if all_true([
        remoteRegion != region
        peeringCreated
    ])
]

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
                "vpcPeeringConnectionId": peeringId
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for cidr in get(oxr, "spec.localVpcDetails.cidrBlocks", [])
    for routeTableId in get(oxr, "spec.peerVpcDetails.routeTableIds", [])
    if all_true([
        peeringCreated,
        get(oxr, "spec.localVpcDetails.cidrBlocks", False),
        get(oxr, "spec.peerVpcDetails.routeTableIds", False),
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
                "region": region
                "vpcPeeringConnectionId": peeringId
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for cidr in get(oxr, "spec.peerVpcDetails.cidrBlocks", [])
    for routeTableId in get(oxr, "spec.localVpcDetails.routeTableIds", [])
    if all_true([
        peeringCreated,
        get(oxr, "spec.peerVpcDetails.cidrBlocks", False),
        get(oxr, "spec.localVpcDetails.routeTableIds", False),
    ])
]

owner = ocdsstatus("peering-${remoteVpcName}", "peerOwnerId", "")
arn = "arn:aws:ec2:${region}:${owner}:vpc-peering-connection/${peeringId}"

newdxr = {
    **oxr,
    **{
        "status": {
            if peeringCreated:
                "peeringConnectionId" = peeringId
                "peeringConnectionArn" = arn
        }
    }
}

_items = [
    i for r in [peering, accepters, rmtRoutes, localRoutes, [newdxr]]
    for i in r
    if i
]
