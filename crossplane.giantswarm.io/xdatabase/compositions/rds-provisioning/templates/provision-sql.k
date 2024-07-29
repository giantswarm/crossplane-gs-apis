e = get(_oxr, "spec.engine", False)
_engine = ""

if e and e in ["mysql", "aurora-mysql", "mariadb"]:
    _engine = "mysql"
elif e and e in ["postgres", "aurora-postgresql"]:
    _engine = "postgresql"
else:
    assert False, "Unsupported engine: ${e}"

appName = get(_oxr, "spec.claimRef.name", "")
connectionSecret = get(_oxr, "spec.connectionSecret", "")
_requiredDatabases = {}

if _engine == "mysql":
    _requiredDatabases = get(_oxr, "spec.databases", {}) | {
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
    _requiredDatabases = get(_oxr, "spec.databases", {}) | {
        "${appName}": {
            "name": appName,
            "users": [
                {
                    "name": appName,
                    "connectionLimit": 10,
                    "privileges" = [
                        "ALL PRIVILEGES",
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
            "name": "${appName}-${_engine}-connection-secret"
        }
        "spec": {
            "deletionPolicy": dp
            "providerConfigRef": {
                "name": get(_oxr, "spec.kubernetesProviderConfig.name", "")
            }
            "forProvider": {
                "manifest": {
                    "apiVersion": "${_engine}.sql.crossplane.io/v1alpha1"
                    "kind": "ProviderConfig"
                    "metadata": {
                        "name": "${appName}-${_engine}-provider-config"
                    }
                    "spec": {
                        "credentials": {
                            "connectionSecretRef": {
                                "name": connectionSecret
                                "namespace": get(_oxr, "spec.claimRef.namespace", "")
                            }
                            "source": "MySQLConnectionSecret" if _engine == "mysql" else "PostgreSQLConnectionSecret"
                        }
                        if _engine == "mysql":
                            "tls" = "preferred"
                        if _engine == "postgresql":
                            "defaultDatabase" = "postgres"
                    }
                }
            }
        }
    }
] if all_true([
    connectionSecret, _requiredDatabases,
    # Do not create the connection secret if one
    # is provided to us already
    not get(_oxr, "spec.providerConfigRef", False),
]) else []

providerConfigName = get(_oxr, "spec.providerConfigRef.name", "${appName}-${_engine}-provider-config")

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
    if all_true([
        get(_ocds, "${_engine}-connection-secret", False),
        connectionSecret, _requiredDatabases,
    ])
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
                    "maxQueriesPerHour": get(user, "maxQueriesPerHour", 1000)
                    "maxUpdatesPerHour": get(user, "maxUpdatesPerHour", 1000)
                    "maxConnectionsPerHour": get(user, "maxConnectionsPerHour", 100)
                    "maxUserConnections": get(user, "maxUserConnections", 10)
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
        }
    }

    for database, user in _requiredDatabases
    if all_true([
        get(_ocds, "${_engine}-connection-secret", False),
        connectionSecret, _requiredDatabases, databases,
    ])
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
                "database": database
                if _engine == "mysql":
                    "user": user.name
                if _engine == "postgresql":
                    "role": user.name
                "privileges": get(user, "privileges", [])
            }
        }
    }
    for database, user in _requiredDatabases
    if all_true([
        get(_ocds, "${_engine}-connection-secret", False),
        connectionSecret, _requiredDatabases,
        databases, users,
    ])
]

provisionSql = get(_oxr, "spec.provisionSql", True)
_items = [
    i for r in [
        providerConnectionSecret, databases,
        users, grants
    ]
    for i in r if i and provisionSql
]