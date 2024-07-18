import regex

_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds
_dcds = option("params").dcds

get = lambda x: any, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

_engine = get(_oxr, "spec.engine", False)

if _engine and _engine in ["mysql", "aurora-mysql"]:
    _engine = "mysql"
elif _engine and _engine in ["postgres", "aurora-postgresql"]:
    _engine = "postgresql"
else:
    assert False, "Unsupported engine: ${_engine}"

_appName = get(_oxr, "spec.claimRef.name", "")
_connectionSecret = get(_oxr, "status.connectionSecret", "")
_requiredDatabases = get(_oxr, "spec.databases", {})

if _engine == "mysql":
    _requiredDatabases = _requiredDatabases | {
        _appName: {
            name: _appName,
            users: [
                {
                    name: _appName,
                    maxQueriesPerHour: 1000,
                    maxUpdatesPerHour: 1000,
                    maxConnectionsPerHour: 100,
                    maxUserConnections: 10,
                    privileges = [
                        "ALL PRIVILEGES",
                    ],
                }
            ]
        }
    }

if _engine == "postgresql":
    _requiredDatabases = _requiredDatabases | {
        _appName: {
            name: _appName,
            users: [
                {
                    name: _appName,
                    connectionLimit: 10,
                    privileges = [
                        "ALL PRIVILEGES",
                    ],
                    bypassRls: False,
                    createDb: False,
                    createRole: False,
                    inherit: True,
                    login: True,
                    replication: False,
                    superuser: False,
                }
            ]
        }
    }

# Create provider connection secret for the database

_providerConnectionSecret = [{
    apiVersion: "kubernetes.crossplane.io/v1alpha2",
    kind: "Object"
    metadata: {
        annotations: {
            "krm.kcl.dev/composition-resource-name" = "${_engine}-connection-secret"
        }
    }
    spec: {
        deletionPolicy: get(_oxr, "spec.clusterDiscovery.deletionPolicy", "Delete"),
        providerConfigRef: {
            name: get(_oxr, "spec.kubernetesProviderConfigRef.name", "")
        }
        forProvider: {
            manifest: {
                apiVersion: "${_engine}.sql.crossplane.io/v1alpha1"
                kind: "ProviderConfig"
                metadata: {
                    name: "${_appName}-${_engine}-provider-config"
                }
                spec: {
                    credentials: {
                        connectionSecretRef: {
                            name: _connectionSecret
                            namespace: get(_oxr, "spec.claimRef.namespace", "")
                        }
                        source: "MySQLConnectionSecret" if _engine == "mysql" else "PostgreSQLConnectionSecret"
                    },
                    if _engine == "mysql":
                        tls = "preferred"
                    if _engine == "postgresql":
                        defaultDatabase = "postgres"
                },
            },
        }
    }
}] if all_true([
    _connectionSecret,
    _requiredDatabases,
]) else []

# Create each required database
_databases = [
    {
        apiVersion: "${_engine}.sql.crossplane.io/v1alpha1"
        kind: "Database"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "database-${database}"
            }
            name: database
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            providerConfigRef: {
                name: "${_appName}-${_engine}-provider-config"
            }
            forProvider: {}
        }
    }

    for database, _ in _requiredDatabases
    if all_true([
        get(_ocds, "${_engine}-connection-secret", False),
        _connectionSecret,
        _requiredDatabases,
    ])
]

# Create each required user
_users = [
    {
        apiVersion: "${_engine}.sql.crossplane.io/v1alpha1"
        kind: "User" if _engine == "mysql" else "Role"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "${database}-user-${user.name}"
            }
            labels: {
                "engine": _engine
                "database": database
                "username": user.name
            }
            name: user.name
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            providerConfigRef: {
                name: "${_appName}-${_engine}-provider-config"
            }
            forProvider: {
                if _engine == "mysql":
                    maxQueriesPerHour: get(user, "maxQueriesPerHour", 1000)
                    maxUpdatesPerHour: get(user, "maxUpdatesPerHour", 1000)
                    maxConnectionsPerHour: get(user, "maxConnectionsPerHour", 100)
                    maxUserConnections: get(user, "maxUserConnections", 10)
                if _engine == "postgresql":
                    if get(user, "configurationParameters", False):
                        configurationParameters: [
                            {
                                name: k
                                value: v
                            }
                            for k, v in get(user, "configurationParameters", {})
                        ]
                    connectionLimit: get(user, "connectionLimit", 10)
                    privileges: {
                        bypassRls: get(user, "bypassRls", False)
                        createDb: get(user, "createDb", False)
                        createRole: get(user, "createRole", False)
                        inherit: get(user, "inherit", True)
                        login: get(user, "login", True)
                        replication: get(user, "replication", False)
                        superuser: get(user, "superuser", False)
                    }
            }
        }
    }

    for database, user in _requiredDatabases
    if all_true([
        get(_ocds, "${_engine}-connection-secret", False),
        _connectionSecret,
        _requiredDatabases,
        _databases,
    ])
]

_grants = [
    {
        apiVersion: "${_engine}.sql.crossplane.io/v1alpha1"
        kind: "Grant" if _engine == "mysql" else "RoleBinding"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "${database}-grant-${user.name}"
            }
            labels: {
                "engine": _engine
                "database": database
                "username": user.name
            }
            name: user.name
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            providerConfigRef: {
                name: "${_appName}-${_engine}-provider-config"
            }
            forProvider: {
                database: database
                if _engine == "mysql":
                    user: user.name
                if _engine == "postgresql":
                    role: user.name

                privileges: get(user, "privileges", [])
            }
        }
    }
    for database, user in _requiredDatabases
    if all_true([
        get(_ocds, "${_engine}-connection-secret", False),
        _connectionSecret,
        _requiredDatabases,
        _databases,
        _users,
    ])
]

items = [i for i in [_providerConnectionSecret, _databases, _users, _grants] if i]
