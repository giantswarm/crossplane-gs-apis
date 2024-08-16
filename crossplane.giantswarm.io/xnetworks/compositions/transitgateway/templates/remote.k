remoteAttachments = [
    {
        _resourceName = "tgwa-${appName}-${region}-${remoteVpc.name}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayVPCAttachment"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "applianceModeSupport": get(oxr, "spec.applianceModeSupport", "disable"),
                "dnsSupport": get(oxr, "spec.dnsSupport", "enable"),
                "ipv6Support": get(oxr, "spec.ipv6Support", "disable"),
                "region": get(remoteVpc, "region", region),
                "subnetIds": get(remoteVpc, "subnetIds", []),
                "tags": tags | {
                    Name: "${appName}-${region}-${remoteVpc.name}"
                }
                "transitGatewayDefaultRouteTableAssociation": get(oxr, "spec.defaultRouteTableAssociation", False),
                "transitGatewayDefaultRouteTablePropagation": get(oxr, "spec.defaultRouteTablePropagation", False),
                "transitGatewayId": tgwId,
                "vpcId": get(remoteVpc, "vpcId", ""),
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": gpcr(remoteVpc)
        }
    }
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    if all_true([
        tgwId,
        get(oxr, "spec.remoteVpcs", []),
    ])
]

attachmentAccepters = [
    {
        _resourceName = "tgwaa-${appName}-${region}-${remoteVpc.name}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayVpcAttachmentAccepter"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "region": get(remoteVpc, "region", region),
                "transitGatewayAttachmentId": get(remoteAttachementIds, remoteVpc.name, ""),
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": gpcr(remoteVpc)
        }
    }
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    if all_true([
        get(oxr, "spec.remoteVpcs", []),
        any_true([
            get(remoteVpc, "region", region) != region,
            gpcr(remoteVpc).name != get(oxr, "spec.providerConfigRef.name", ""),
        ]),
        get(remoteAttachementIds, remoteVpc.name, False),
    ])
]

remotePrefixLists = [
    i for r in [
        [
            mpl(
                remoteVpc.name,
                get(remoteVpc, "region", region),
                get(remoteVpc, "addressFamily", "IPv4"),
                False,
                False,
                get(routingTables, "${remoteVpc.name}.vpc.open", {}),
                gpcr(remoteVpc),
            ),
            mpl(
                remoteVpc.name,
                get(remoteVpc, "region", region),
                get(remoteVpc, "addressFamily", "IPv4"),
                True,
                False,
                get(routingTables, "${remoteVpc.name}.vpc.blackhole", {}),
                gpcr(remoteVpc),
            ),
        ]
        for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    ] for i in r
]

remotePrefixListIds = {
    "${rVpc.name}": [
        c for c in [
            ocdsstatus("mpl-${appName}-${region}-${rVpc.name}", "id", "")
            ocdsstatus("mpl-${appName}-${region}-${rVpc.name}-bh", "id", False)
        ] if c
    ] + [
        c for c in [
            get(pl, "id", "")
            for _, pl in get(rVpc, "prefixLists", [])
            if all_true([
                get(pl, "id", False),
                get(pl, "outbound", True),
            ])
        ]
    ]
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}

remoteRoutes = [
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
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "destinationPrefixListId": pl,
                "routeTableId": id,
                "region": get(remoteVpc, "region", region),
                "transitGatewayId": tgwId,
            },
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": gpcr(remoteVpc),
        }
    }
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    for _, id in get(remoteVpc, "routeTableIds", [])
    for pl in get(remotePrefixListIds, remoteVpc.name, [])
    if all_true([
        tgwId, remotePrefixListIds,
    ])
]

remotePropagation = [
    {
        _resourceName = "tgwrtp-${appName}-${region}-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1",
        "kind": "TransitGatewayRouteTablePropagation",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName,
                "krm.kcl.dev/ready" = readystr(_resourceName),
            },
            "labels": labels | {
                "vpcName": appName,
            }
        },
        "spec": {
            "deletionPolicy": dp,
            "forProvider": {
                "region": region,
                "transitGatewayAttachmentId": id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr,
        },
    }
    for _, id in remoteAttachementIds
    if all_true([
        remoteAttachementIds,
        tgwRouteTableId,
    ])
]

_items = [
    i for r in [
        remoteAttachments, attachmentAccepters,
        remotePrefixLists, remoteRoutes,
        remotePropagation,
    ]
    for i in r if i
]