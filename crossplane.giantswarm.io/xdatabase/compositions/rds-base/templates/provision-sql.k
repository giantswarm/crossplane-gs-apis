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
                "krm.kcl.dev/composition-resource-name": "rds-provisioning"
                "krm.kcl.dev/ready": readystr("rds-provisioning")
            }
        }
        spec: {
            "claimRef": get(oxr, "spec.claimRef", {})
            "connectionSecretName": useConnectionSecret
            "databases": get(oxr, "spec.databases", {})
            "deletionPolicy": dp,
            "engine": get(oxr, "spec.engine", "postgres")
            "eso": get(oxr, "spec.eso", {})
            "kubernetesProviderConfig": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
            "managementPolicies": mgmtPolicy,
            if readerEndpoint:
                "readerEndpoint": readerEndpoint,
        }
    }
    for _ in [True]
    if all_true([
        get(oxr, "spec.provisionSql.enabled", True),
        useConnectionSecret,
        exists("instance-0"),
        ready("instance-0"),
    ])
]