appName = get(_oxr, "spec.claimRef.name", "")
dp = get(_oxr, "spec.deletionPolicy", "Delete")
labels = get(_oxr, "metadata.labels", {})
pcr = get(_oxr, "spec.providerConfigRef", {"name": "default"})
region = get(_oxr, "spec.localVpc.region", "eu-central-1")
tags = get(_oxr, "spec.tags.common", {}) | {
    region: region,
}

tgwEnabled = get(_oxr, "spec.enabled", False)

rpcr = lambda x: {:} -> {:} {
    """
    Get the ProviderConfigRef from the given object

    If this is not set it will attempt to return the ProviderConfigRef from
    the Observed Composite Resource, and if that isn't set, will return an
    object with an empty name.
    """
    get(x, "providerConfigRef", get(_oxr, "spec.providerConfigRef", {name: ""}))
}

# Create the main transit gateway
# The Id of this transit gateway will be published to _oxr.status.tgwId
transitGateway = [
    {
        _resourceName = "transitgateway-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGateway"
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
                "amazonSideAsn": get(_oxr, "spec.amazonSideAsn", 64512),
                "autoAcceptSharedAttachments": get(_oxr, "spec.autoAcceptSharedAttachments", "disable"),
                "defaultRouteTableAssociation": "enable" if get(_oxr, "spec.defaultRouteTableAssociation", False) else "disable",
                "defaultRouteTablePropagation": "enable" if get(_oxr, "spec.defaultRouteTablePropagation", False) else "disable",
                "description": "${appName} Transit Gateway in ${region}",
                "dnsSupport": get(_oxr, "spec.dnsSupport", "enable"),
                "multicastSupport": get(_oxr, "spec.multicastSupport", "disable"),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}"
                },
                "transitGatewayCidrBlocks": [
                    get(_oxr, "spec.transitGatewayCidrBlock", "")
                    for _ in [True]
                    if get(_oxr, "spec.transitGatewayCidrBlock", False)
                ]
                "vpnEcmpSupport": get(_oxr, "spec.vpnEcmpSupport", "enable"),
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if tgwEnabled
]

tgwId = ocdsstatus("transitgateway-${appName}-${region}", "id", False)
tgwArn = ocdsstatus("transitgateway-${appName}-${region}", "arn", False)

# Create the main transit gateway route table
# The Id of this route table will be published to _oxr.status.tgwRouteTableId
tgwRouteTable = [
    {
        _resourceName = "tgwrt-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayRouteTable"
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
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}",
                }
                "transitGatewayId": tgwId,
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwId, tgwEnabled,
    ])
]

tgwRouteTableId = get(_ocs, "tgwrt-${appName}-${region}.Resource.status.atProvider.id", False)

tgwPolicyTable = [
    {
        _resourceName = "tgwpt-${appName}-${region}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPolicyTable"
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
            "deletionPolicy": get(_oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "region": region,
                "tags": tags | {
                    Name: "${appName}-${region}",
                }
                "transitGatewayId": tgwId,
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwId, tgwEnabled,
        get(_oxr, "spec.createPolicyTable", True),
    ])
]

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
                "applianceModeSupport": get(_oxr, "spec.applianceModeSupport", "disable"),
                "dnsSupport": get(_oxr, "spec.dnsSupport", "enable"),
                "ipv6Support": get(_oxr, "spec.ipv6Support", "disable"),
                "region": region,
                "subnetIds": get(_oxr, "spec.localVpc.subnetIds", []),
                "tags": tags | {
                    Name: "${appName}-${region}"
                }
                "transitGatewayDefaultRouteTableAssociation": get(_oxr, "spec.defaultRouteTableAssociation", False),
                "transitGatewayDefaultRouteTablePropagation": get(_oxr, "spec.defaultRouteTablePropagation", False),
                "transitGatewayId": tgwId,
                "vpcId": get(_oxr, "spec.localVpc.vpcId", ""),
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwEnabled, tgwId,
    ])
]

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
                "applianceModeSupport": get(_oxr, "spec.applianceModeSupport", "disable"),
                "dnsSupport": get(_oxr, "spec.dnsSupport", "enable"),
                "ipv6Support": get(_oxr, "spec.ipv6Support", "disable"),
                "region": get(remoteVpc, "region", region),
                "subnetIds": get(remoteVpc, "subnetIds", []),
                "tags": tags | {
                    Name: "${appName}-${region}-${remoteVpc.name}"
                }
                "transitGatewayDefaultRouteTableAssociation": get(_oxr, "spec.defaultRouteTableAssociation", False),
                "transitGatewayDefaultRouteTablePropagation": get(_oxr, "spec.defaultRouteTablePropagation", False),
                "transitGatewayId": tgwId,
                "vpcId": get(remoteVpc, "vpcId", ""),
            }
            "providerConfigRef": rpcr(remoteVpc)
        }
    }
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    if all_true([
        tgwEnabled, tgwId,
    ])
]

remoteAttachementIds = {
    "${remoteVpc.name}": get(_ocs, "tgwa-${appName}-${region}-${remoteVpc.name}.Resource.status.atProvider.id", "")
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    if get(_ocs, "tgwa-${appName}-${region}-${remoteVpc.name}.Resource.status.atProvider.id", False)
}

