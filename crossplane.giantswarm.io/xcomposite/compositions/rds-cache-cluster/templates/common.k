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

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    _x = None
    if get(_ocds, "${x}.Resource.status.atProvider", False):
        get(_ocds, "${x}.Resource.status.atProvider.${y}", d)
    else:
        _x = get(_ocds, "${x}.Resource.status.${y}", d)
    _x if _x else d
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


# AppName here must be all lowercase with all symbols removed
appName = regex.replace(get(_oxr, "spec.claimRef.name", ""), "[-_\.]", "_").lower()
dp = get(_oxr, "spec.deletionPolicy", "Delete")
mgmtPolicy = get(_oxr, "spec.managementPolicies", [])
namespace = get(_oxr, "spec.claimRef.namespace", "default")
pcr = get(_oxr, "spec.providerConfigRef", {"name": "default"})