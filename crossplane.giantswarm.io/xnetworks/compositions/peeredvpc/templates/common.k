import regex
_oxr = option("params").oxr
_dxr = option("params").dxr
_ocs = option("params").ocds

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

ready = lambda x: any, y: str -> str {
    """
    Check if a value is ready.
    """
    conditions = get(x, "${y}.Resource.status.conditions", [])
    "True" if all_true([
        get(c, "status", "False") == "True" for c in conditions
    ]) else "False"
}

appName = get(_oxr, "spec.claimRef.name", "")
claimRef = get(_oxr, "spec.claimRef", {})
dp = get(_oxr, "spec.deletionPolicy", "Delete")
labels = get(_oxr, "metadata.labels", {})
peeringEnabled = get(_oxr, "spec.peering.enabled", False)
pcr = get(_oxr, "spec.providerConfigRef", {"name": "default"})
region = get(_oxr, "spec.region", "eu-central-1")
tags = labels | get(_oxr, "spec.tags.common", {}) | {
    "region": region,
}
