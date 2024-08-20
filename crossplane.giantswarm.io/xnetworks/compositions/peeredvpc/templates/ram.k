# Optional RAM

# If we're building as part of the VPC, we should retrieve the prefix lists from
# the transit gateway resource.
#
# If this is enabled in the transit gateway, they need to come fdrom the OXR
sharedMpl = ocdsstatus("transitgw", "sharedPrefixLists", get(oxr, "status.sharedPrefixLists", []))

# shared subnets is a future extension - I've not figured out
# how best to specify this yet.
sharedSubnets = get(oxr, "status.sharedSubnets", [])

principals = [
    {
        "principal": get(oxr, "status.vpcs.${rvpc.name}.owner", ""),
        "providerConfigRef": get(rvpc, "providerConfigRef", {"name": "default"}),
    }
    for _, rvpc in get(oxr, "spec.transitGateway.remoteVpcs", [])
    if all_true([
        get(oxr, "status.vpcs.${rvpc.name}.owner", False) != get(oxr, "status.vpcs.self.owner", False),
        get(rvpc, "providerConfigRef", False),
    ])
] + [
    p
    for p in get(oxr, "spec.ram.principals", [])
    if p
]

# This block should be specific to the RAM when loaded
# as part of the VPC - it should not affect the RAM when
# loaded as part of the TransitGateway.
_forceRamEnabled = False
if all_true([
    get(oxr, "spec.transitGateway.enabled", False),
    any_true([
        get(oxr, "status.vpcs.${name}.owner", False) != get(oxr, "status.vpcs.self.owner", False)
        for name, _ in get(oxr, "status.vpcs", [])
        for _, vpc in get(oxr, "spec.transitGateway.remoteVpcs", [])
        if get(vpc, "name", "") == name
    ]),
]):
    _forceRamEnabled = True

resources = [
    c for r in [
        [tgwArn],
        sharedMpl,
        sharedSubnets,
    ]
    for c in r if c
] + get(oxr, "spec.ram.resources", [])

_items = [
    {
        "apiVersion": "xaws.crossplane.giantswarm.io/v1alpha1"
        "kind": "ResourceAccessManager"
        "metadata": {
            _resourceName = "ram-${appName}-${region}"
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": appName
            }
        }
        "spec": {
            "allowExternalPrincipals": get(oxr, "spec.ram.allowExternalPrincipals", False),
            "deletionPolicy": dp
            "claimRef": get(oxr, "spec.claimRef", {}),
            "managementPolicies": mgmtPolicy,
            "name": appName,
            "permissions": get(oxr, "spec.ram.permissions", []),
            "principals": principals,
            "resources": resources,
            "providerConfigRef": pcr
            "region": region,
            "tags": tags,
        }
    }
    for _ in [True]
    if any_true([
        get(oxr, "spec.ram.enabled", False),
        _forceRamEnabled,
    ])
]
