e = get(oxr, "spec.engine", False)
_engine = ""

if e and e in ["mysql", "aurora-mysql", "mariadb"]:
    _engine = "mysql"
elif e and e in ["postgres", "aurora-postgresql"]:
    _engine = "postgresql"
else:
    assert False, "Unsupported engine: ${e}"

appName = get(oxr, "spec.claimRef.name", "")
connectionSecret = get(oxr, "spec.connectionSecretName", "")
_requiredDatabases = {}

defaultDatabase = {
    "${appName}" = {
        "${appName}" = {}
    }
}

if _engine == "mysql":
    _requiredDatabases = {
        "${dbName}": {
            "users": {
                "${username}": {
                    **{
                        "maxQueriesPerHour": 1000,
                        "maxUpdatesPerHour": 1000,
                        "maxConnectionsPerHour": 100,
                        "maxUserConnections": 10,
                        "privileges" = [
                            "ALL PRIVILEGES",
                        ],
                    },
                    **user,
                }
                for username, user in dbUsers.users
            }
        }
        for dbName, dbUsers in defaultDatabase | get(oxr, "spec.databases", {})
    }

if _engine == "postgresql":
    _requiredDatabases = {
        "${dbName}": {
            "users": {
                "${username}": {
                    **{
                        "connectionLimit": 10,
                        "privileges" = [
                            "ALL",
                        ],
                        "bypassRls": False,
                        "createDb": False,
                        "createRole": False,
                        "inherit": True,
                        "login": True,
                        "replication": False,
                        "superuser": False,
                    },
                    **user,
                }
                for username, user in dbUsers.users
            }
        }
        for dbName, dbUsers in defaultDatabase | get(oxr, "spec.databases", {})
    }

print("REQUIRED DATABASES", _requiredDatabases)
# Create provider connection secret for the database
newPcrName = "${appName}-${_engine}-provider-config"

providerConnectionSecret = [
    {
        _resourceName = "${_engine}-connection-secret"
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "name": newPcrName
        }
        "spec": {
            "deletionPolicy": dp
            "providerConfigRef": {
                "name": get(oxr, "spec.kubernetesProviderConfig.name", "")
            }
            "forProvider": {
                "manifest": {
                    "apiVersion": "${_engine}.sql.crossplane.io/v1alpha1"
                    "kind": "ProviderConfig"
                    "metadata": {
                        "name": newPcrName
                    }
                    "spec": {
                        "credentials": {
                            "connectionSecretRef": {
                                "name": connectionSecret
                                "namespace": get(oxr, "spec.claimRef.namespace", "")
                            }
                            "source": "MySQLConnectionSecret" if _engine == "mysql" else "PostgreSQLConnectionSecret"
                        }
                        if _engine == "mysql":
                            "tls" = "preferred"
                        if _engine == "postgresql":
                            "defaultDatabase" = "postgres"
                            # https://github.com/crossplane-contrib/provider-sql/issues/102
                            "sslMode" = "require"
                    }
                }
            }
        }
    }
] if all_true([
    connectionSecret, _requiredDatabases,
]) else []

_providerConfigName = get(oxr, "spec.providerConfigRef.name", "")
providerConfigName = newPcrName if connectionSecret else _providerConfigName
# Create each required database
databases = [
    {
        _resourceName = "database-${database}"
        "apiVersion": "${_engine}.sql.crossplane.io/v1alpha1"
        "kind": "Database"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "name": database
        }
        "spec": {
            "deletionPolicy": dp
            "providerConfigRef": {
                "name": providerConfigName
            }
            "forProvider": {}
        }
    }

    for database, _ in _requiredDatabases
    if _requiredDatabases
]

