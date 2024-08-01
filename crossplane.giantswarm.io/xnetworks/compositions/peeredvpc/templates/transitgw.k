_ram = get(_oxr, "spec.ram", {enabled: False})
_tgwRam = get(_oxr, "spec.transitGateway.ram", {enabled: False})

# If we have both RAM and TGW RAM enabled, we need to disable TGW RAM
# as it will be built as part of the VPC
if _tgwRam.enabled and _ram.enabled:
    _tgwRam.enabled = False

localRouteTableIds = [
    i.id for r in get(_oxr, "status.vpcs.self.publicRouteTables", [])
    for _, i in r
    if get(_oxr, "spec.transitGateway.allowPublic", True)
] + [
    i.id for r in get(_oxr, "status.vpcs.privateRouteTables", [])
    for _, i in r
]

preferPublic = get(_oxr, "spec.transitGateway.preferPublicAttachments", False)

# We can only use one subnet in each availability zone for the TGW attachment
localSubnetIds = [
    i.id for j, r in get(_oxr, "status.vpcs.self.publicSubnets", [])
    for _, i in r
    if all_true([
        j == 0
        get(_oxr, "spec.transitGateway.allowPublic", True)
        preferPublic
    ])
] if all_true([
    preferPublic,
    get(_oxr, "spec.transitGateway.allowPublic", True),
]) else [
    i.id for j, r in get(_oxr, "status.vpcs.self.privateSubnets", [])
    for _, i in r
    if j == 0
]

localVpc = {
    "cidrBlocks": [
        c for _, c in [
            get(_oxr, "status.vpcs.self.cidrBlock", "")
        ] + get(_oxr, "status.vpcs.self.additionalCidrBlocks", [])
        if c
    ],

    if get(_oxr, "spec.prefixLists", False):
        "prefixLists": [
            {
                blackhole: pl.blackhole,
                pl.id: get(_oxr, "status.prefixLists.${pl.name}", pl.name),
            }
            for _, pl in get(_oxr, "spec.prefixLists", [])
        ]

    "region": get(_oxr, "spec.region", ""),
    "routeTableIds": localRouteTableIds,
    "subnetIds": localSubnetIds,

    if get(_oxr, "status.vpcs.self.id", False):
        "vpcId": get(_oxr, "status.vpcs.self.id", ""),

} if all_true([
    get(_oxr, "status.vpcs.self.id", False)
    localRouteTableIds,
    localSubnetIds,
]) else {}

remoteVpcs = [
    {
        _subnetIds = [
            i.id for j, r in get(_oxr, "status.vpcs.${vpc.name}.publicSubnets", [])
            for _, i in r
            if all_true([
                j == 0
                get(vpc, "allowPublic", True)
                preferPublic
            ])
        ] if all_true([
            preferPublic,
            get(vpc, "allowPublic", True),
        ]) else [
            i.id for j, r in get(_oxr, "status.vpcs.${vpc.name}.privateSubnets", [])
            for _, i in r
            if j == 0
        ]
        "cidrBlocks": [
            c for _, c in [
                get(_oxr, "status.vpcs.${vpc.name}.cidrBlock", "")
            ] + get(_oxr, "status.vpcs.${vpc.name}.additionalCidrBlocks", [])
            if c
        ],
        "name": vpc.name,
        "region": get(_oxr, "status.vpcs.${vpc.name}.region", ""),
        "routeTableIds": [
            i.id for r in get(_oxr, "status.vpcs.${vpc.name}.publicRouteTables", [])
            for _, i in r
            if get(_oxr, "spec.transitGateway.allowPublic", True)
        ] + [
            i.id for r in get(_oxr, "status.vpcs.${vpc.name}.privateRouteTables", [])
            for _, i in r
        ],
        "subnetIds": _subnetIds,
        "vpcId": get(_oxr, "status.vpcs.${vpc.name}.id", ""),
    }
    for _, vpc in get(_oxr, "spec.transitGateway.remoteVpcs", [])
    if get(_oxr, "status.vpcs.${vpc.name}.id", False)
]

