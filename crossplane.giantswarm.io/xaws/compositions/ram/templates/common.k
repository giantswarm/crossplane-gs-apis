import regex
oxr = option("params").oxr
dxr = option("params").dxr
ocds = option("params").ocds
dcds = option("params").dcds

exists = lambda x: any -> bool {
    """
    Check if a value exists.
    """
    x in list(ocds)
}

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
dp = get(oxr, "spec.deletionPolicy", "Delete")
labels = get(oxr, "metadata.labels", {})
mgmtPolicy = get(oxr, "spec.managementPolicies", [])
pcr = get(oxr, "spec.providerConfigRef", {"name": "default"})
region = get(oxr, "spec.localVpc.region", "eu-central-1")
tags = get(oxr, "spec.tags.common", {}) | {
    region: region,
}
publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})