# Create each required user
users = [
    {
        _resourceName = "${database}-user-${username}"
        "apiVersion": "${_engine}.sql.crossplane.io/v1alpha1"
        "kind": "User" if _engine == "mysql" else "Role"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": {
                "engine": _engine
                "database": database
                "username": username
            }
            "name": username
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                if _engine == "mysql":
                    "resourceOptions": {
                        "maxQueriesPerHour": get(user, "maxQueriesPerHour", 1000)
                        "maxUpdatesPerHour": get(user, "maxUpdatesPerHour", 1000)
                        "maxConnectionsPerHour": get(user, "maxConnectionsPerHour", 100)
                        "maxUserConnections": get(user, "maxUserConnections", 10)
                    }
                if _engine == "postgresql":
                    if get(user, "configurationParameters", False):
                        "configurationParameters": [
                            {
                                "name": k
                                "value": v
                            }
                            for k, v in get(user, "configurationParameters", {})
                        ]
                    "connectionLimit": get(user, "connectionLimit", 10)
                    "privileges": {
                        "bypassRls": get(user, "bypassRls", False)
                        "createDb": get(user, "createDb", False)
                        "createRole": get(user, "createRole", False)
                        "inherit": get(user, "inherit", True)
                        "login": get(user, "login", True)
                        "replication": get(user, "replication", False)
                        "superUser": get(user, "superuser", False)
                    }
            }
            "providerConfigRef": {
                "name": providerConfigName,
            }
            "writeConnectionSecretToRef": {
                "name": "${appName}-rds-user-${username}" if username != appName else "${appName}-rds-user"
                "namespace": get(oxr, "spec.claimRef.namespace", "")
            }
        }
    }

    for database, config in _requiredDatabases
    for username, user in get(config, "users", [])
    if _requiredDatabases and databases
]

connectionSecrets = {
    "app" = "${appName}-rds-user"
    "users" = {
        username: "${appName}-rds-user-${username}"
        for database, config in _requiredDatabases
        for username, user in get(config, "users", [])
        if username != appName
    }
}

grants = [
    {
        _resourceName = "${database}-grant-${username}"
        "apiVersion": "${_engine}.sql.crossplane.io/v1alpha1"
        "kind": "Grant"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": {
                "engine": _engine
                "database": database
                "username": username
            }
            "name": username
        }
        "spec": {
            "deletionPolicy": dp
            "providerConfigRef": {
                "name": providerConfigName
            }
            "forProvider": {
                "database" = database,
                "privileges" = get(user, "privileges", []),
                if _engine == "mysql":
                    "user" = username
                if _engine == "postgresql":
                    "role": username
            }
        }
    }
    for database, config in _requiredDatabases
    for username, user in get(config, "users", [])
    if all_true([
        _requiredDatabases,
        databases,
        users,
        user,
        get(user, "privileges", False),
    ])
]

# Push Secrets
reader = get(oxr, "spec.readerEndpoint", "")

pushSecrets = [
    {
        _name = get(user, "spec.writeConnectionSecretToRef.name", "")
        "apiVersion": "kubernetes.crossplane.io/v1alpha2"
        "kind": "Object"
        "metadata": {
            "annotations": {
                _resourceName = "${_name}-pushsecret"
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
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
                    "spec": {
                        "refreshInterval": "10s",
                        "secretStoreRefs": [
                            {
                                "name": value.name,
                                "kind": "ClusterSecretStore" if value.clusterScoped else "SecretStore",
                            },
                            for _, value in get(oxr, "spec.eso.stores", [])
                            if value.enabled and get(oxr, "spec.eso.enabled", True)
                        ],
                        "template": {
                            "engineVersion": "v2"
                            "data": {
                                "endpoint": "{{ .endpoint }}",
                                "port": "{{ .port }}",
                                "password": "{{ .password }}",
                                "username": "{{ .username }}",
                                "reader": reader,
                            }
                        },
                        "data": [
                            {
                                "match": {
                                    "secretKey": k,
                                    "remoteRef": {
                                        "remoteKey": _name,
                                        "property": k,
                                    },
                                },
                            },
                            for k in [
                                "endpoint", "port", "password", "username", "reader",
                            ]
                        ]
                        "deletionPolicy": "Delete" if dp == "Delete" else "Retain",
                        "selector": {
                            "secret": {
                                "name": _name,
                            },
                        },
                        "updatePolicy": "Replace",
                    }
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": {
                "name": get(oxr, "spec.kubernetesProviderConfig.name", "")
            }
        }
    }
    for _, user in users
    if all_true([
        get(oxr, "spec.eso.enabled", True),
        get(oxr, "spec.eso.tenantCluster.apiServerEndpoint", []),
        get(oxr, "spec.eso.tenantCluster.enabled", True),
    ])
]

newdxr = {
    **dxr,
    **{
        "status": {
            "ready" = allReady()
            "connectionSecrets" = connectionSecrets,
        },
    },
}

provisionSql = get(oxr, "spec.provisionSql", True)
_items = [
    i for r in [
        providerConnectionSecret, databases,
        users, grants, [newdxr], pushSecrets,
    ]
    for i in r if i and provisionSql
]