#apiVersion: source.toolkit.fluxcd.io/v1beta2
#kind: HelmRepository
#metadata:
#  name: <objName>
#  namespace: <objNamespace>
#spec:
#  type: "oci"
#  interval: 5m0s
#  url: oci://ghcr.io/<repoOwner>/charts
helmRepo = {
    "apiVersion": "source.toolkit.fluxcd.io/v1beta2"
    "kind": "HelmRepository"
    "metadata": {
        "name": oxr["metadata"]["name"]
        "namespace": oxr["metadata"]["namespace"]
    }
    "spec": {
        "type": "oci"
        "interval": "5m0s"
        "url": "oci://ghcr.io/" + oxr["spec"]["repository"]["owner"] + "/charts"
    }
}

wrappedHelmRepo = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${name}-helm-repository"
        }
    }
    "spec": {
        "deletionPolicy": "Delete"
        "forProvider": {
            "manifest": helmRepo
        }
        "managementPolicies": ["*"]
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
}

_items += [wrappedHelmRepo]
