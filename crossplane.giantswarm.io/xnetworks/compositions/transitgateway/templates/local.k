# Create the attachment to the local VPC
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
                "applianceModeSupport": get(oxr, "spec.applianceModeSupport", "disable"),
                "dnsSupport": get(oxr, "spec.dnsSupport", "enable"),
                "ipv6Support": get(oxr, "spec.ipv6Support", "disable"),
                "region": region,
                "subnetIds": get(localVpc, "subnetIds", []),
                "tags": tags | {
                    Name: "${appName}-${region}"
                }
                "transitGatewayDefaultRouteTableAssociation": get(oxr, "spec.defaultRouteTableAssociation", False),
                "transitGatewayDefaultRouteTablePropagation": get(oxr, "spec.defaultRouteTablePropagation", False),
                "transitGatewayId": tgwId,
                "vpcId": get(localVpc, "vpcId", ""),
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
    if all_true([
        tgwEnabled, tgwId,
        localVpc,
    ])
]

lentries = [
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
        for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    ] + [
        [
            {
                "cidr": e.cidr,
                "description": "${appName} CIDR Block ${i}",
            }
            for _, pl in get(oxr, "spec.localVpc.prefixLists", [])
            for i, e in get(pl, "entries", {})
            if all_true([
                e,
                not get(pl, "tgwAttach", False),
                not get(pl, "id", False),
                not get(pl, "blackhole", False),
            ])
        ]
    ] for x in r if x
]

lEntriesBh = [
    e
    for _, pl in get(oxr, "spec.localVpc.prefixLists", [])
    for i, e in get(pl, "entries", {})
    if all_true([
        e,
        not get(pl, "tgwAttach", False),
        not get(pl, "id", False),
        get(pl, "blackhole", False),
    ])
]

lmpl = {
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
    }
    "spec": {
        "addressFamily": "IPv4",
        "deletionPolicy": dp,
        "entries": lentries,
        "managementPolicies": mgmtPolicy,
        "name": "${appName}-${region}",
        "region": region,
        "tags": tags | {
            "Name": "${appName}-${region}",
        }
    }
}

lmplbh = {
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
    }
    "spec": {
        "addressFamily": "IPv4",
        "deletionPolicy": dp,
        "entries": lEntriesBh,
        "managementPolicies": mgmtPolicy,
        "name": "${appName}-${region}-bh",
        "region": region,
        "tags": tags | {
            "Name": "${appName}-${region}-bh",
        }
    }
}

localPrefixLists = [
    lmpl,
    lmplbh,
]

prefixListIds = [
    c for c in [
        ocdsstatus("lmpl-${appName}-${region}", "id", ""),
        ocdsstatus("lmpl-${appName}-${region}-bh", "id", ""),
    ] if c
]

# Create the routes right at the end so we can set up
# the prefix lists properly first
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
                "destinationPrefixListId": pl,
                "routeTableId": id,
                "region": region,
                "transitGatewayId": tgwId,
            },
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _, id in get(oxr, "spec.localVpc.routeTableIds", [])
    for pl in prefixListIds
    if all_true([
        tgwId, tgwEnabled,
    ])
]

_items = [
    i for r in [
        localAttachments,
        localPrefixLists,
        localRoutes,
    ]
    for i in r if i
]
