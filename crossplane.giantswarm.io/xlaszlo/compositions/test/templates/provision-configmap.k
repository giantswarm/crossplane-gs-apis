configMap = {
    "apiVersion": "v1",
    "kind": "ConfigMap",
    "metadata": {
        "name": appName
        "namespace": namespace
    },
    "data": {
        "message": get(oxr, "spec.message", "default-message")
    }
}

_items = [configMap]
