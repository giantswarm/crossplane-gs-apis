logicalDatabase = {
    "apiVersion": "xdatabase.crossplane.giantswarm.io/v1alpha1"
    "kind": "LogicalDatabaseClaim"
    "metadata": {
        "name": "${name}",
        "namespace": "${namespace}"
    }
    "spec": {
        "deletionPolicy": "Delete",
        "engine": get(oxr, "spec.database.engine", "postgres"),
        "eso": {
            "enabled": True,
            "fluxSSASecretName": get(oxr, "spec.database.eso.clusterSsaField", "postgres"),
            "kubernetesSecretStore": "default",
            "tenantCluster": {
                "apiServerEndpoint": get(oxr, "spec.database.eso.tenantCluster.apiServerEndpoint", ""),
                "clusterName": get(oxr, "spec.database.eso.tenantCluster.clusterName", ""),
                "enabled": get(oxr, "spec.database.eso.tenantCluster.enabled", False)
            }
        },
        "kubernetesProviderConfig": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"}),
        "managementPolicies": ["*"],
        "providerConfigRef": {
            "name": get(oxr, "spec.database.providerConfigRef.name", "default")
        }
    }
}

wrappedLogicalDatabase = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${name}-logical-database"
            "krm.kcl.dev/ready": readystr("${name}-logical-database")
        }
    }
    "spec": {
        "deletionPolicy": "Delete"
        "forProvider": {
            "manifest": logicalDatabase
        }
        "managementPolicies": ["*"]
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
}

_items += [wrappedLogicalDatabase]
