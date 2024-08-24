
esoEnabled = get(oxr, "spec.eso.enabled", False)
ssasecret = get(oxr, "spec.eso.fluxSSASecretName", False)
# The resource created here is to enable switching Flux SSA from `Ignore` to
# `Merge`.
#
# This allows Flux to ignore the creation of resources until the related
# infrastructure has been created and is ready.
#
# To enable this, Any resources created by Flux kustomization should have the
# annotation `kustomize.toolkit.fluxcd.io/ssa: ${PROJECT_NAME_SSA:=Ignore}`.
#
# This will then force SSA to `Ingore` the resource by default.
#
# Next, the flux kusomization should have its `postBuild` set up like follows:
#
# ```yaml
# postBuild:
#   substitute:
#     var_substitution_enabled: "true"
#   substituteFrom:
#   - kind: Secret
#     name: flux-project-ssa
# ```
fluxSSA = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${appName}-externalsecret"
            "krm.kcl.dev/ready": readystr("${appName}-externalsecret")
        }
    }
    "spec": {
        "deletionPolicy": dp,
        "forProvider": {
            "manifest": {
                "apiVersion": "external-secrets.io/v1beta1",
                "kind": "ExternalSecret",
                "metadata": {
                    "name": "lg${ssasecret}",
                    "namespace": "default",
                },
                "spec": {
                    "refreshInterval": "1m",
                    "secretStoreRef": {
                        "name": get(oxr, "spec.eso.kubernetesSecretStore", ""),
                        "kind": "SecretStore",
                    },
                    "dataFrom": [
                        {
                            "find": {
                                "name": {
                                    "regexp": "^${ssasecret}$",
                                },
                            },
                        },
                    ],
                    "target": {
                        "name": ssasecret,
                        "creationPolicy": "Orphan",
                        "deletionPolicy": "Merge"
                        "template": {
                            "engineVersion": "v2",
                            "mergePolicy": "Merge",
                            "data": {
                                "${ssasecret}": "",
                                _name = regex.replace(appName, "[-_\.]", "_").lower()
                                "${_name}" = "{{ \"Merge\" | b64enc }}",
                            },
                        }
                    }
                }
            }
        }
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"}),
    }
} if all_true([
    esoEnabled,
    ssasecret,
    ready("${appName}-rds-provisioning"),
]) else {}

esoConnectionSecret = get(oxr, "status.esoConnectionSecret", False)
sqlEnabled = get(oxr, "spec.provisionSql.enabled", True)

provisioning = {
    apiVersion: "xdatabase.crossplane.giantswarm.io/v1alpha1"
    kind: "RdsProvisioning"
    metadata: {
        annotations: {
            _resourceName = "${appName}-rds-provisioning"
            "krm.kcl.dev/composition-resource-name": _resourceName
            "krm.kcl.dev/ready": readystr(_resourceName)
        }
    }
    spec: {
        "deletionPolicy": dp,
        "engine": get(oxr, "spec.engine", "postgres")
        "claimRef": get(oxr, "spec.claimRef", {})
        "providerConfigRef": get(oxr, "spec.providerConfigRef", {"name": "default"})
        "databases": get(oxr, "spec.databases", {})
        "kubernetesProviderConfig": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
        "managementPolicies": mgmtPolicy,
    }
} if all_true([
    get(oxr, "spec.providerConfigRef", True),
    get(oxr, "spec.databases", True),
]) else {}

_items = [
    i for i in [
        fluxSSA,
        provisioning,
    ] if i
]