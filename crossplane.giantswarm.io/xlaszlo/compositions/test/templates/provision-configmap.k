name = get(oxr, "spec.name", "laszlo-test")
namespace = get(oxr, "spec.namespace", "org-laszlo")

configMap = {
    "apiVersion": "v1",
    "kind": "ConfigMap",
    "metadata": {
        "name": name
        "namespace": namespace
    },
    "data": {
        "message": get(oxr, "spec.message", "default-message")
    }
}

wrappedConfigMap = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${name}-configmap"
            "krm.kcl.dev/ready": readystr("${name}-configmap")
        }
    }
    "spec": {
        "deletionPolicy": "Delete",
        "forProvider": {
            "manifest": configMap
        }
        "managementPolicies": ["*"],
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"}),
    }
}

_items = [wrappedConfigMap]
