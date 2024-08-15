import regex
oxr = option("params").oxr
dxr = option("params").dxr
ocds = option("params").ocds

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

getwparentfb = lambda x: {:}, p: {:}, y: str, z: str, d: any -> any {
    """
    Get with fallback to parent status
    Tries to get a path from a dictionary, if it fails,
    tries to get it from the parent dictionary.

    If that fails, falls back to the default value provided.
    """
    get(x, y, get(p, "${z}", d))
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    get(ocds, "${x}.Resource.status.atProvider.${y}", d)
}

appName = get(oxr, "spec.claimRef.name", "")
claimRef = get(oxr, "spec.claimRef", {})
dp = get(oxr, "spec.deletionPolicy", "Delete")
labels = get(oxr, "metadata.labels", {})
peeringEnabled = get(oxr, "spec.peering.enabled", False)
pcr = get(oxr, "spec.providerConfigRef", {"name": "default"})
region = get(oxr, "spec.region", "eu-central-1")
tags = labels | get(oxr, "spec.tags.common", {}) | {
    "region": region,
}

mgmtPolicy = get(oxr, "spec.managementPolicies", [])
publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})