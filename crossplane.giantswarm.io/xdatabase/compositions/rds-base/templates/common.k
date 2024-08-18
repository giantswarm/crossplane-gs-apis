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

readystr = lambda x: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(x) else "False"
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

appName = get(oxr, "spec.claimRef.name", "")
createCluster = get(oxr, "spec.createCluster", True)
engine = get(oxr, "spec.engine", "")
dp = get(oxr, "spec.deletionPolicy", "Delete")
keyId = get(oxr, "status.kmsKeyId", False)
namespace = get(oxr, "spec.claimRef.namespace", "default")
region = get(oxr, "spec.region", "eu-central-1")
pcr = get(oxr, "spec.providerConfigRef", {"name": "default"})
labels = get(oxr, "metadata.labels", {}) | {"region": region}
tags = labels | get(oxr, "spec.tags", {})

port = get(oxr, "status.port", False)
restoreToPointInTime = {
    if createCluster:
        "sourceDbClusterIdentifier": get(oxr, "spec.restoreToPointInTime.sourceDbClusterIdentifier", None),
        "restoreType": get(oxr, "spec.restoreToPointInTime.restoreType", "full-copy"),
    else:
        "sourceDbInstanceIdentifier" = get(oxr, "spec.restoreToPointInTime.sourceDbClusterIdentifier", None)
        "sourceDbInstanceAutomatedBackupsArn" = get(oxr, "spec.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn", None)
        "sourceDbiResourceId" = get(oxr, "spec.restoreToPointInTime.sourceDbiResourceId", None)

    _v = get(oxr, "spec.restoreToPointInTime.restoreToTime", False)
    if _v:
        "restoreToTime": get(oxr, "spec.restoreToPointInTime.restoreToTime", None)
    else:
        "useLatestRestorableTime": get(oxr, "spec.restoreToPointInTime.useLatestRestorableTime", True)
}

s3import = get(oxr, "spec.s3Import", False)

masterInstance = ready("instance-0") and ocdsstatus("instance-0", "id", False)
clusterIdentifier = ocdsstatus("rds-cluster", "id", "")
clusterResourceId = ocdsstatus("rds-cluster", "clusterResourceId", "")
endpoint = ocdsstatus("rds-cluster", "endpoint", "")
clusterArn = ocdsstatus("rds-cluster", "arn", "")

mgmtPolicy = get(oxr, "spec.managementPolicies", [])
publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})

_secretRef: bool|str = False
if createCluster:
    if ready("rds-cluster"):
        _secretRef = ocdsspec("rds-cluster", "writeConnectionSecretToRef.name", "")
else:
    if ready("instance-0"):
        _secretRef = ocdsspec("instance-0", "writeConnectionSecretToRef.name", "")
_connectionSecret = _secretRef

clusterCreated: bool = ready("rds-cluster")
_specInstances = get(oxr, "spec.instances", [])

if not _specInstances and get(oxr, "spec.instanceCount", 0) > 0:
    _specInstances = [{} for i in range(get(oxr, "spec.instanceCount", 0))]

