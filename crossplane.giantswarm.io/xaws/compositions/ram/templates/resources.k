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
                "allowExternalPrincipals": get(oxr, "spec.allowExternalPrincipals", True),
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
        _id = regex.split(resource, "/")[-1]
        _resourceName = "ram-r-assoc-${_id}"
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
                "region": region,
                "resourceArn": resource,
                "resourceShareArn": ramShareArn,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, resource in get(oxr, "spec.resources", [])
    if all_true([
        get(oxr, "spec.resources", False),
        ramShareArn, resource,
    ])
]

ramPrincipleAssociations = [
    {
        _resourceName = "ram-p-assoc-${i}"
        "apiVersion": "ram.aws.upbound.io/v1beta1",
        "kind": "PrincipalAssociation",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName,
                "krm.kcl.dev/ready" = readystr(_resourceName),
            },
        },
        "spec": {
            "deletionPolicy": dp,
            "forProvider": {
                "principal": get(principal, "principal", ""),
                "region": region,
                "resourceShareArn": ramShareArn,
            },
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr,
        },
    }
    for i, principal in get(oxr, "spec.principals", [])
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
            "deletionPolicy": dp,
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
        principal,
        get(principal, "crossOrg", False),
    ])
]

newdxr = {
    **dxr,
    **{

        "status": {
            if ramShareId:
                "id": ramShareId,
            if ramShareArn:
                "arn": ramShareArn,

            "ready" = allReady()
        }
    }
}

_items = [
    i for r in [
        ramShare, ramAssociations, [newdxr],
        ramPrincipleAssociations, ramShareAccepters
    ]
    for i in r if i
]