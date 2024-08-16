import regex

oxr = option("params").oxr
ocds = option("params").ocds

get = lambda x: {:}, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.

    x: The dictionary to search in.
    y: The path to search for.
    d: The default value to return if the path is not found.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

getwparent = lambda x: {:}, p: {:}, y: str, d: any -> any {
    """
    Get with fallback to parent
    Tries to get a path from a dictionary, if it fails,
    tries to get it from the parent dictionary.

    If that fails, falls back to the default value provided.
    """
    get(x, y, get(p, "spec.${y}", d))
}

ocdsspec = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the spec of an ocds resource.
    """
    get(ocds, "${x}.Resource.spec.${y}", d)
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    get(ocds, "${x}.Resource.status.atProvider.${y}", d)
}

exists = lambda x: any -> bool {
    """
    Check if a value exists.
    """
    x in list(ocds)
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditions = get(ocds, "${x}.Resource.status.conditions", [])
    any_true([
        exists(x),
        all_true([
            get(c, "status", "False") == "True" for c in conditions
        ])
    ])
}

readystr = lambda x: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(x) else "False"
}

appName = get(oxr, "spec.claimRef.name", "")
createReplicationGroup = get(oxr, "spec.createReplicationGroup", True)
dp = get(oxr, "spec.deletionPolicy", "Delete")
keyId = get(oxr, "status.kmsKeyId", False)
namespace = get(oxr, "spec.claimRef.namespace", "default")
region = get(oxr, "spec.region", "eu-central-1")
pcr = get(oxr, "spec.providerConfigRef", {"name": "default"})
azs = [
    "${region}${az}"
    for az in get(oxr, "spec.availabilityZones", [])
]
labels = get(oxr, "metadata.labels", {}) | {"region": region}

tags = labels | get(oxr, "spec.tags", {})

globalEnabled = all_true([
    False,
    createReplicationGroup,
    get(oxr, "spec.globalReplicationGroup.enabled", False)
])

userNames = get(oxr, "spec.userNames", []) + [appName, "default"]
mgmtPolicy = get(oxr, "spec.managementPolicies", [])
publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})


globalEndpoint = ocdsstatus("elasticache-replication-group-global", "primaryEndpointAddress", "") if globalEnabled else ""
globalROEndpoint = ocdsstatus("elasticache-replication-group-global", "readerEndpointAddress", "") if globalEnabled else ""

cc = get(oxr, "spec.cacheClusters", [])
rclen = len(cc) if cc else get(oxr, "spec.numCacheClusters", 1)
clusterEndpoints = [
    e for e in [
        ocdsstatus("elasticache-cluster-${i}", "clusterAddress", "")
        for i in range(rclen)
    ]
    if e
]

endpoint = ocdsstatus("elasticache-replication-group-local", "primaryEndpointAddress", "") if createReplicationGroup else clusterEndpoints[0] if clusterEndpoints else ""
readerep = ocdsstatus("elasticache-replication-group-local", "readerEndpointAddress", "") if createReplicationGroup else endpoint

_port = 0
if globalEnabled:
    _port = ocdsstatus("elasticache-replication-group-global", "port", False)
elif createReplicationGroup:
    _port = ocdsstatus("elasticache-replication-group-local", "port", False)
else:
    _port = ocdsstatus("elasticache-cluster-0", "port", False)

