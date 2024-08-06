
ssasecret = get(_oxr, "spec.eso.fluxSSASecret", "")
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
_items = [
    {
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
                        "namespace": namespace,
                    },
                    "spec": {
                        "refreshInterval": "1d",
                        "secretStoreRef": {
                            "name": get(_oxr, "spec.eso.secretStoreRef.name", ""),
                            "kind": "SecretStore",
                        },
                        "dataFrom": [
                            {
                                "extract": {
                                    "key": ssasecret,
                                    "version": "v1",
                                },
                            },
                        ],
                        "target": {
                            "name": ssasecret,
                            "creationPolicy": "Orphan",
                            "template": {
                                "engineVersion": "v2",
                                "mergePolicy": "Merge",
                                "data": {
                                    "${ssasecret}": "",
                                    "${appName}" = '{{ "Merge" | b64enc }}',
                                },
                            }
                        }
                    }
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": {
                "name": get(_oxr, "spec.kubernetesProviderConfig.name", "")
            }
        }
    }
    for _ in [True]
    if all_true([
        get(_oxr, "spec.eso.enabled", False),
        get(_oxr, "spec.eso.fluxSSASecret", False),
        get(_oxr, "status.cacheConnectionSecret", False),
        get(_oxr, "status.rdsConnectionSecret", False),
    ])
]
