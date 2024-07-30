esoEnabled = get(_oxr, "spec.eso.enabled", False)
esoConnectionSecret = get(_oxr, "status.esoConnectionSecret", "")
sqlEnabled = get(_oxr, "spec.provisionSql.enabled", True)

if createCluster and sqlEnabled:
    assert esoEnabled != False, "ESO must be enabled when creating a cluster with SQL provisioning enabled."

useConnectionSecret = esoConnectionSecret if esoEnabled else connectionSecret

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
            "engine": get(_oxr, "spec.engine", "postgres")
            "connectionSecretName": useConnectionSecret
            "databases": get(_oxr, "spec.databases", {})
            "kubernetesProviderConfig": get(_oxr, "spec.kubernetesProviderConfig", {"name": "default"})
        }
    }
    for _ in [True]
    if get(_oxr, "spec.provisionSql.enabled", True)
]