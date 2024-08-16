_ram = get(oxr, "spec.ram", {enabled: False})
_tgwRam = get(oxr, "spec.transitGateway.ram", {enabled: False})

# If we have both RAM and TGW RAM enabled, we need to disable TGW RAM
# as it will be built as part of the VPC
if _tgwRam.enabled and _ram.enabled:
    _tgwRam.enabled = False

localRouteTableIds = [
    i.id
    for _, r in get(oxr, "status.vpcs.self.publicRouteTables", [])
    for _, i in r
    if all_true([
        get(oxr, "spec.transitGateway.allowPublic", True),
        get(oxr, "status.vpcs.self.publicRouteTables", False),
    ])
] + [
    i.id
    for _, r in get(oxr, "status.vpcs.self.privateRouteTables", [])
    for _, i in r
]

preferPublic = all_true([
    get(oxr, "spec.transitGateway.preferPublicAttachments", False),
    get(oxr, "spec.transitGateway.allowPublic", False),
    get(oxr, "status.vpcs.self.publicSubnets", False),
])

# We can only use one subnet in each availability zone for the TGW attachment
localSubnetIds = [
    i.id
    for j, r in get(oxr, "status.vpcs.self.publicSubnets", [])
    for _, i in r
    if all_true([
        j == 0,
        preferPublic,
    ])
] if preferPublic else [
    i.id for j, r in get(oxr, "status.vpcs.self.privateSubnets", [])
    for _, i in r
    if j == 0
]

localVpc = {
    "cidrBlocks": [
        c for _, c in [
            get(oxr, "status.vpcs.self.cidrBlock", "")
        ] + get(oxr, "status.vpcs.self.additionalCidrBlocks", [])
        if c
    ],

    if get(oxr, "spec.prefixLists", False):
        "prefixLists": [
            {
                blackhole: pl.blackhole,
                pl.id: get(oxr, "status.prefixLists.${pl.name}", pl.name),
            }
            for _, pl in get(oxr, "spec.prefixLists", [])
        ]

    "region": get(oxr, "spec.region", ""),
    "routeTableIds": localRouteTableIds,
    "subnetIds": localSubnetIds,

    if get(oxr, "status.vpcs.self.id", False):
        "vpcId": get(oxr, "status.vpcs.self.id", ""),

} if all_true([
    get(oxr, "status.vpcs.self.id", False),
    localRouteTableIds,
    localSubnetIds,
]) else {}

remoteVpcs = [
    {
        _subnetIds = [
            i.id for j, r in get(oxr, "status.vpcs.${vpc.name}.publicSubnets", [])
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
            i.id for j, r in get(oxr, "status.vpcs.${vpc.name}.privateSubnets", [])
            for _, i in r
            if j == 0
        ]
        "cidrBlocks": [
            c for _, c in [
                get(oxr, "status.vpcs.${vpc.name}.cidrBlock", "")
            ] + get(oxr, "status.vpcs.${vpc.name}.additionalCidrBlocks", [])
            if c
        ],
        "name": vpc.name,
        "region": get(oxr, "status.vpcs.${vpc.name}.region", ""),
        "routeTableIds": [
            i.id for r in get(oxr, "status.vpcs.${vpc.name}.publicRouteTables", [])
            for _, i in r
            if get(oxr, "spec.transitGateway.allowPublic", True)
        ] + [
            i.id for r in get(oxr, "status.vpcs.${vpc.name}.privateRouteTables", [])
            for _, i in r
        ],
        "subnetIds": _subnetIds,
        "vpcId": get(oxr, "status.vpcs.${vpc.name}.id", ""),
    }
    for _, vpc in get(oxr, "spec.transitGateway.remoteVpcs", [])
    if get(oxr, "status.vpcs.${vpc.name}.id", False)
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
        _aid = getwparentfb(peer, oxr, "accountId", "status.vpcs.self.owner", ""),
        "accountId": _aid,
        "id": peer.id,
        "providerConfigRef": get(peer, "providerConfigRef", pcr),
        "region": get(peer, "region", region),
    }
    for _, peer in get(oxr, "spec.transitGateway.peers", [])
    if get(peer, "id", False)
] + [
    {
        "accountId": peer.accountId,
        "id": tgw.id,
        "providerConfigRef": get(peer, "providerConfigRef", pcr),
        "region": peer.region,
    }
    for _, peer in get(oxr, "spec.transitGateway.peers", [])
    for _, vpc in get(oxr, "status.vpcs", [])
    for name, tgw in get(vpc, "transitGateways", [])
    if all_true([
        get(peer, "name", False),
        name == get(peer, "name", False),
        not get(peer, "id", False),
        get(peer, "accountId", False) == get(vpc, "owner", ""),
        get(peer, "region", False) == get(vpc, "region", ""),
    ])
]

