import regex

oxr = option("params").oxr
dxr = option("params").dxr
ocds = option("params").ocds
dcds = option("params").dcds

get = lambda obj: {:}, path: str, default: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(path, "\.")
    c = p[0]
    y = ".".join(p[1::])
    obj[c] if len(p) == 1 and c in obj else default if c not in obj else get(obj[c], path, default)
}

name = get(oxr, "spec.name", "THIS_SHALL_NOT_HAPPEN")

_items = []
