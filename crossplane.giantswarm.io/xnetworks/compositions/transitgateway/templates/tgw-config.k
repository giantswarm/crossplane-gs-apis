# ManagedPrefixLists

tgwLocalPrefixLists = [
    mpl(
        appName,
        region,
        get(oxr, "spec.addressFamily", "IPv4"),
        False,
        True,
        get(routingTables, "${appName}.tgw.open", {}),
        pcr,
    ),
    mpl(
        appName,
        region,
        get(oxr, "spec.addressFamily", "IPv4"),
        True,
        True,
        get(routingTables, "${appName}.tgw.blackhole", {}),
        pcr,
    ),
]

tgwRemotePrefixLists = [
    i for r in [
        [
            mpl(
                remoteVpc.name,
                get(remoteVpc, "region", region),
                get(remoteVpc, "addressFamily", "IPv4"),
                False,
                True,
                get(routingTables, "${remoteVpc.name}.tgw.open", {}),
                gpcr(remoteVpc),
            ),
            mpl(
                remoteVpc.name,
                get(remoteVpc, "region", region),
                get(remoteVpc, "addressFamily", "IPv4"),
                True,
                True,
                get(routingTables, "${remoteVpc.name}.tgw.blackhole", {}),
                gpcr(remoteVpc),
            ),
        ]
        for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    ] for i in r
]

tgwPeerPrefixLists = [
    i for r in [
        [
            mpl(
                peer.name,
                get(peer, "region", region),
                get(peer, "addressFamily", "IPv4"),
                False,
                True,
                get(routingTables, "${peer.name}.tgw.open", {}),
                gpcr(peer),
            ),
            mpl(
                peer.name,
                get(peer, "region", region),
                get(peer, "addressFamily", "IPv4"),
                True,
                True,
                get(routingTables, "${peer.name}.tgw.blackhole", {}),
                gpcr(peer),
            ),
        ]
        for _, peer in get(oxr, "spec.peers", [])
    ] for i in r
]

tgwLocalPrefixListIds = [
    c for c in [
        {
            "i" = ocdsstatus("p-mpl-${appName}-${region}", "id", False),
            "b" = False,
        },
        {
            "i" = ocdsstatus("p-mpl-${appName}-${region}-bh", "id", False),
            "b" = True,
        },
    ] + [
        {
            "i" = get(pl, "id", ""),
            "b" = get(pl, "blackhole", False),
        }
        for _, pl in get(localVpc, "prefixLists", [])
        if all_true([
            get(pl, "id", False),
            not get(pl, "outbound", True),
        ])
    ] if c.i
]

tgwRemotePrefixListIds = {
    "${remoteVpc.name}": [
        c for c in [
            {
                "i" = ocdsstatus("p-mpl-${appName}-${region}-${remoteVpc.name}", "id", False),
                "b" = False,
            },
            {
                "i" = ocdsstatus("p-mpl-${appName}-${region}-${remoteVpc.name}-bh", "id", False),
                "b" = True,
            },
        ] if c
    ] + [
        c for c in [
            {
                "i" = get(pl, "id", ""),
                "b" = get(pl, "blackhole", False),
            }
            for _, pl in get(remoteVpc, "prefixLists", [])
            if all_true([
                get(pl, "id", False),
                not get(pl, "outbound", True),
            ])
        ]
    ]
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
}

tgwPeerPrefixListIds = {
    "${peer.name}": [
        c for c in [
            {
                "i" = ocdsstatus("p-mpl-${appName}-${region}-${peer.name}", "id", False),
                "b" = False
            },
            {
                "i" = ocdsstatus("p-mpl-${appName}-${region}-${peer.name}-bh", "id", False),
                "b" = True
            },
        ] if c
    ] + [
        c for c in [
            {
                "i" = get(pl, "id", "")
                "b" = get(pl, "blackhole", False),
            }
            for _, pl in get(peer, "prefixLists", [])
            if all_true([
                get(pl, "id", False),
                not get(pl, "outbound", True),
            ])
        ]
    ]
    for _, peer in get(oxr, "spec.peers", [])
}

tgwManagedPrefixListIds = {
    "local": tgwLocalPrefixListIds,
    "remote": tgwRemotePrefixListIds,
    "peer": tgwPeerPrefixListIds,
}

print("TGW Managed Prefix List IDs", tgwManagedPrefixListIds)

tgwLocalPrefixListReferences = [
    plr(
        appName,
        region,
        id.i,
        get(localAttachmentIds, appName, ""),
        tgwRouteTableId,
        id.b,
        True,
        pcr,
    )
    for _, id in tgwLocalPrefixListIds
]

tgwRemotePrefixListReferences = [
    plr(
        rvpc.name,
        region,
        id.i,
        get(remoteAttachementIds, rvpc.name, ""),
        tgwRouteTableId,
        id.b,
        False,
        gpcr(rvpc),
    )
    for _, rvpc in get(oxr, "spec.remoteVpcs", [])
    for _, id in get(tgwRemotePrefixListIds, rvpc.name, [])
]

tgwPeerPrefixListReferences = [
    plr(
        appName,
        region,
        id.i,
        get(peerAttachmentIds, appName, ""),
        tgwRouteTableId,
        id.b,
        False,
        gpcr(peer),
    )
    for _, peer in get(oxr, "spec.peers", [])
    for _, id in peer
]

_items = [
    i for r in [
        tgwLocalPrefixLists, tgwRemotePrefixLists, tgwPeerPrefixLists,
        tgwLocalPrefixListReferences, tgwRemotePrefixListReferences,
        tgwPeerPrefixListReferences,
    ] for i in r if i
]