tgw = {
    _resourceName = "transitgw",
    "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1",
    "kind": "TransitGateway",
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": _resourceName,
            "krm.kcl.dev/ready": readystr(_resourceName),
        }
        "labels": labels,
    },
    "spec": {
        "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
        "claimRef": get(oxr, "spec.claimRef", {}),
        if get(oxr, "spec.amazonSideAsn", False):
            "amazonSideAsn": get(oxr, "spec.amazonSideAsn", 64512),
        if get(oxr, "spec.applianceModeSupport", False):
            "applianceModeSupport": get(oxr, "spec.applianceModeSupport", "disable"),
        if get(oxr, "spec.autoAcceptSharedAttachments", False):
            "autoAcceptSharedAttachments": get(oxr, "spec.autoAcceptSharedAttachments", "disable"),
        if get(oxr, "spec.createPolicyTable", False):
            "createPolicyTable": get(oxr, "spec.createPolicyTable", "disable"),
        if get(oxr, "spec.defaultRouteTableAssociation", False):
            "defaultRouteTableAssociation": get(oxr, "spec.defaultRouteTableAssociation", "disable"),
        if get(oxr, "spec.defaultRouteTablePropagation", False):
            "defaultRouteTablePropagation": get(oxr, "spec.defaultRouteTablePropagation", "disable"),
        if get(oxr, "spec.dnsSupport", False):
            "dnsSupport": get(oxr, "spec.dnsSupport", "disable"),
        if get(oxr, "spec.ipv6Support", False):
            "ipv6Support": get(oxr, "spec.ipv6Support", "disable"),

        "localVpc": localVpc,
        "managementPolicies": mgmtPolicy,

        if get(oxr, "spec.multicastSupport", False):
            "multicastSupport": get(oxr, "spec.multicastSupport", "disable"),
        if get(oxr, "spec.prefixListSupport", False):
            "prefixListSupport": get(oxr, "spec.prefixListSupport", "disable"),

        if get(_ram, "enabled", False):
            "ram": _ram,

        "remoteVpcs": remoteVpcs,

        if get(oxr, "spec.transitGatewayCidrBlocks", False):
            "transitGatewayCidrBlocks": get(oxr, "spec.transitGatewayCidrBlocks", []),
        if get(oxr, "spec.transitGatewayRouteTableAssociation", False):
            "transitGatewayRouteTableAssociation": get(oxr, "spec.transitGatewayRouteTableAssociation", "disable"),
        if get(oxr, "spec.transitGatewayRouteTablePropagation", False):
            "transitGatewayRouteTablePropagation": get(oxr, "spec.transitGatewayRouteTablePropagation", "disable"),

        "peers": transitGatewayPeers,

        "tags": get(oxr, "spec.tags.common", []),

        if get(oxr, "spec.vpnEcmpSupport", False):
            "vpnEcmpSupport": get(oxr, "spec.vpnEcmpSupport", "disable"),

        "providerConfigRef": get(oxr, "spec.providerConfigRef", {}),
    }
}

print("TGW VPC", localVpc)
print("TGW RVPC", remoteVpcs)
print("TGW LSNIDs", localSubnetIds)
print("TGW LRTIDs", localRouteTableIds)
print("TGW ENABLED", get(oxr, "spec.transitGateway.enabled", False))
print("TGW LENs MATCH", len(remoteVpcs) == len(get(oxr, "spec.transitGateway.remoteVpcs", [])))

_items = [
    tgw
    for _ in [True]
    if all_true([
        localVpc,
        remoteVpcs,
        localSubnetIds,
        localRouteTableIds,
        get(oxr, "spec.transitGateway.enabled", False),
        len(remoteVpcs) == len(get(oxr, "spec.transitGateway.remoteVpcs", [])),
    ])
]
