import yaml
# Create the attachment to the local VPC
localAttachments = [
    {
        _resourceName = "tgwa-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayVPCAttachment"
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
                "applianceModeSupport": get(oxr, "spec.applianceModeSupport", "disable"),
                "dnsSupport": get(oxr, "spec.dnsSupport", "enable"),
                "ipv6Support": get(oxr, "spec.ipv6Support", "disable"),
                "region": region,
                "subnetIds": get(localVpc, "subnetIds", []),
                "tags": tags | {
                    Name: "${appName}-${region}"
                }
                "transitGatewayDefaultRouteTableAssociation": get(oxr, "spec.defaultRouteTableAssociation", False),
                "transitGatewayDefaultRouteTablePropagation": get(oxr, "spec.defaultRouteTablePropagation", False),
                "transitGatewayId": tgwId,
                "vpcId": get(localVpc, "vpcId", ""),
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwId, localVpc,
    ])
]

# Local VPC prefix lists
localPrefixLists = [
    mpl(
        appName,
        region,
        get(localVpc, "addressFamily", "IPv4"),
        False,
        False,
        get(routingTables, "${appName}.vpc.open", {}),
        pcr,
    ),
    mpl(
        appName,
        region,
        get(localVpc, "addressFamily", "IPv4"),
        True,
        False,
        get(routingTables, "${appName}.vpc.blackhole", {}),
        pcr,
    ),
]
print(yaml.encode(localPrefixLists))

prefixListIds = [
    c for c in [
        ocdsstatus("mpl-${appName}-${region}", "id", ""),
        ocdsstatus("mpl-${appName}-${region}-bh", "id", ""),
    ] if c
] + [
    c for c in [
        get(pl, "id", "")
        for pl in get(localVpc, "prefixLists", [])
        if all_true([
            get(pl, "id", False),
            get(pl, "outbound", True),
        ])
    ] if c
]

# Create the routes right at the end so we can set up
# the prefix lists properly first
localRoutes = [
    {
        _resourceName = "peering-rt-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "Route"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "routeType": "peering",
                "vpcName": appName
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "destinationPrefixListId": pl,
                "routeTableId": id,
                "region": region,
                "transitGatewayId": tgwId,
            },
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _, id in get(oxr, "spec.localVpc.routeTableIds", [])
    for pl in prefixListIds
    if tgwId
]

localPropagation = [
    {
        _resourceName = "propagation-rt-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1",
        "kind": "TransitGatewayRouteTablePropagation",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName,
                "krm.kcl.dev/ready" = readystr(_resourceName),
            },
            "labels": labels | {
                "vpcName": appName,
            },
        },
        "spec": {
            "deletionPolicy": dp,
            "forProvider": {
                "region": region,
                "transitGatewayAttachmentId": id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            },
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr,
        },
    }
    for _, id in localAttachmentIds
    if all_true([
        tgwRouteTableId,
    ])
]

_items = [
    i for r in [
        localAttachments, localPrefixLists,
        localRoutes, localPropagation,
    ]
    for i in r if i
]