localAttachmentIds = {
    "${appName}": get(_ocs, "tgwa-${appName}-${region}.Resource.status.atProvider.id", "")
    for _ in [True]
    if get(_ocs, "tgwa-${appName}-${region}.Resource.status.atProvider.id", False)
}

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
            "deletionPolicy": get(_oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "region": get(remoteVpc, "region", region),
                "transitGatewayAttachmentId": get(remoteAttachementIds, remoteVpc.name, ""),
            }
            "providerConfigRef": rpcr(remoteVpc)
        }
    }
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    if all_true([
        any_true([
            get(remoteVpc, "region", region) != region,
            rpcr(remoteVpc).name != get(_oxr, "spec.providerConfigRef.name", ""),
        ]),
        get(remoteAttachementIds, remoteVpc.name, False),
        tgwEnabled,
    ])
]

tgwRemotePrefixLists = [
    {
        _id = get(remoteAttachementIds, remoteVpc.name, "")
        _bh = "-bh" if get(pl, "blackhole", False) else ""
        _resourceName = "tgwpl-${appName}-${region}-${_id}${_bh}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayPrefixListReference"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "blackhole": pl.blackhole,
                "prefixListId": pl.id,
                "region": region,
                "tags": tags | {
                    Name: "${appName}-${region}",
                }
                "transitGatewayAttachmentId": _id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "providerConfigRef": pcr
        }
    }
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    for _, pl in get(remoteVpc, "prefixLists", [])
    if all_true([
        tgwId, tgwEnabled,
        get(_oxr, "spec.prefixList.enabled", False),
    ])
]

tgwLocalPrefixList = [
    {
        _bh = "-bh" if get(pl, "blackhole", False) else ""
        _resourceName = "tgwpl-${appName}-${region}${_bh}"
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
                    "Name": "${appName}-${region}",
                }
                "transitGatewayAttachmentId": get(localAttachmentIds, appName, ""),
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "providerConfigRef": pcr
        }
    }
    for _, pl in get(_oxr, "spec.localVpc.prefixLists", [])
    if all_true([
        tgwId, tgwEnabled,
        get(_oxr, "spec.prefixListSupport", False),
    ])
]

propagation = [
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
            "providerConfigRef": pcr
        }
    }
    for _, id in localAttachmentIds | remoteAttachementIds
    if all_true([
        localAttachmentIds, remoteAttachementIds,
        tgwEnabled, tgwRouteTableId,
    ])
]

tgwAssociations = [
    {
        _resourceName = "tgwa-${appName}-${region}-${id}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayRouteTableAssociation"
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
            "deletionPolicy": get(_oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "region": region,
                "transitGatewayAttachmentId": id,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "providerConfigRef": get(_oxr, "spec.providerConfigRef", {})
        }
    }
    for _, id in localAttachmentIds | remoteAttachementIds
    if all_true([
        localAttachmentIds, remoteAttachementIds,
        tgwEnabled, tgwRouteTableId,
    ])
]

# Map comprehension to create transit gateway routes
# We use map-comprehension here to prevent duplicate
# routes from being added to the list
tgwRemoteRoutes = {
    "${tgw.cidrBlock}": {
        "bh": get(tgw, "blackhole", False),
        "aid": get(remoteAttachementIds, remoteVpc.name, "")
        "region": get(remoteVpc, "region", region),
        "name": remoteVpc.name
        "pcr": rpcr(remoteVpc)
    }
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    for tgw in get(remoteVpc, "additionalRoutes", []) + [
        {cidrBlock: cidr, blackhole: False}
        for _, cidr in get(remoteVpc, "cidrBlocks", [])
    ]
    if all_true([
        tgwEnabled
        get(remoteAttachementIds, remoteVpc.name, False)
    ])
}

tgwLocalRoutes = {
    "${tgw.cidrBlock}": {
        "bh": get(tgw, "blackhole", False),
        "aid": get(localAttachmentIds, appName, ""),
        "name": appName,
        "region": region,
        "pcr": get(_oxr, "spec.providerConfigRef", {}),
    }
    for tgw in get(_oxr, "spec.localVpc.additionalRoutes", []) + [
        {cidrBlock: cidr, blackhole: False}
        for _, cidr in get(_oxr, "spec.localVpc.cidrBlocks", [])
    ]
}

