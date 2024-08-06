esoEnabled = get(oxr, "spec.eso.enabled", False)
esoConnectionSecret = get(oxr, "status.esoConnectionSecret", False)
sqlEnabled = get(oxr, "spec.provisionSql.enabled", True)

if createCluster and sqlEnabled:
    assert esoEnabled != False, "ESO must be enabled when creating a cluster with SQL provisioning enabled."

useConnectionSecret: str|bool = esoConnectionSecret if esoEnabled else _connectionSecret

_items = [
    {
        apiVersion: "xdatabase.crossplane.giantswarm.io/v1alpha1"
        kind: "RdsProvisioning"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "${appName}-rds-provisioning"
                "krm.kcl.dev/ready": readystr("${appName}-rds-provisioning")
            }
        }
        spec: {
            "deletionPolicy": dp,
            "engine": get(oxr, "spec.engine", "postgres")
            "claimRef": get(oxr, "spec.claimRef", {})
            "connectionSecretName": useConnectionSecret
            "databases": get(oxr, "spec.databases", {})
            "kubernetesProviderConfig": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
            "managementPolicies": mgmtPolicy,
        }
    }
    for _ in [True]
    if get(oxr, "spec.provisionSql.enabled", True) and useConnectionSecret
]