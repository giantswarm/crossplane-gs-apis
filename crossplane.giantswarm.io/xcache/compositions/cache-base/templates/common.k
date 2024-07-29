import regex

_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds
_dcds = option("params").dcds

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
    get(_ocds, "${x}.Resource.spec.${y}", d)
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    get(_ocds, "${x}.Resource.status.atProvider.${y}", d)
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditions = get(_ocds, "${x}.Resource.status.conditions", [])
    all_true([
        get(c, "status", "False") == "True" for c in conditions
    ])
}

readystr = lambda x: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(x) else "False"
}

appName = get(_oxr, "spec.claimRef.name", "")
createReplicationGroup = get(_oxr, "spec.createReplicationGroup", True)
dp = get(_oxr, "spec.deletionPolicy", "Delete")
keyId = get(_oxr, "status.kmsKeyId", False)
region = get(_oxr, "spec.region", "eu-central-1")
pcr = get(_oxr, "spec.providerConfigRef", {"name": "default"})
azs = [
    "${region}${az}"
    for az in get(_oxr, "spec.availabilityZones", [])
]
labels = get(_oxr, "metadata.labels", {}) | {"region": region}

tags = labels | get(_oxr, "spec.tags", {})

globalEnabled = all_true([
    False,
    createReplicationGroup,
    get(_oxr, "spec.globalReplicationGroup.enabled", False)
])
