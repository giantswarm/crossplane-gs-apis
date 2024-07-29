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

_subnets = get(_oxr, "status.vpc.privateSubnets", [])

_dbsnindex = get(_oxr, "spec.subnetGroupIndexes.database", False)
_dbSnIds = [k for _, k in _subnets[_dbsnindex]] if _dbsnindex != False and _subnets else []

_cachesnindex = get(_oxr, "spec.subnetGroupIndexes.cache", False)
_cacheSnIds = [k for _, k in _subnets[_cachesnindex]] if _cachesnindex != False and _subnets else []

_dbPatch = {
    **get(_dcds, "rds-base.Resource", {}),
    **{
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "rds-base"
            }
        }
        "spec": {
            "cidrBlocks": [
                get(_oxr, "status.vpc.cidrBlock", "")
            ] + get(_oxr, "status.vpc.additionalCidrBlocks", []),
            "subnetIds": _dbSnIds
        }
    }
} if all_true([
    _dbSnIds,
    get(_dcds, "rds-base.Resource", False),
    get(_oxr, "status.vpc.id", False),
]) else {}

_cachePatch = {
    **get(_dcds, "cache-base.Resource", {}),
    **{
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "cache-base"
            }
        }
        "spec": {
            "cidrBlocks": [
                get(_oxr, "status.vpcCidrBlock", "")
            ] + get(_oxr, "status.vpc.additionalCidrBlocks", []),
            "subnetIds": _cacheSnIds
        }
    }
} if all_true([
    _cacheSnIds,
    get(_dcds, "cache-base.Resource", False),
    get(_oxr, "spec.cache", False),
    get(_oxr, "status.vpc.id", False),
]) else {}

items = [
    k for _, k in [_dbPatch, _cachePatch] if k
]