transitGatewayRoutes = [
    {
        _name = regex.replace(key, "\.|\/", "-")
        _resourceName = "tgwr-${appName}-${region}-${_name}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "TransitGatewayRoute"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "routeType": "transitGateway",
                "vpcName": value.name
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "blackhole": value.bh
                "destinationCidrBlock": key,
                "region": value.region,
                "transitGatewayAttachmentId": value.aid,
                "transitGatewayRouteTableId": tgwRouteTableId,
            }
            "providerConfigRef": value.pcr
        }
    }
    for key, value in tgwRemoteRoutes | tgwLocalRoutes
    if all_true([
        tgwLocalRoutes, tgwRemoteRoutes,
        tgwEnabled, tgwRouteTableId,
    ])
]

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
                "destinationCidrBlock": cidr,
                "routeTableId": id,
                "region": region,
                "transitGatewayId": tgwId,
            },
            "providerConfigRef": pcr
        }
    }
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    for _, cidr in get(remoteVpc, "cidrBlocks", [])
    for _, id in get(_oxr, "spec.localVpc.routeTableIds", [])
    if all_true([
        tgwId, tgwEnabled,
    ])
]

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
                "destinationCidrBlock": cidr,
                "routeTableId": id,
                "region": get(remoteVpc, "region", region),
                "transitGatewayId": tgwId,
            },
            "providerConfigRef": rpcr(remoteVpc),
        }
    }
    for _, remoteVpc in get(_oxr, "spec.remoteVpcs", [])
    for _, cidr in get(_oxr, "spec.localVpc.cidrBlocks", [])
    for _, id in get(remoteVpc, "routeTableIds", [])
    if all_true([
        tgwId, tgwEnabled,
    ])
]

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
            "deletionPolicy": get(_oxr, "spec.deletionPolicy", "Delete"),
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
            "providerConfigRef": rpcr(peer)
        }
    }
    for peer in get(_oxr, "spec.transitGatewayPeers", [])
    if all_true([
        tgwId, tgwEnabled,
    ])
]

peeringIds = [
    ocdsstatus("tgw-peer-${appName}-${region}-${peer.name}", "id", "")
    for peer in get(_oxr, "spec.transitGatewayPeers", [])
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
            "providerConfigRef": pcr
        }
    }
    for _, id in peeringIds
    if tgwEnabled
]

# RAM Resource management
# These are only enabled if RAM is enabled

# NOTE:
# These may become their own composition in the future

ramEnabled = tgwEnabled and get(_oxr, "spec.ram.enabled", False)

ramShare = [
    {
        _resourceName = "tgw-share-${appName}-${region}"
        "apiVersion": "ram.aws.upbound.io/v1beta1"
        "kind": "ResourceShare"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "allowExternalPrincipals": get(_oxr, "spec.ram.allowExternalPrincipals", True),
                "name": "${appName}-${region}",
                "region": region,
                "tags": tags,
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if ramEnabled
]

ramShareId = ocdsstatus("tgw-share-${appName}-${region}", "id", False)
ramShareArn = ocdsstatus("tgw-share-${appName}-${region}", "arn", False)

ramAssociation = [
    {
        _resourceName = "tgw-assoc-${appName}-${region}"
        "apiVersion": "ram.aws.upbound.io/v1beta1"
        "kind": "ResourceAssociation"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "associationType": "resource",
                "region": region,
                "resourceArn": tgwArn,
                "resourceShareArn": ramShareArn,
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        ramEnabled, ramShareArn, tgwArn,
        get(_oxr, "status.tgwArn", False),
    ])
]

ramPrincipleAssoc = [
    {
        _resourceName = "ram-pcple-${appName}-${region}-${id}"
        "apiVersion": "ram.aws.upbound.io/v1beta1"
        "kind": "PrincipalAssociation"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "principal": id,
                "region": region,
                "resourceShareArn": ramShareArn,
            }
            "providerConfigRef": pcr
        }
    }
    for _, id in get(_oxr, "spec.ram.principals", [])
    if all_true([
        ramEnabled, ramShareArn,
        get(_oxr, "spec.ram.principals", False),
    ])
]

ramShareAccepter = [
    {
        _resourceName = "ram-share-accepter-${appName}-${region}"
        "apiVersion": "ram.aws.upbound.io/v1beta1"
        "kind": "ResourceShareAccepter"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
        }
        "spec": {
            "deletionPolicy": pcr
            "forProvider": {
                "region": region,
                "shareArn": ramShareArn,
            }
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        ramEnabled, ramShareArn,
    ])
]

newdxr = [
    {
        **_oxr,
        **{
            "status": {
                if tgwId:
                    "tgwId": tgwId,
                if tgwArn:
                    "tgwArn": tgwArn,
                if tgwRouteTableId:
                    "tgwRouteTableId": tgwRouteTableId,
                if localAttachmentIds:
                    "localAttachmentIds": localAttachmentIds,
                if remoteAttachementIds:
                    "remoteAttachmentIds": remoteAttachementIds,
                if ramShareId:
                    "ramShareId": ramShareId,
                if ramShareArn:
                    "ramShareArn": ramShareArn,
            }
        }
    }
    for _ in [True]
    if tgwEnabled
]

_items =  [
    i for r in [
        transitGateway, localAttachments,
        remoteAttachments, tgwRouteTable,
        transitGatewayRoutes, localRoutes,
        remoteRoutes, tgwAssociations,
        attachmentAccepters, propagation,
        tgwRemotePrefixLists, tgwLocalPrefixList,
        tgwPeers, tgwPeeringAccepters,

        # RAM Resources
        ramShare, ramAssociation,
        ramPrincipleAssoc, ramShareAccepter,

        # DesiredCompositeResource
        newdxr,
    ] for i in r if i
]