users = [
    {
        "apiVersion": "elasticache.aws.upbound.io/v1beta1"
        "kind": "User"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "elasticache-user-${name}"
                "krm.kcl.dev/ready": readystr("elasticache-user-${name}")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                #if name == "default":
                #    "accessString": "off ~* +@all"
                #    "authenticationMode": [
                #        {
                #            "type": "no-password-required"
                #        }
                #    ]
                #else:
                "accessString": "off ~* +@all" if name == "default" else "on ~* +@all"
                "authenticationMode": [
                    {
                        "passwordsSecretRef": [
                            {
                                "key": "password"
                                if name == appName:
                                    "name": "${name}-elasticache-user"
                                else:
                                    "name": "${appName}-elasticache-user-${name}"
                                "namespace": namespace
                            }
                        ]
                        "type": "password"
                    }
                ]
                "engine": get(oxr, "spec.engine", "redis")
                "region": region
                "tags" = tags | {
                    "Name": "${appName}-${region}-${name}"
                }
                "userName": name
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for name in userNames
] if all_true([
    get(oxr, "spec.engine", "redis") == "redis",
    get(oxr, "spec.createReplicationGroup", True),
]) else []

userIds = [
    i for i in [
        get(item, "Resource.status.atProvider.id", "")
        for _, item in ocds
        if all_true([
            get(item, "Resource.kind", "") == "User",
            get(item, "Resource.apiVersion", "") == "elasticache.aws.upbound.io/v1beta1",
        ])
    ] if i
]

userGroup = [{
    "apiVersion": "elasticache.aws.upbound.io/v1beta1"
    "kind": "UserGroup"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": "elasticache-user-group"
            "krm.kcl.dev/ready": readystr("elasticache-user-group")
            "crossplane.io/external-name": appName
        }
        "labels": labels
    }
    "spec": {
        "deletionPolicy": dp
        "forProvider": {
            "engine": get(oxr, "spec.engine", "redis")
            "region": region
            "tags": tags | {
                "Name": "${appName}-${region}"
            }
            "userIds": userIds
        }
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": pcr
    }
}] if all_true([
    userIds,
    get(oxr, "spec.engine", "redis") == "redis",
    get(oxr, "spec.createReplicationGroup", True),
]) else []

_items = users + userGroup