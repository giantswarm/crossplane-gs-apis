_createCluster = get(_oxr, "spec.createCluster", False)
_connectionSecret = get(_oxr, "spec.connectionSecret", "")
_esoEnabled = get(_oxr, "spec.eso.enabled", False)
_esoConnectionSecret = get(_oxr, "status.esoConnectionSecret", "")
_sqlEnabled = get(_oxr, "spec.provisionSql.enabled", True)

_mustEnableEso = all_true([
    _createCluster,
    _sqlEnabled,
    not _esoEnabled
])

assert _mustEnableEso, "ESO must be enabled when creating a cluster with SQL provisioning enabled."

_useConnectionSecret = _esoConnectionSecret if _esoEnabled else _connectionSecret

_items = [
    {
        apiVersion: "xdatabases.crossplane.giantswarm.io/v1alpha1"
        kind: "RdsProvisioning"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "${_appName}-rds-provisioning"
            }
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            engine: get(_oxr, "spec.engine", "postgres")
            connectionSecretName: _useConnectionSecret
            databases: get(_oxr, "spec.databases", {})
            kubernetesProviderConfig: get(_oxr, "spec.kubernetesProviderConfig", {"name": "default"})
        }
    }
    for _ in [True]
    if get(_oxr, "spec.provisionSql.enabled", True)
]