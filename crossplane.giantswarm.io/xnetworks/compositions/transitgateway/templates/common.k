import regex
oxr = option("params").oxr
dxr = option("params").dxr
ocds = option("params").ocds
dcds = option("params").dcds

exists = lambda x: any -> bool {
    """
    Check if a value exists.
    """
    x in list(ocds)
}

get = lambda x: {:}, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

gpcr = lambda x: {:} -> {:} {
    """
    Get the ProviderConfigRef from the given object

    If this is not set it will attempt to return the ProviderConfigRef from
    the Observed Composite Resource, and if that isn't set, will return an
    object with an empty name.
    """
    get(x, "providerConfigRef", get(oxr, "spec.providerConfigRef", {name: ""}))
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    _x = None
    if get(ocds, "${x}.Resource.status.atProvider", False):
        _x = get(ocds, "${x}.Resource.status.atProvider.${y}", d)
    else:
        _x = get(ocds, "${x}.Resource.status.${y}", d)
    _x if _x else d
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditionsReady = all_true([
        get(c, "status", "False") == "True" for c in ocdsstatus(x, "conditions", [])
    ])

    ap = get(ocds, "${x}.Resource.status.atProvider", {})
    objectReady = any_true([
        ocdsstatus(x, "ready", False),
        len(list(ap)) > 0,
    ])

    all_true([
        any_true([exists(x), conditionsReady]),
        objectReady,
    ])
}

readystr = lambda x: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(x) else "False"
}

allReady = lambda -> bool {
    """
    Check if all managed resources are ready.
    """
    all_true([
        ready(x)
        for x in list(ocds)
    ])
}

appName = get(oxr, "spec.claimRef.name", "")
dp = get(oxr, "spec.deletionPolicy", "Delete")
labels = get(oxr, "metadata.labels", {})
localVpc = get(oxr, "spec.localVpc", {})
pcr = get(oxr, "spec.providerConfigRef", {"name": "default"})
region = get(oxr, "spec.localVpc.region", "eu-central-1")
tags = get(oxr, "spec.tags", {}) | {
    "region": region,
} | labels

localAttachmentIds = {
    "${appName}": ocdsstatus("tgwa-${appName}-${region}", "id", "")
    for _ in [True]
    if ocdsstatus("tgwa-${appName}-${region}", "id", False)
}

mgmtPolicy = get(oxr, "spec.managementPolicies", [])

publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})
tgwArn = ocdsstatus("transitgateway-${appName}-${region}", "arn", False)
tgwId = ocdsstatus("transitgateway-${appName}-${region}", "id", False)
tgwRouteTableId = ocdsstatus("tgwrt-${appName}-${region}", "id", False)

remoteAttachementIds = {
    "${remoteVpc.name}": ocdsstatus("tgwa-${appName}-${region}-${remoteVpc.name}", "id", "")
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    if ocdsstatus("tgwa-${appName}-${region}-${remoteVpc.name}", "id", False)
}

peerAttachmentIds = {
    "${peer.name}": ocdsstatus("tgwa-${appName}-${region}-${peer.name}", "id", "")
    for _, peer in get(oxr, "spec.peers", [])
    if ocdsstatus("tgwa-${appName}-${region}-${peer.name}", "id", False)
}

routingTables = {
    "${appName}": {
        "vpc": {
            "open": [
                # Outbound from the local VPC needs the remote cidr blocks
                {
                    "cidr": cidr,
                    "description": "${remoteVpc.name} CIDR Block ${i}",
                }
                for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
                for i, cidr in get(remoteVpc, "cidrBlocks", [])
            ] + [
                e
                for _, pl in get(localVpc, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    get(pl, "outbound", False),
                    not get(pl, "id", False),
                    not get(pl, "blackhole", False),
                ])
            ],
            "blackhole": [
                e
                for _, pl in get(localVpc, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    get(pl, "outbound", False),
                    not get(pl, "id", False),
                    get(pl, "blackhole", False),
                ])
            ]
        },
        "tgw": {
            "open": [
                e
                for _, pl in get(localVpc, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    not get(pl, "outbound", True),
                    not get(pl, "id", False),
                    not get(pl, "blackhole", False),
                ])
            ],
            "blackhole": [
                e
                for _, pl in get(localVpc, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    not get(pl, "outbound", True),
                    not get(pl, "id", False),
                    get(pl, "blackhole", False),
                ])
            ]
        }
    }
} | {
    "${r.name}": {
        "vpc": {
            "open": [
                # Add the primary VPC cidr blocks
                {
                    "cidr": cidr,
                    "description": "${appName} CIDR Block ${i}",
                }
                for i, cidr in get(localVpc, "cidrBlocks", [])
            ] + [
                # Add the remote VPC cidr blocks where the remote VPC is not the
                # same as the current VPC
                {
                    "cidr": cidr,
                    "description": "${remoteVpc.name} CIDR Block ${i}",
                }
                for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
                for i, cidr in get(remoteVpc, "cidrBlocks", [])
                if all_true([
                    remoteVpc.name != r.name,
                ])
            ] + [
                # Add any prefix list entries that need creating
                e
                for _, pl in get(r, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    get(pl, "outbound", False),
                    not get(pl, "id", False),
                    not get(pl, "blackhole", False),
                ])
            ],
            "blackhole": [
                e
                for _, pl in get(r, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    get(pl, "outbound", False),
                    not get(pl, "id", False),
                    get(pl, "blackhole", False),
                ])
            ]
        },
        "tgw": {
            "open": [
                e
                for _, pl in get(r, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    not get(pl, "outbound", True),
                    not get(pl, "id", False),
                    not get(pl, "blackhole", False),
                ])

            ],
            "blackhole": [
                e
                for _, pl in get(r, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    not get(pl, "outbound", True),
                    not get(pl, "id", False),
                    get(pl, "blackhole", False),
                ])
            ]
        }
    }
    for _, r in get(oxr, "spec.remoteVpcs", [])
} | {
    "peering-${peer.name}": {
        "remote": {
            "open": [
                e
                for _, pl in get(peer, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    get(pl, "outbound", False),
                    not get(pl, "id", False),
                    not get(pl, "blackhole", False),
                ])
            ],
            "blackhole": [
                e
                for _, pl in get(peer, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    get(pl, "outbound", False),
                    not get(pl, "id", False),
                    get(pl, "blackhole", False),
                ])
            ]
        },
        "tgw": {
            "open": [
                e
                for _, pl in get(peer, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    not get(pl, "outbound", True),
                    not get(pl, "id", False),
                    not get(pl, "blackhole", False),
                ])
            ],
            "blackhole": [
                e
                for _, pl in get(peer, "prefixLists", [])
                for e in get(pl, "entries", [])
                if all_true([
                    e,
                    not get(pl, "outbound", True),
                    not get(pl, "id", False),
                    get(pl, "blackhole", False),
                ])
            ]
        }
    }
    for _, peer in get(oxr, "spec.peers", [])
}

