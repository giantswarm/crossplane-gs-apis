# Transit Gateway Peering

peerAttachments = [
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
                if get(peer, "dynamicRouting", None) != None:
                    "options": {
                        "dynamicRouting": "enabled" if peer.dynamicRouting else "disabled"
                    }
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
    for peer in get(oxr, "spec.peers", [])
    if tgwId
]

# If the peering attachment is in a remote region or account,
# we need to accept the peering attachment via a peering accepter.
peeringAccepters = [
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
    for _, id in peerAttachmentIds
    if len(list(peerAttachmentIds)) > 0
]

peerPrefixLists = [
    i for r in [
        [
            mpl(
                peer.name,
                get(peer, "region", region),
                get(peer, "addressFamily", "IPv4"),
                False,
                True,
                get(routingTables, "${peer.name}.remote.open", {}),
                gpcr(peer),
            ),
            mpl(
                peer.name,
                get(peer, "region", region),
                get(peer, "addressFamily", "IPv4"),
                True,
                True,
                get(routingTables, "${peer.name}.remote.blackhole", {}),
                gpcr(peer),
            ),
        ]
        for _, peer in get(oxr, "spec.peers", [])
    ] for i in r
]

peerPrefixListIds = {
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
        tgwId,
        not get(peer, "id", False),
    ])
}

# These create the prefix list references on the remote peer, not on the
# transit gateway created as part of this composition - see tgw/resources for that
peerPrefixListReferences = [
    {
        _id = peer.id
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
                "peerName": peer.name
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
                "transitGatewayRouteTableId": peer.id,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr,
        }
    }
    for _, peer in get(oxr, "spec.peers", [])
    for i, pl in get(peerPrefixListIds, peer.name, {})
    if all_true([
        tgwId, peer,
        get(peer, "id", False),
        get(peerPrefixListIds, peer.name, False),
    ])
]

_items = [
    i for r in [
        peerAttachments, peeringAccepters,
        peerPrefixLists,
        peerPrefixListReferences,
] for i in r]