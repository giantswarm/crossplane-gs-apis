esoEnabled = get(oxr, "spec.eso.enabled", False)
engine = get(oxr, "spec.engine", "redis")
kubernetesPcr = get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})

has = all_true([
    engine == "redis",
    esoEnabled,
    kubernetesPcr,
])
assert has != False, "Missing required kubernetes ProviderConfig and SecretStore fields for password generation"

passwordGenerator = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${appName}-pwgen"
            "krm.kcl.dev/ready": readystr("${appName}-pwgen")
        }
    }
    "spec": {
        "deletionPolicy": dp,
        "forProvider": {
            "manifest": {
                "apiVersion": "generators.external-secrets.io/v1alpha1"
                "kind": "Password"
                "metadata": {
                    "name": "${appName}-pwgen"
                    "namespace": namespace
                }
                "spec": {
                    "length": 42
                    "digits": 5
                    "symbols": 5
                    "symbolCharacters": "-_$@"
                    "noUpper": False
                    "allowRepeat": True
                }
            }
        }
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
}

passwords = [
    {
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "${appName}-externalsecret-${user}"
                "krm.kcl.dev/ready": readystr("${appName}-externalsecret-${user}")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "manifest": {
                    "apiVersion": "external-secrets.io/v1beta1"
                    "kind": "ExternalSecret"
                    "metadata": {
                        "namespace": namespace
                    }
                    "spec": {
                        "refreshInterval": "1h"
                        "target": {
                            if user == appName:
                                "name": "elasticache-user-${user}"
                            else:
                                "name": "${appName}-elasticache-user-${user}"
                        }
                        "dataFrom": [
                            {
                                "sourceRef": {
                                    "generatorRef": {
                                        "apiVersion": "generators.external-secrets.io/v1alpha1"
                                        "kind": "Password"
                                        "name": "${appName}-pwgen"
                                    }
                                }
                            }
                        ]
                    }
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
        }
    }
    for _, user in userNames
    if all_true([
        get(oxr, "spec.engine", "redis") == "redis",
        get(oxr, "spec.createReplicationGroup", True),
        # don't create a password for the default user
        # as this will be disabled
        user != "default"
    ])
]

_items = passwords + [passwordGenerator]