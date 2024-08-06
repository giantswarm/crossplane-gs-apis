# ManagedPrefixLists

tgwLocalCidrs = [
    {"cidr": c, "description": "${appName} CIDR Block ${i}"}
    for i, c in [
        get(oxr, "status.vpcs.self.cidrBlock", "")
    ] + get(oxr, "status.vpcs.self.additionalCidrBlocks", [])
    if c
] + [
    e
    for _, pl in get(oxr, "spec.localVpc.prefixLists", [])
    for e in get(pl, "entries", [])
    if all_true([
        e,
        not get(pl, "tgwAttach", False),
        not get(pl, "id", False),
        not get(pl, "blackhole", False),
    ])
]

tgwLocalCidrsBh = [
    e
    for _, pl in get(oxr, "spec.localVpc.prefixLists", [])
    for i, e in get(pl, "entries", [])
    if all_true([
        e,
        not get(pl, "tgwAttach", False),
        not get(pl, "id", False),
        get(pl, "blackhole", False),
    ])
]

tgwLocalPrefixList = {
    "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
    "kind": "ManagedPrefixList"
    "metadata": {
        _resourceName = "lmpl-${appName}-${region}"
        "annotations": {
            "krm.kcl.dev/composition-resource-name": _resourceName
            "krm.kcl.dev/ready" = readystr(_resourceName)
        }
        "labels": labels | {
            "vpcName": appName
        }
    },
    "spec": {
        "addressFamily": get(oxr, "spec.localVpc.addressFamily", "IPv4"),
        "claimRef": get(oxr, "spec.claimRef", {}),
        "deletionPolicy": dp,
        "name": "${appName}-${region}-local",
        "entries": tgwLocalCidrs,
        "region": region,
        "tags": tags | {
            "Name": "${appName}-${region}"
        }
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": pcr,
    },
}

tgwLocalPrefixListBh = {
    "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
    "kind": "ManagedPrefixList"
    "metadata": {
        _resourceName = "lmpl-${appName}-${region}-bh"
        "annotations": {
            "krm.kcl.dev/composition-resource-name": _resourceName
            "krm.kcl.dev/ready" = readystr(_resourceName)
        }
        "labels": labels | {
            "vpcName": appName
        }
    },
    "spec": {
        "addressFamily": get(oxr, "spec.localVpc.addressFamily", "IPv4"),
        "claimRef": get(oxr, "spec.claimRef", {}),
        "deletionPolicy": dp,
        "name": "${appName}-${region}-local-bh",
        "entries": tgwLocalCidrsBh,
        "region": region,
        "tags": tags | {
            "Name": "${appName}-${region}"
        }
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": pcr,
    },
}

tgwLocalPrefixLists = [
    tgwLocalPrefixList,
    tgwLocalPrefixListBh,
]

tgwLocalPrefixListIds = [
    c for c in [
        {"id": ocdsstatus("lmpl-${appName}-${region}", "id", False), "blackhole": False},
        {"id": ocdsstatus("lmpl-${appName}-${region}-bh", "id", False), "blackhole": True},
    ] + [
        {"id": get(pl, "id", False), "blackhole": get(pl, "blackhole", False)}
        for _, pl in get(oxr, "spec.localVpc.prefixLists", [])
        if all_true([
            get(pl, "id", False),
            get(pl, "tgwAttach", False),
        ])
    ]
    if c.id
]

tgwLocalPrefixListReferences = [
    {
        _bh = "-bh" if get(pl, "blackhole", False) else ""
        _resourceName = "ltgwpl-${appName}-${region}${_bh}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPrefixListReference"
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
                "blackhole": pl.blackhole,
                "prefixListId": pl.id,
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}${_bh}",
                }
                "transitGatewayAttachmentId": get(localAttachmentIds, appName, ""),
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, pl in tgwLocalPrefixListIds
    if all_true([
        tgwId, pl.id,
        get(oxr, "spec.prefixList.enabled", False),
    ])
]

