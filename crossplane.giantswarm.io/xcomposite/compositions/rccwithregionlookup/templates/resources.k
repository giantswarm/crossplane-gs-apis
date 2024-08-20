import regex

oxr = option("params").oxr
dxr = option("params").dxr
ocds = option("params").ocds
dcds = option("params").dcds

get = lambda x: {:}, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

exists = lambda x: any -> bool {
    """
    Check if a value exists.
    """
    x in list(ocds)
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    _x = None
    if get(ocds, "${x}.Resource.status.atProvider", False):
        _x = get(ocds, "${x}.Resource.status.atProvider.${y}", d)
    else:
        _x = get(ocds, "${x}.Resource.status.${y}", d)
    _x if _x else d
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditionsReady = all_true([
        get(c, "status", "False") == "True" for c in ocdsstatus(x, "conditions", [])
    ])

    ap = get(ocds, "${x}.Resource.status.atProvider", {})
    objectReady = any_true([
        ocdsstatus(x, "ready", False),
        len(list(ap)) > 0,
    ])

    all_true([
        any_true([exists(x), conditionsReady]),
        objectReady,
    ])
}

readystr = lambda y: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(y) else "False"
}

allReady = lambda -> bool {
    """
    Check if all managed resources are ready.
    """
    all_true([
        ready(x)
        for x in list(ocds)
    ])
}

mcLookup = get(ocds, "mc-lookup.Resource", {})
mcApiVersion = ocdsstatus("mc-lookup", "manifest.spec.infrastructureRef.apiVersion", "")
mcKind = ocdsstatus("mc-lookup", "manifest.spec.infrastructureRef.kind", "")
mcName = ocdsstatus("mc-lookup", "manifest.metadata.name", "")
mcNamespace = ocdsstatus("mc-lookup", "manifest.metadata.namespace", "")


clusterLookup = get(ocds, "cluster-lookup.Resource", {})
apiVersion = ocdsstatus("cluster-lookup", "manifest.spec.infrastructureRef.apiVersion", "")
kind = ocdsstatus("cluster-lookup", "manifest.spec.infrastructureRef.kind", "")
name = ocdsstatus("cluster-lookup", "manifest.metadata.name", "")
namespace = ocdsstatus("cluster-lookup", "manifest.metadata.namespace", "")

if kind:
    assert kind in ["AWSCluster", "AWSManagedCluster"], "Unsupported kind: ${kind}"

awsClusterObject = {} if not clusterLookup else {
    "apiVersion": apiVersion,
    "kind": kind,
    "metadata": {
        "name": name,
        "namespace": namespace,
    }
}

awsMCClusterObject = {} if not mcLookup else {
    "apiVersion": mcApiVersion,
    "kind": mcKind,
    "metadata": {
        "name": mcName,
        "namespace": mcNamespace,
    }
}

kubernetesObject = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2",
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "aws-cluster"
            "krm.kcl.dev/ready": readystr("aws-cluster")
        }
    }
    "spec": {
        "managementPolicies": ["Observe"],
        "forProvider": {
            "manifest": awsClusterObject,
        }
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfigRef", {"name": "default"}),
    }
} if awsClusterObject else {}

kubernetesMCObject = {
    "apiVersion": "kubernetes.crossplane.io/v1alpha2",
    "kind": "Object"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name" = "aws-cluster-mc"
            "krm.kcl.dev/ready": readystr("aws-cluster")
        }
    },
    "spec": {
        "managementPolicies": ["Observe"],
        "forProvider": {
            "manifest": awsMCClusterObject,
        }
        "providerConfigRef": get(oxr, "spec.kubernetesProviderConfigRef", {"name": "default"}),
    },
} if awsMCClusterObject else {}

mcRegion = ocdsstatus("aws-cluster-mc", "manifest.spec.region", False)

region = ocdsstatus("aws-cluster", "manifest.spec.region", False)
availabilityZones = {} if not region else {
    regex.replace(k.availabilityZone, region, "") = False
    for k in ocdsstatus("aws-cluster", "manifest.spec.network.subnets", [])
}

rdsCacheCluster = get(dcds, "rds-cache-cluster.Resource", {})

newRdsCacheCluster = {
    **rdsCacheCluster,
    **{
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "rds-cache-cluster"
                "krm.kcl.dev/ready" = readystr("rds-cache-cluster")
            }
        },
        "spec": {
            "vpc": {
                "peering": {
                    "remoteVpcs" = [
                        {
                            "name" = get(rvpc, "name", ""),
                            "region" = get(rvpc, "region", mcRegion if rvpc.name == mcName else region),

                            if get(rvpc, "providerConfigRef", False):
                                "providerConfigRef" = get(rvpc, "providerConfigRef", {"name": "default"}),
                        }
                        for _, rvpc in get(oxr, "spec.rdsCacheClusterParameters.vpc.peering.remoteVpcs", [])
                    ]
                },
                "transitGateway": {
                    "remoteVpcs" = [
                        {
                            "name" = get(rvpc, "name", ""),
                            "region" = get(rvpc, "region", mcRegion if rvpc.name == mcName else region),

                            if get(rvpc, "providerConfigRef", False):
                                "providerConfigRef" = get(rvpc, "providerConfigRef", {"name": "default"}),
                            if get(rvpc, "accountId", False):
                                "accountId" = get(rvpc, "accountId", ""),
                            if get(rvpc, "cidrBlocks", False):
                                "cidrBlocks" = get(rvpc, "cidrBlocks", []),
                            if get(rvpc, "prefixLists", False):
                                "prefixLists" = get(rvpc, "prefixLists", []),
                            if get(rvpc, "routeTableIds", False):
                                "routeTableId" = get(rvpc, "routeTableIds", []),
                            if get(rvpc, "subnetIds", False):
                                "subnetIds" = get(rvpc, "subnetIds", []),
                            if get(rvpc, "vpcId", False):
                                "vpcId" = get(rvpc, "vpcId", ""),
                        }
                        for _, rvpc in get(oxr, "spec.rdsCacheClusterParameters.vpc.transitGateway.remoteVpcs", [])
                    ],
                },
            },
        },
    },
} if all_true([
    region,
    mcRegion,
    rdsCacheCluster,
]) else {}

newdxr = {
    **dxr,
    **{
        "status": {
            "region" = region,
            "mcregion" = mcRegion,
            "availabilityZones" = sorted([k for k, _ in availabilityZones]),
            "ready" = allReady(),
        },
    },
} if all_true([
    region,
    mcRegion,
    availabilityZones,
]) else {}

items = [i for i in [kubernetesObject, kubernetesMCObject, newdxr, newRdsCacheCluster] if i]
