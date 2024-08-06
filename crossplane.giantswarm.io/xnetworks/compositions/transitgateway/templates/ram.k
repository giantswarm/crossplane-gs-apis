# Optional RAM
resources = [
    tgwArn,
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
            "managementPolicies": mgmtPolicy,
            "name": appName,
            "permissions": get(oxr, "spec.ram.permissions", []),
            "principals": get(oxr, "spec.ram.principals", []),
            "resources": resources,
            "providerConfigRef": pcr
            "region": region,
        }
    }
    for _ in [True]
    if get(oxr, "spec.ram.enabled", False)
]