tgwRemoteCidrs = {
    "${rVpc.name}": [
        {"cidr": c "description": "${appName} remote vpc ${rVpc.name} CIDR Block ${i}"}
        for i, c in [
            get(oxr, "status.vpcs.${rVpc.name}.cidrBlocks", "")
        ] + get(oxr, "status.vpcs.${rVpc.name}.additionalCidrBlocks", [])
        if c
    ] + [
        e
        for _, pl in get(oxr, "spec.remoteVpcs.${rVpc.name}.prefixLists", [])
        for e in get(pl, "entries", [])
        if all_true([
            e,
            get(pl, "tgwAttach", False),
            not get(pl, "id", False),
            not get(pl, "blackhole", False),
        ])
    ]
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}

tgwRemoteCidrsBh = {
    "${rVpc.name}" = [
        e
        for _, pl in get(oxr, "spec.remoteVpcs.${rVpc.name}.prefixLists", [])
        for i, e in get(pl, "entries", [])
        if all_true([
            e,
            get(pl, "tgwAttach", False),
            not get(pl, "id", False),
            get(pl, "blackhole", False),
        ])
    ]
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
}


tgwRemotePrefixLists = [
    {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "ManagedPrefixList"
        "metadata": {
            _resourceName = "rmpl-${appName}-${region}-${remoteVpc.name}"
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp,
            "claimRef": get(oxr, "spec.claimRef", {}),
            "entries": get(tgwRemoteCidrs, remoteVpc.name, []),
            "managementPolicies": mgmtPolicy,
            "name": "${appName}-${region}-remote-${remoteVpc.name}",
            "region": get(remoteVpc, "region", region),
            "tags": tags | {
                "Name": "${appName}-${region}",
            }
        }
    }
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    if all_true([
        tgwId, tgwEnabled,
        get(oxr, "spec.prefixListSupport", False),
    ])
]

tgwRemotePrefixListsBh = [
    {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "ManagedPrefixList"
        "metadata": {
            _resourceName = "rmpl-${appName}-${region}-${remoteVpc.name}-bh"
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp,
            "claimRef": get(oxr, "spec.claimRef", {}),
            "entries": get(tgwRemoteCidrsBh, remoteVpc.name, []),
            "managementPolicies": mgmtPolicy,
            "name": "${appName}-${region}-remote-${remoteVpc.name}-bh",
            "region": get(remoteVpc, "region", region),
            "tags": tags | {
                "Name": "${appName}-${region}",
            }
        }
    }
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    if all_true([
        tgwId, tgwEnabled,
    ])
]

tgwRemotePrefixListIds = {
    "${rVpc.name}": [
        c for c in [
            {
                "id": ocdsstatus("rmpl-${appName}-${region}-${rVpc.name}", "id", False),
                "blackhole": False,
            },
            {
                "id": ocdsstatus("rmpl-${appName}-${region}-${rVpc.name}-bh", "id", False),
                "blackhole": True,
            },
        ] + [
            {
                "id": get(pl, "id", False),
                "blackhole": get(pl, "blackhole", False),
            }
            for i, pl in get(rVpc, "prefixLists", [])
            if all_true([
                get(pl, "id", False),
                get(pl, "tgwAttach", False),
            ])
        ]
    ]
    for _, rVpc in get(oxr, "spec.remoteVpcs", [])
    if all_true([
        tgwId, tgwEnabled,
        get(oxr, "spec.prefixListSupport", False),
    ])
}

tgwRemotePrefixListReferences = [
    {
        _id = get(remoteAttachementIds, name, "")
        _bh = "-bh" if pl.blackhole else ""
        _resourceName = "rtgwpl-${appName}-${region}-${_id}${_bh}-${i}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPrefixListReference"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": name
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "blackhole": pl.blackhole,
                "prefixListId": pl.id,
                "region": region,
                "tags": tags | {
                    Name: _resourceName,
                }
                "transitGatewayAttachmentId": _id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr,
        }
    }
    for name, remoteVpc in tgwRemotePrefixListIds
    for i, pl in remoteVpc
    if all_true([
        tgwId, tgwEnabled,
        get(pl, "id", False),
    ])
]

_items = [
    i for r in [
        tgwLocalPrefixLists, tgwRemotePrefixLists,
        tgwRemotePrefixListsBh,
        tgwLocalPrefixListReferences,
        tgwRemotePrefixListReferences,
    ] for i in r if i
]
