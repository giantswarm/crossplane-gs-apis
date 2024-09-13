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

_endpoint = globalEndpoint if globalEnabled else endpoint
passwords = [
    {
        _name = "${appName}-elasticache-user-${user}" if user != appName else "${appName}-elasticache-user"
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _name
                "krm.kcl.dev/ready": readystr(_name)
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
                            "name": _name
                            "template": {
                                "engineVersion": "v2"
                                "mergePolicy": "Merge"
                                "templateFrom": [
                                    {
                                        "target": "Data",
                                        "literal": """
                                            host: ${_endpoint}
                                            reader: ${readerep}
                                            port: ${_port}
                                            username: ${user}
                                            password:  {{ .password }}
                                        """
                                    }
                                ],
                            },
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
        #user != "default"
    ])
]

# Not convinced this is relevant anymore
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
                                        reader: ${readerep}
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
                                "key": "${appName}-elasticache-user",
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

pushSecretStores = [
    store
    for _, store in get(oxr, "spec.eso.stores", [])
    if get(oxr, "spec.eso.enabled", True) and store.enabled
]
deletionPolicy = "Delete" if dp == "Delete" else "Retain"

# Push Secrets
pushSecrets = [
    {
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "${appName}-pushsecret"
                "krm.kcl.dev/ready": readystr("${appName}-pushsecret")
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "manifest": {
                    "apiVersion": "external-secrets.io/v1alpha1"
                    "kind": "PushSecret"
                    "metadata": {
                        "namespace": get(oxr, "spec.claimRef.namespace", "default")
                    }
                    _name = get(password, "spec.forProvider.manifest.spec.target.name", "")
                    "spec": {
                        "refreshInterval": "10s"
                        "secretStoreRefs": [
                            {
                                "name": value.name
                                "kind": "ClusterSecretStore" if value.clusterScoped else "SecretStore"
                            }
                            for _, value in pushSecretStores
                        ]
                        "data": [
                            {
                                "conversionStrategy": "None"
                                "match": {
                                    "secretKey": k,
                                    "remoteRef": {
                                        "remoteKey": _name,
                                        "property": k,
                                    }
                                }
                            }
                            for _, k in [
                                "host", "reader", "port", "password", "username",
                            ]
                            if _endpoint and _port
                        ]

                        "deletionPolicy": deletionPolicy
                        "selector": {
                            "secret": {
                                "name": _name
                            }
                        }
                        updatePolicy: "Replace"
                    }
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": {
                name: get(oxr, "spec.kubernetesProviderConfig.name", "")
            }
        }
    }
    for _, password in passwords
    if pushSecretStores and get(oxr, "spec.eso.enabled", True)
]

_items = [
    c for c in passwords + [passwordGenerator, esoConnectionSecret] + pushSecrets
    if esoEnabled and c
]