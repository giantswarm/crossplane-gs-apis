configMap = {
    "apiVersion": "v1"
    "kind": "ConfigMap"
    "metadata": {
        "name": oxr["metadata"]["name"] + "-info"
        "namespace": oxr["metadata"]["namespace"]
    }
    "data": {
        "repoName": oxr["spec"]["repository"]["name"]
        "repoOwner": oxr["spec"]["repository"]["owner"]
        "repoVisibility": oxr["spec"]["repository"]["visibility"]
        "repoProvider": "github"
        "fluxHelmRepositoryName": oxr["metadata"]["name"]
        "registryInfoConfigMapName": oxr["spec"]["registryInfoConfigMapRef"]["name"]
    }
}

wrappedConfigMap = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${name}-config-map"
        }
    }
    "spec": {
        "deletionPolicy": "Delete"
        "forProvider": {
            "manifest": configMap
        }
        "managementPolicies": ["*"]
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
}

_items += [wrappedConfigMap]
