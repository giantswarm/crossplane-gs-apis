ramShare = [
    {
        _resourceName = "ram-share-${appName}-${region}"
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
                "allowExternalPrincipals": get(oxr, "spec.ram.allowExternalPrincipals", True),
                "name": "${appName}-${region}",
                "region": region,
                "tags": tags,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for _ in [True]
]

ramShareId = ocdsstatus("ram-share-${appName}-${region}", "id", False)
ramShareArn = ocdsstatus("ram-share-${appName}-${region}", "arn", False)

ramAssociations = [
    {
        _resourceName = "ram-r-assoc-${i}"
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
                "resourceArn": get(resource, "arn", ""),
                "resourceShareArn": ramShareArn,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, resource in get(oxr, "spec.resources", [])
    if all_true([
        get(oxr, "spec.resources", False),
        ramShareArn, get(resource, "arn", False),
    ])
]

ramPrincipleAssociations = [
    {
        _resourceName = "ram-p-assoc-${i}"
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
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, id in get(oxr, "spec.principals", [])
    if all_true([
        ramShareArn,
        get(oxr, "spec.principals", False),
    ])
]

ramShareAccepters = [
    {
        _resourceName = "ram-share-accepter-${i}"
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
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": get(principal, "providerConfigRef", pcr)
        }
    }
    for i, principal in get(oxr, "spec.principals", [])
    if all_true([
        ramShareArn,
        get(oxr, "spec.principals", False),
    ])
]

newdxr = {
    **oxr,
    **{

        "status": {
            if ramShareId:
                "id": ramShareId,
            if ramShareArn:
                "arn": ramShareArn,
        }
    }
}

_items = [
    i for r in [
        ramShare, ramAssociations, newdxr,
        ramPrincipleAssociations, ramShareAccepters
    ]
    for i in r if i
]