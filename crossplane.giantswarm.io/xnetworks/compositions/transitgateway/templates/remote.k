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
        tgwEnabled, tgwId,
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
        tgwEnabled,
    ])
]

rentries =  {
    "${rVpc.name}": [
        x for r in [
            [
                {
                    "cidr": cidr,
                    "description": "${remoteVpc.name} CIDR Block ${i}",
                }
                for i, cidr in [
                    get(oxr, "status.vpcs.${remoteVpc.name}.cidrBlock", "")
                ] + get(oxr, "status.vpcs.${remoteVpc.name}.additionalCidrBlocks", [])
                if cidr
            ]
            # Add self VPC to the list here so we capture its CIDRs for the other end
            for _, remoteVpc in get(oxr, "spec.remoteVpcs", []) + [{"name": "self"}]
            if remoteVpc.name != rVpc.name
        ] + [
            [
                {
                    "cidr": e.cidr,
                    "description": "${appName} CIDR Block ${i}",
                }
                for _, pl in get(rVpc, "prefixLists", [])
                for i, e in get(pl, "entries", [])
                if not get(pl, "blackhole", False)
            ]
        ]
        for x in r if x
    ]
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}

rentriesbh = {
    "${rVpc.name}": [
        e
        for _, pl in get(rVpc, "prefixLists", [])
        for i, e in get(pl, "entries", [])
        if get(pl, "blackhole", False)
    ]
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}

rmpl = {
    "${rVpc.name}": {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "ManagedPrefixList"
        "metadata": {
            _resourceName = "rmpl-${appName}-${region}-${rVpc.name}"
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": rVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp,
            "entries": get(rentries, rVpc.name, []),
            "managementPolicies": mgmtPolicy,
            "name": "${appName}-${region}-remote-${rVpc.name}",
            "region": get(rVpc, "region", region),
            "tags": tags | {
                "Name": "${appName}-${region}",
            }
        }
    }
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}

rmplbh = {
    "${rVpc.name}": {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "ManagedPrefixList"
        "metadata": {
            _resourceName = "rmpl-${appName}-${region}-${rVpc.name}"
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": rVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp,
            "entries": get(rentriesbh, rVpc.name, []),
            "managementPolicies": mgmtPolicy,
            "name": "${appName}-${region}-remote-${rVpc.name}",
            "region": get(rVpc, "region", region),
            "tags": tags | {
                "Name": "${appName}-${region}",
            }
        }
    }
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}

remotePrefixLists = [
    item
    for _, item in rmpl | rmplbh
    if item
]

remotePrefixListIds = {
    "${rVpc.name}": [
        ocdsstatus("rmpl-${appName}-${region}-${rVpc.name}", "id", "")
        ocdsstatus("rmpl-${appName}-${region}-${rVpc.name}-bh", "id", False)
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
        tgwId, tgwEnabled,
    ])
]

remotePropagation = [
    {
        _resourceName = "tgwrtp-${appName}-${region}-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayRouteTablePropagation"
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
                "region": region,
                "transitGatewayAttachmentId": id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _, id in remoteAttachementIds
    if all_true([
        remoteAttachementIds,
        tgwEnabled, tgwRouteTableId,
    ])
]

_items = [
    i for r in [
        remoteAttachments,
        attachmentAccepters,
        remotePrefixLists,
        remoteRoutes,
    ]
    for i in r
    if i
]