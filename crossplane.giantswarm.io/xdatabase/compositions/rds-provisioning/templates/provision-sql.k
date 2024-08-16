import yaml
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

if _engine == "mysql":
    _requiredDatabases = get(oxr, "spec.databases", {}) | {
        "${appName}": {
            "name": appName,
            "users": [
                {
                    "name": appName,
                    "maxQueriesPerHour": 1000,
                    "maxUpdatesPerHour": 1000,
                    "maxConnectionsPerHour": 100,
                    "maxUserConnections": 10,
                    "privileges" = [
                        "ALL PRIVILEGES",
                    ],
                }
            ]
        }
    }

if _engine == "postgresql":
    _requiredDatabases = get(oxr, "spec.databases", {}) | {
        "${appName}": {
            "name": appName,
            "users": [
                {
                    "name": appName,
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
                }
            ]
        }
    }

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
        _resourceName = "${database}-user-${user.name}"
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
                "username": user.name
            }
            "name": user.name
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
                "name": providerConfigName
            }
            "writeConnectionSecretToRef": {
                "name": "${appName}-${_engine}-user-${user.name}" if user.name != appName else "${appName}-${_engine}-user"
                "namespace": get(oxr, "spec.claimRef.namespace", "")
            }
        }
    }

    for database, config in _requiredDatabases
    for _, user in get(config, "users", [])
    if _requiredDatabases and databases
]

grants = [
    {
        _resourceName = "${database}-grant-${user.name}"
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
                "username": user.name
            }
            "name": user.name
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
                    "user" = user.name
                if _engine == "postgresql":
                    "role": user.name
            }
        }
    }
    for database, config in _requiredDatabases
    for _, user in get(config, "users", [])
    if all_true([
        _requiredDatabases,
        databases,
        users,
        user,
        get(user, "privileges", False),
    ])
]
print(_engine)
print(yaml.encode(_requiredDatabases))
print(yaml.encode(grants))


provisionSql = get(oxr, "spec.provisionSql", True)
_items = [
    i for r in [
        providerConnectionSecret, databases,
        users, grants
    ]
    for i in r if i and provisionSql
]