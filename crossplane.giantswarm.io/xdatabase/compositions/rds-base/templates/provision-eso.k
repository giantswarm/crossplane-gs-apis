_appName = get(_oxr, "spec.claimRef.name", "")
_createCluster = get(_oxr, "spec.createCluster", True)
_connectionSecret = get(_oxr, "status.connectionSecret", "")
_engine = get(_oxr, "spec.engine", "")

_externalSecretStores = [
    {
        "name": get(_oxr, "spec.eso.kubernetesSecretStore", "default"),
        "clusterScoped": False,
    }
]

_pushSecretStores = [
    {
        "name": store.secretStore,
        "clusterScoped": True,
    }
    for _, store in get(_oxr, "spec.eso.stores", [])
    if get(_oxr, "spec.eso.enabled", True) and store.enabled
]
_usernameField = "username" if not _createCluster else "master_username"
_passwordField = "password" if not _createCluster else "attribute.master_password"

_pushSecretData = [
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

_deletionPolicy = "Delete" if get(_oxr, "spec.deletionPolicy", "Delete") == "Delete" else "Retain"
_esoSqlSecret = [
    {
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "${_appName}-externalsecret"
            }
        }
        "spec": {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            providerConfigRef: {
                name: get(_oxr, "spec.kubernetesProviderConfig.name", "")
            }
            forProvider: {
                manifest: {
                    apiVersion: "external-secrets.io/v1alpha1"
                    kind: "ExternalSecret"
                    metadata: {
                        namespace: get(_oxr, "spec.claimRef.namespace", "default")
                    }
                    spec: {
                        refreshInterval: "1h"
                        secretStoreRef: {
                            name: value.name
                            kind: "ClusterSecretStore" if value.clusterScoped else "SecretStore"
                        }
                        data: [
                            {
                                secretKey: k.r,
                                remoteRef: {
                                    key: _connectionSecret,
                                    property: k.p
                                }
                            }
                            for _, k in [
                                {r: "endpoint", p:"endpoint"},
                                {r: "port", p: "port"},
                                {r: "password", p: _passwordField},
                                {r: "username", p: _usernameField},
                            ]
                        ]
                        target: {
                            name: "${_appName}-rds-master"
                            deletionPolicy: _deletionPolicy
                        }
                    }
                }
            }
        }
    }
    for _, value in _externalSecretStores
    if _connectionSecret and get(_oxr, "spec.eso.enabled", True)
]

_pushSecret = [
    {
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "${_appName}-pushsecret"
            }
        }
        "spec": {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            providerConfigRef: {
                name: get(_oxr, "spec.kubernetesProviderConfig.name", "")
            }
            forProvider: {
                manifest: {
                    apiVersion: "external-secrets.io/v1alpha1"
                    kind: "PushSecret"
                    metadata: {
                        namespace: get(_oxr, "spec.claimRef.namespace", "default")
                    }
                    spec: {
                        refreshInterval: "10s"
                        secretStoreRefs: [
                            {
                                name: value.name
                                kind: "ClusterSecretStore" if value.clusterScoped else "SecretStore"
                            }
                            for _, value in _pushSecretStores
                        ]
                        data: _pushSecretData
                        deletionPolicy: _deletionPolicy
                        selector: {
                            secret: {
                                name: "${_appName}-rds-master"
                            }
                        }
                        updatePolicy: "Replace"
                    }
                }
            }
        }
    } for _ in [True] if _pushSecretStores and get(_oxr, "spec.eso.enabled", True)
]

_newdxr = {
    **_oxr,
    **{
        "status": {
            "esoConnectionSecret": "${_appName}-rds-master"
        }
    }
} if get(_oxr, "spec.eso.enabled", True) and _connectionSecret else {}

_items = [
    i for r in [_esoSqlSecret, _pushSecret, [_newdxr]]
    for i in r if i
]