import regex

_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds
_dcds = option("params").dcds

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
    x in list(_ocds)
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditions = get(_ocds, "${x}.Resource.status.conditions", [])
    any_true([
        exists(x),
        all_true([
            get(c, "status", "False") == "True"
            for c in conditions
        ])
    ])
}

readystr = lambda y: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(y) else "False"
}

_clusterLookup = get(_ocds, "cluster-lookup.Resource", {})

_apiVersion = get(_clusterLookup, "status.atProvider.manifest.spec.infrastructureRef.apiVersion", "")
_kind = get(_clusterLookup, "status.atProvider.manifest.spec.infrastructureRef.kind", "")
_name = get(_clusterLookup, "status.atProvider.manifest.metadata.name", "")
_namespace = get(_clusterLookup, "status.atProvider.manifest.metadata.namespace", "")

if _kind:
    assert _kind in ["AWSCluster", "AWSManagedCluster"], "Unsupported kind: ${_kind}"

_awsClusterObject = {} if not _clusterLookup else {
    apiVersion: _apiVersion,
    kind: _kind,
    metadata: {
        name: _name,
        namespace: _namespace,
    }
}

_kubernetesObject = {
    apiVersion: "kubernetes.crossplane.io/v1alpha2",
    kind: "Object"
    metadata: {
        annotations: {
            "krm.kcl.dev/composition-resource-name" = "aws-cluster"
            "krm.kcl.dev/ready": readystr("aws-cluster")
        }
    }
    spec: {
        managementPolicies: ["Observe"],
        forProvider: {
            manifest: _awsClusterObject,
        }
        providerConfigRef: get(_oxr, "spec.kubernetesProviderConfigRef", {"name": "default"}),
    }
} if _awsClusterObject else {}

_region = get(_ocds, "aws-cluster.Resource.status.atProvider.manifest.spec.region", False)
_availabilityZones = {} if not _region else {
    regex.replace(k.availabilityZone, _region, "") = False
    for k in get(_ocds, "aws-cluster.Resource.status.atProvider.manifest.spec.network.subnets", [])
}

print("OBJ REGION: ", _region)
print("OBJ AZs: ", _availabilityZones)
_dxr = {
    **_oxr,
    **{
        "status": {
                "region" = _region
                "availabilityZones" = sorted([k for k, _ in _availabilityZones])
        }
    },
} if _region and _availabilityZones else {}

items = [i for i in [_kubernetesObject, _dxr] if i]
