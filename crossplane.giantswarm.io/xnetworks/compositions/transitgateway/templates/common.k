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

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    get(_ocs, "${x}.Resource.status.atProvider.${y}", d)
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditions = get(_ocs, "${x}.Resource.status.conditions", [])
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