# Transit Gateway Peers
#
# For peer to peer TGWs, at the remote TGW must be attached to one of the remote
# VPCs.
#
# A possible future extention is to move `status.vpcs` down one level, maybe to
# `status.region.vpcs` to allow for multiple regions to be managed by the
# `network lookup` composition function. This would allow for discovery of
# additional components that fit outside of the current framework however it
# would be a huge breaking change on the API.
#
# Another option would be to
transitGatewayPeers = [
    {
        _aid = getwparentfb(peer, _oxr, "accountId", "status.vpcs.self.owner", ""),
        "accountId": _aid,
        "id": peer.id,
        "providerConfigRef": get(peer, "providerConfigRef", pcr),
        "region": get(peer, "region", region),
    }
    for _, peer in get(_oxr, "spec.transitGateway.peers", [])
    if get(peer, "id", False)
] + [
    {
        "accountId": peer.accountId,
        "id": tgw.id,
        "providerConfigRef": get(peer, "providerConfigRef", pcr),
        "region": peer.region,
    }
    for _, peer in get(_oxr, "spec.transitGateway.peers", [])
    for _, vpc in get(_oxr, "status.vpcs", [])
    for name, tgw in get(vpc, "transitGateways", [])
    if all_true([
        get(peer, "name", False),
        name == get(peer, "name", False) and not get(peer, "id", False),
        get(peer, "accountId", False) == get(vpc, "owner", ""),
        get(peer, "region", False) == get(vpc, "region", ""),
    ])
]

tgw = {
    "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1",
    "kind": "TransitGateway",
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": "transitgw",
            "krm.kcl.dev/ready": ready(_ocs, "transitgw"),
        }
        "labels": labels,
    },
    "spec": {
        "deletionPolicy": get(_oxr, "spec.deletionPolicy", "Delete"),
        "claimRef": get(_oxr, "spec.claimRef", {}),
        "enabled": get(_oxr, "spec.transitGateway.enabled", False),
        if get(_oxr, "spec.amazonSideAsn", False):
            "amazonSideAsn": get(_oxr, "spec.amazonSideAsn", 64512),
        if get(_oxr, "spec.applianceModeSupport", False):
            "applianceModeSupport": get(_oxr, "spec.applianceModeSupport", "disable"),
        if get(_oxr, "spec.autoAcceptSharedAttachments", False):
            "autoAcceptSharedAttachments": get(_oxr, "spec.autoAcceptSharedAttachments", "disable"),
        if get(_oxr, "spec.createPolicyTable", False):
            "createPolicyTable": get(_oxr, "spec.createPolicyTable", "disable"),
        if get(_oxr, "spec.defaultRouteTableAssociation", False):
            "defaultRouteTableAssociation": get(_oxr, "spec.defaultRouteTableAssociation", "disable"),
        if get(_oxr, "spec.defaultRouteTablePropagation", False):
            "defaultRouteTablePropagation": get(_oxr, "spec.defaultRouteTablePropagation", "disable"),
        if get(_oxr, "spec.dnsSupport", False):
            "dnsSupport": get(_oxr, "spec.dnsSupport", "disable"),
        if get(_oxr, "spec.ipv6Support", False):
            "ipv6Support": get(_oxr, "spec.ipv6Support", "disable"),

        "localVpc": localVpc,

        if get(_oxr, "spec.multicastSupport", False):
            "multicastSupport": get(_oxr, "spec.multicastSupport", "disable"),
        if get(_oxr, "spec.prefixListSupport", False):
            "prefixListSupport": get(_oxr, "spec.prefixListSupport", "disable"),

        if get(_ram, "enabled", False):
            "ram": _ram,

        "remoteVpcs": remoteVpcs,

        if get(_oxr, "spec.transitGatewayCidrBlocks", False):
            "transitGatewayCidrBlocks": get(_oxr, "spec.transitGatewayCidrBlocks", []),
        if get(_oxr, "spec.transitGatewayRouteTableAssociation", False):
            "transitGatewayRouteTableAssociation": get(_oxr, "spec.transitGatewayRouteTableAssociation", "disable"),
        if get(_oxr, "spec.transitGatewayRouteTablePropagation", False):
            "transitGatewayRouteTablePropagation": get(_oxr, "spec.transitGatewayRouteTablePropagation", "disable"),

        "transitGatewayPeers": transitGatewayPeers,

        "tags": get(_oxr, "spec.tags.common", []),

        if get(_oxr, "spec.vpnEcmpSupport", False):
            "vpnEcmpSupport": get(_oxr, "spec.vpnEcmpSupport", "disable"),

        "providerConfigRef": get(_oxr, "spec.providerConfigRef", {}),
    }
}

_items = [
    tgw
    for _ in [True]
    if all_true([
        get(_oxr, "spec.transitGateway.enabled", False),
        localVpc,
        remoteVpcs,
        len(remoteVpcs) == len(get(_oxr, "spec.transitGateway.remoteVpcs", [])),
        localRouteTableIds,
        localSubnetIds,
    ])
]
