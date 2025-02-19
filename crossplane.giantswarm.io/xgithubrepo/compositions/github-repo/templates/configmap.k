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
        "registryInfoConfigMapName": oxr["spec"]["github-oci-registry-info"]["name"]
    }
}

wrappedConfigMap = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
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
