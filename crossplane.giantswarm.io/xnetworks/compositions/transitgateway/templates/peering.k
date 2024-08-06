# Transit Gateway Peering

tgwPeers = [
    {
        _resourceName = "tgw-peer-${appName}-${region}-${peer.name}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPeeringAttachment"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": peer.name
            }
        }
        "spec": {
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "peerAccountId": peer.accountId,
                "peerRegion": peer.region,
                "peerTransitGatewayId": peer.tgwId,
                "region": region,
                "tags": tags | {
                    Name: "${appName}-${region}-${peer.name}"
                }
                "transitGatewayId": tgwId,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": gpcr(peer)
        }
    }
    for peer in get(oxr, "spec.transitGatewayPeers", [])
    if all_true([
        tgwId, tgwEnabled,
    ])
]

peeringIds = [
    ocdsstatus("tgw-peer-${appName}-${region}-${peer.name}", "id", "")
    for peer in get(oxr, "spec.transitGatewayPeers", [])
    if ocdsstatus("tgw-peer-${appName}-${region}-${peer.name}", "id", False)
]

tgwPeeringAccepters = [
    {
        _resourceName = "tgw-peer-accepter-${appName}-${region}-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPeeringAttachmentAccepter"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "region": region,
                "transitGatewayAttachmentId": id,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _, id in peeringIds
    if tgwEnabled
]

pentries = {
    "${peer.name}": [
        {
            "cidr": p.cidr,
            "description": p.description,
        }
        for p in get(peer, "prefixLists", [])
        if not get(p, "blackhole", False)
    ]
    for peer in get(oxr, "spec.peers", [])
}

tgwPeerPrefixLists = {
    "${peer.name}": {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "ManagedPrefixList"
        "metadata": {
            _resourceName = "pmpl-${appName}-${region}-${peer.name}"
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "peer": peer.name
            }
        }
        "spec": {
            "deletionPolicy": dp,
            "entries": get(pentries, peer.name, []), # FIXME: rentriesbh is not defined
            "managementPolicies": mgmtPolicy,
            "name": "${appName}-${region}-remote-${peer.name}",
            "region": get(peer, "region", region),
            "tags": tags | {
                "Name": "${appName}-${region}",
            }
            "providerConfigRef": gpcr(peer)
        }
    }
    for _, peer in get(oxr, "spec.peers", [])
    if all_true([
        tgwId, tgwEnabled,
        not get(peer, "id", False),
    ])
}

tgwPeerPrefixListIds = {
    "${peer.name}": [
        c for c in [
            {
                "id":  ocdsstatus("pmpl-${appName}-${region}-${peer.name}", "id", ""),
                "blackhole": False,
            },
            {
                "id":  ocdsstatus("pmpl-${appName}-${region}-${peer.name}-bh", "id", ""),
                "blackhole": True,
            }
        ] + [
            {
                "id": get(pl, "id", False),
                "blackhole": get(pl, "blackhole", False),
            }
            for i, pl in get(peer, "prefixLists", [])
        ]
    ]
    for _, peer in get(oxr, "spec.peers", [])
    if all_true([
        tgwId, tgwEnabled,
        not get(peer, "id", False),
    ])
}

tgwPeerPrefixListReferences = [
    {
        _id = get(peerAttachmentIds, name, "")
        _bh = "-bh" if pl.blackhole else ""
        _resourceName = "ptrgwpol-${appName}-${region}-${_id}${_bh}-${i}"
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
    for name, peer in tgwPeerPrefixListIds
    for i, pl in peer
    if all_true([
        tgwId, tgwEnabled,
        tgwRouteTableId,
        get(pl, "id", False),
    ])
]

_items = [
    i for r in [
        tgwPeers,
        tgwPeeringAccepters,
        [p for _, p in tgwPeerPrefixLists],
] for i in r]