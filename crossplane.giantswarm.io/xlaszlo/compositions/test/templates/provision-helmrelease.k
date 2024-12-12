helmRepository = {
    "apiVersion": "source.toolkit.fluxcd.io/v1beta2"
    "kind": "HelmRepository"
    "metadata": {
        "name": "python-service-2"
        "namespace": "org-demotech"
    }
    "spec": {
        "interval": "5m0s"
        "provider": "generic"
        "secretRef": {
            "name": "ghcr-pull-secret"
        }
        "timeout": "60s"
        "type": "oci"
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
        "name": "python-service-2"
        "namespace": "org-demotech"
    }
    "spec": {
        "chart": {
            "spec": {
                "chart": "python-service-1"
                "reconcileStrategy": "ChartVersion"
                "sourceRef": {
                    "kind": "HelmRepository"
                    "name": "python-service-2"
                }
                "version": ">=0.1.0-0"
            }
        }
        "interval": "1m"
        "kubeConfig": {
            "secretRef": {
                "name": "demotech-rds-kubeconfig"
            }
        }
        "storageNamespace": "default"
        "suspend": "false"
        "targetNamespace": "default"
        "timeout": "3m"
        "values": {
            "autoscaling": {
                "enabled": "false"
            }
            "database": {
                "connectionSecretName": "python-service-1-rds-user"
                "name": "python-service-1"
            }
            "imagePullSecrets": [
                {
                    "name": "ghcr-pull-secret"
                }
            ]
            "inMemoryStore": "false"
            "ingress": {
                "annotations": {
                    "kubernetes.io/tls-acme": "true"
                }
                "enabled": "true"
                "host": "python-service-2.demotech-rds.awsprod.gigantic.io"
                "tls": [
                    {
                        "hosts": [
                            "python-service-2.demotech-rds.awsprod.gigantic.io"
                        ]
                        "secretName": "python-service-2"
                    }
                ]
                "monitoring": {
                    "serviceMonitor": {
                        "enabled": "true"
                        "extraLabels": {
                            "application.giantswarm.io/team": "demotechinc"
                        }
                    }
                }
                "pdb": {
                    "enabled": "false"
                }
                "redisConnectionSecretName": "demotech-rcc-elasticache-user"
            }
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
