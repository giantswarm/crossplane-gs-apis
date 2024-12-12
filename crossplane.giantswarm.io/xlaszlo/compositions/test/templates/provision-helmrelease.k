helmRepository = {
    "apiVersion": "source.toolkit.fluxcd.io/v1beta2"
    "kind": "HelmRepository"
    "metadata": {
        "name": "${name}",
        "namespace": "${namespace}"
    }
    "spec": {
        "interval": "5m0s",
        "provider": "generic",
        "secretRef": {
            "name": "ghcr-pull-secret"
        },
        "timeout": "60s",
        "type": "oci",
        "url": "oci://ghcr.io/demotechinc/charts"
    }
}

wrappedHelmRepository = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${name}-helm-repository"
            "krm.kcl.dev/ready": readystr("${name}-helm-repository")
        }
    }
    "spec": {
        "deletionPolicy": "Delete"
        "forProvider": {
            "manifest": helmRepository
        }
        "managementPolicies": ["*"]
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
}

helmRelease = {
    "apiVersion": "helm.toolkit.fluxcd.io/v2beta1"
    "kind": "HelmRelease"
    "metadata": {
        "name": "${name}",
        "namespace": "${namespace}"
    },
    "spec": {
        "chart": {
            "spec": {
                "chart": "python-service-1",
                "reconcileStrategy": "ChartVersion",
                "sourceRef": {
                    "kind": "HelmRepository",
                    "name": "${name}"
                },
                "version": get(oxr, "spec.version", ">=0.1.0")
            }
        }
        "interval": get(oxr, "spec.interval", "1m"),
        "kubeConfig": {
            "secretRef": {
                "name": get(oxr, "spec.kubeConfig.secretRef.name", "")
            }
        }
        "storageNamespace": get(oxr, "spec.storageNamespace", "default"),
        "suspend": get(oxr, "spec.suspend", False),
        "targetNamespace": get(oxr, "spec.targetNamespace", "default"),
        "timeout": get(oxr, "spec.timeout", "3m"),
        "values": {
            "autoscaling": {
                "enabled": False
            }
            "database": {
                "connectionSecretName": "python-service-1-rds-user",
                "name": "python-service-1"
            },
            "imagePullSecrets": [
                {
                    "name": "ghcr-pull-secret"
                }
            ],
            "inMemoryStore": False,
            "ingress": {
                "annotations": {
                    "kubernetes.io/tls-acme": "true"
                }
                "enabled": True,
                "host": get(oxr, "spec.ingressHost", ""),
                "tls": [
                    {
                        "hosts": [
                            get(oxr, "spec.ingressHost", "")
                        ],
                        "secretName": "${name}"
                    }
                ]
            },
            "monitoring": {
                "serviceMonitor": {
                    "enabled": True,
                    "extraLabels": {
                        "application.giantswarm.io/team": "demotechinc"
                    }
                },
            },
            "pdb": {
                "enabled": False
            },
            "redisConnectionSecretName": "demotech-rcc-elasticache-user"
        }
    }
}

wrappedHelmRelease = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2"
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "${name}-helm-release"
            "krm.kcl.dev/ready": readystr("${name}-helm-release")
        }
    }
    "spec": {
        "deletionPolicy": "Delete"
        "forProvider": {
            "manifest": helmRelease
        }
        "managementPolicies": ["*"]
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfig", {"name": "default"})
    }
}

_items += [wrappedHelmRepository, wrappedHelmRelease]
