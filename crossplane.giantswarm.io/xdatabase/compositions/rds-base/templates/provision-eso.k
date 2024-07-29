externalSecretStores = [
    {
        "name": get(_oxr, "spec.eso.kubernetesSecretStore", "default"),
        "clusterScoped": False,
    }
]

pushSecretStores = [
    {
        "name": store.secretStore,
        "clusterScoped": True,
    }
    for _, store in get(_oxr, "spec.eso.stores", [])
    if get(_oxr, "spec.eso.enabled", True) and store.enabled
]
usernameField = "username" if not createCluster else "master_username"
passwordField = "password" if not createCluster else "attribute.master_password"

pushSecretData = [
    {
        conversionStrategy: "None"
        match: {
            secretKey: k,
            remoteRef: {
                remoteKey: k
            }

        }
    }
    for _, k in [
        "endpoint", "port",
        "password", "username",
    ]
]

deletionPolicy = "Delete" if dp == "Delete" else "Retain"
esoSqlSecret = [
    {
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "${appName}-externalsecret"
                "krm.kcl.dev/ready": readystr("${appName}-externalsecret")
            }
        }
        "spec": {
            deletionPolicy: dp,
            forProvider: {
                manifest: {
                    "apiVersion": "external-secrets.io/v1alpha1"
                    "kind": "ExternalSecret"
                    "metadata": {
                        "namespace": namespace
                    }
                    "spec": {
                        "refreshInterval": "1h"
                        "secretStoreRef": {
                            "name": value.name
                            "kind": "ClusterSecretStore" if value.clusterScoped else "SecretStore"
                        }
                        "data": [
                            {
                                "secretKey": k.r,
                                "remoteRef": {
                                    "key": connectionSecret,
                                    "property": k.p
                                }
                            }
                            for _, k in [
                                {r: "endpoint", p:"endpoint"},
                                {r: "port", p: "port"},
                                {r: "password", p: passwordField},
                                {r: "username", p: usernameField},
                            ]
                        ]
                        "target": {
                            "name": "${appName}-rds-master"
                            "deletionPolicy": deletionPolicy
                        }
                    }
                }
            }
            "providerConfigRef": {
                "name": get(_oxr, "spec.kubernetesProviderConfig.name", "")
            }
        }
    }
    for _, value in externalSecretStores
    if connectionSecret and get(_oxr, "spec.eso.enabled", True)
]

pushSecret = [
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
            "providerConfigRef": {
                name: get(_oxr, "spec.kubernetesProviderConfig.name", "")
            }
            "forProvider": {
                "manifest": {
                    "apiVersion": "external-secrets.io/v1alpha1"
                    "kind": "PushSecret"
                    "metadata": {
                        "namespace": get(_oxr, "spec.claimRef.namespace", "default")
                    }
                    "spec": {
                        "refreshInterval": "10s"
                        "secretStoreRefs": [
                            {
                                "name": value.name
                                "kind": "ClusterSecretStore" if value.clusterScoped else "SecretStore"
                            }
                            for _, value in pushSecretStores
                        ]
                        "data": pushSecretData
                        "deletionPolicy": deletionPolicy
                        "selector": {
                            "secret": {
                                "name": "${appName}-rds-master"
                            }
                        }
                        updatePolicy: "Replace"
                    }
                }
            }
        }
    } for _ in [True] if pushSecretStores and get(_oxr, "spec.eso.enabled", True)
]

_items = [
    i for r in [esoSqlSecret, pushSecret]
    for i in r if i
]