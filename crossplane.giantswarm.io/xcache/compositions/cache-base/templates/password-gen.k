if get(_oxr, "spec.engine", "redis") == "redis":
    assert all_true([
        get(_oxr, "spec.kubernetesProviderConfigRef", False),
        get(_oxr, "spec.kubernetesSecretStore", False)
    ]) "Missing required kubernetes ProviderConfig and SecretStore fields for password generation"

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
        "providerConfigRef": get(_oxr, "spec.kubernetesProviderConfig", {"name": "default"})
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
                    "apiVersion": "external-secrets.io/v1alpha1"
                    "kind": "ExternalSecret"
                    "metadata": {
                        "namespace": namespace
                    }
                    "spec": {
                        "refreshInterval": "1h"
                        "secretStoreRef": {
                            "name": get(_oxr, "spec.kubernetesSecretStore", "default")
                            "kind": "SecretStore"
                        }
                        "target": {
                            if user == appName:
                                "name": "${appName}-externalsecret"
                            else:
                                "name": "${appName}-externalsecret-${user}"
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
            "providerConfigRef": get(_oxr, "spec.kubernetesProviderConfig", {"name": "default"})
        }
    }
    for _, user in userNames
    if all_true([
        get(_oxr, "spec.engine", "redis") == "redis",
        get(_oxr, "spec.createReplicationGroup", True),
        # don't create a password for the default user
        # as this will be disabled
        user != "default"
    ])
]

_items = passwords + [passwordGenerator]