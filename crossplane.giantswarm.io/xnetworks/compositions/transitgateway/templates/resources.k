# Create the main transit gateway
# The Id of this transit gateway will be published to oxr.status.tgwId
transitGateway = [
    {
        _resourceName = "transitgateway-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGateway"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": appName
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "amazonSideAsn": get(oxr, "spec.amazonSideAsn", 64512),
                "autoAcceptSharedAttachments": get(oxr, "spec.autoAcceptSharedAttachments", "disable"),
                "defaultRouteTableAssociation": "enable" if get(oxr, "spec.defaultRouteTableAssociation", False) else "disable",
                "defaultRouteTablePropagation": "enable" if get(oxr, "spec.defaultRouteTablePropagation", False) else "disable",
                "description": "${appName} Transit Gateway in ${region}",
                "dnsSupport": get(oxr, "spec.dnsSupport", "enable"),
                "multicastSupport": get(oxr, "spec.multicastSupport", "disable"),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}"
                },
                "transitGatewayCidrBlocks": [
                    get(oxr, "spec.transitGatewayCidrBlock", "")
                    for _ in [True]
                    if get(oxr, "spec.transitGatewayCidrBlock", False)
                ]
                "vpnEcmpSupport": get(oxr, "spec.vpnEcmpSupport", "enable"),
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if tgwEnabled
]


# Create the main transit gateway route table
# The Id of this route table will be published to oxr.status.tgwRouteTableId
tgwRouteTable = [
    {
        _resourceName = "tgwrt-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayRouteTable"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": appName
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}",
                }
                "transitGatewayId": tgwId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwId, tgwEnabled,
    ])
]

tgwPolicyTable = [
    {
        _resourceName = "tgwpt-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPolicyTable"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": appName
            }
        }
        "spec": {
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "region": region,
                "tags": tags | {
                    Name: "${appName}-${region}",
                }
                "transitGatewayId": tgwId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwId, tgwEnabled,
        get(oxr, "spec.createPolicyTable", True),
    ])
]

tgwAssociations = [
    {
        _resourceName = "tgwa-${appName}-${region}-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayRouteTableAssociation"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": appName
            }
        }
        "spec": {
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "region": region,
                "transitGatewayAttachmentId": id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": get(oxr, "spec.providerConfigRef", {})
        }
    }
    for _, id in localAttachmentIds | remoteAttachementIds
    if all_true([
        localAttachmentIds, remoteAttachementIds,
        tgwEnabled, tgwRouteTableId,
    ])
]

_items =  [
    i for r in [
        transitGateway,
        tgwRouteTable,
        tgwAssociations,
        tgwPolicyTable,
    ] for i in r if i
]
