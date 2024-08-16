esoEnabled = get(oxr, "spec.eso.enabled", False)
engine = get(oxr, "spec.engine", "redis")
kubernetesPcr = get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})

has = all_true([
    esoEnabled,
    kubernetesPcr,
])

if engine == "redis":
    assert esoEnabled, "External Secrets (eso) must be enabled for Redis engine"
    assert has, "Missing required kubernetes ProviderConfig and SecretStore fields for password generation"

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

_endpoint = globalEndpoint if globalEnabled else endpoint
esoConnectionSecret = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": "${appName}-connection-secret"
            "krm.kcl.dev/ready": readystr("${appName}-connection-secret")
        }
    }
    "spec": {
        "deletionPolicy": dp
        "forProvider": {
            "manifest": {
                "apiVersion": "external-secrets.io/v1beta1"
                "kind": "ExternalSecret"
                "metadata": {
                    "name": "${appName}-cache-connection-secret"
                    "namespace": namespace
                }
                "spec": {
                    "refreshInterval": "1h"
                    "secretStoreRef": {
                        "kind": "SecretStore",
                        "name": get(oxr, "spec.eso.kubernetesSecretStore", ""),
                    },
                    "target": {
                        "name": "${appName}-cache-connection-details"
                        "template": {
                            "engineVersion": "v2"
                            "mergePolicy": "Merge"
                            "templateFrom": [
                                {
                                    "target": "Data",
                                    "literal": """
                                        host: ${_endpoint}
                                        port: ${_port}
                                        username: ${appName}
                                        password:  {{ index . "password" }}
                                    """
                                }
                            ],
                        },
                    },
                    "dataFrom": [
                        {
                            "extract": {
                                "key": "elasticache-user-${appName}",
                            }
                        }
                    ],
                }
            }
        }
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
} if _endpoint and _port else {}

_items = [
    c for c in passwords + [passwordGenerator, esoConnectionSecret]
    if esoEnabled and c
]