mpl = lambda n : str, r: str, a: str, b: bool, isp: bool, e: [], p: {:} -> {:} {
    """
    Create a ManagedPrefixList object.

    n: The name of the ManagedPrefixList
    r: The region the ManagedPrefixList is in
    a: The address family of the ManagedPrefixList
    b: Whether the ManagedPrefixList is a blackhole
    isp: Whether the ManagedPrefixList is for a peering connection
    e: The entries for the ManagedPrefixList
    p: The ProviderConfigRef for the ManagedPrefixList

    Returns a ManagedPrefixList object.
    """
    _bh = "-bh" if b else ""
    _n = "${appName}-${region}-${n}${_bh}" if n != appName else "${appName}-${region}${_bh}"
    _isp = "-tgw" if isp else ""
    _resourceName = "mpl-${_n}" if not isp else "p-mpl-${_n}"
    {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1",
        "kind": "ManagedPrefixList",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName,
                "krm.kcl.dev/ready": readystr(_resourceName),
            },
            "labels": labels | {
                "vpcName" = n,
            },
        },
        "spec": {
            "addressFamily": a,
            "claimRef": get(oxr, "spec.claimRef", {}),
            "deletionPolicy": dp,
            "entries": e,
            "managementPolicies": mgmtPolicy,
            "name": "${_n}${_isp}",
            "region": r,
            "providerConfigRef": p,
            "tags": tags | {
                "Name": "${_n}${_isp}",
            },
        }
    } if len(e) > 0 else {}
}

plr = lambda n : str, r: str, pid: str, aid: str, rid: str, b: bool, isp: bool, p: {:} -> {:} {
    """
    Create a TransitGatewayPrefixListReference object.

    n: The name of the PrefixList reference
    r: The region the PrefixList reference should be created in
    b: Whether the PrefixList is a blackhole
    pid: The PrefixListId for the PrefixList reference
    aid: The TransitGatewayAttachmentId for the PrefixList reference
    rid: The TransitGatewayRouteTableId for the PrefixList reference
    isp: Whether the PrefixList reference is for a peering connection
    p: The ProviderConfigRef for the PrefixList

    Returns a TransitGatewayPrefixListReference object.
    """
    {
        _bh = "-bh" if b else ""
        _n = "${appName}-${region}-${n}${_bh}" if n != appName else "${appName}-${region}${_bh}"
        _resourceName = "tgwplr-${aid}" if not isp else "p-tgwplr-${aid}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1",
        "kind": "TransitGatewayPrefixListReference",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName,
                "krm.kcl.dev/ready": readystr(_resourceName),
            },
            "labels": labels | {
                "vpcName" = n,
            } if not isp else {
                "peerName" = n,
            },
        },
        "spec": {
            "deletionPolicy": dp,
            "forProvider": {
                "blackhole": b,
                "prefixListId": pid,
                "region": r,
                "transitGatewayAttachmentId": aid,
                "transitGatewayRouteTableId": rid,
            },
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": p,
        }
    } if all_true([
        pid, aid, rid,
    ]) else {}
}

remotePrefixListIds = {
    "${rVpc.name}": [
        c for c in [
            ocdsstatus("mpl-${appName}-${region}-${rVpc.name}", "id", "")
            ocdsstatus("mpl-${appName}-${region}-${rVpc.name}-bh", "id", "")
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

sharedPrefixLists: [str] = [
    c for r in [
        [
            ocdsstatus("mpl-${appName}-${region}-${rVpc.name}", "arn", ""),
            ocdsstatus("mpl-${appName}-${region}-${rVpc.name}-bh", "arn", ""),
        ]
        for _, rVpc in get(oxr, "spec.remoteVpcs", [])
        if rVpc.accountId != get(oxr, "spec.localVpc.accountId", "")
    ]
    for c in r if c
]
