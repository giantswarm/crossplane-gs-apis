ssasecret = get(oxr, "spec.eso.fluxSSASecretName", "")
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
fluxSsa = {
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
                    "name": "cc${appName}-flux-ssa",
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
                        "deletionPolicy": "Merge",
                        "template": {
                            "engineVersion": "v2",
                            "mergePolicy": "Merge",
                            "data": {
                                "${ssasecret}": "",
                                _name = regex.replace(appName, "[-_\.]", "_").lower()
                                "${_name}" = "{{ \"Merge\" }}",
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
    get(oxr, "spec.eso.enabled", False),
    get(oxr, "spec.eso.fluxSSASecretName", False),
    get(oxr, "status.cacheConnectionSecret", False),
    get(oxr, "status.rdsConnectionSecret", False),
    ready("peered-vpc-network"),
    ready("cache-base"),
    ready("rds-base"),
]) else {}

clusterName = get(oxr, "spec.eso.tenantCluster.clusterName", "")
tenantSecretStore = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": "tenant-secret-store"
            "krm.kcl.dev/ready": readystr("tenant-secret-store")
        }
    }
    "spec": {
        "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete")
        "forProvider": {
            "manifest": {
                "apiVersion": "external-secrets.io/v1beta1"
                "kind": "SecretStore"
                "metadata": {
                    "name": "${appName}-tenant-secret-store"
                    "namespace": get(oxr, "spec.claimRef.namespace", "")
                }
                "spec": {
                    "provider": {
                        "kubernetes": {
                            "auth": {
                                "cert": {
                                    "clientCert": {
                                        "name": "${clusterName}-eso-cluster-auth",
                                        "key": "tls.crt",
                                    },
                                    "clientKey": {
                                        "name": "${clusterName}-eso-cluster-auth",
                                        "key": "tls.key",
                                    },
                                }
                            }
                            "remoteNamespace": get(oxr, "spec.eso.tenantCluster.namespace", "default")
                            "server": {
                                "caProvider": {
                                    "key": "ca.crt",
                                    "name": "${clusterName}-eso-cluster-auth",
                                    "type": "Secret"
                                }
                                _url = get(oxr, "spec.eso.tenantCluster.apiServerEndpoint", "kubernetes.default")
                                "url": "https://${_url}"
                            }
                        }
                    }
                }
            }
        }
        "managementPolicies": get(oxr, "spec.managementPolicies", []),
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
} if all_true([
    get(oxr, "spec.eso.enabled", False),
    get(oxr, "spec.eso.tenantCluster.enabled", False),
    clusterName,
]) else {}

_items = [
    c for c in [
        fluxSsa,
        tenantSecretStore,
    ] if c
]