import regex

_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds
_dcds = option("params").dcds

get = lambda x: any, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

_subnets = get(_ocds, "peered-vpc-network.Resource.status.privateSubnets", [])

_dbsnindex = get(_oxr, "spec.subnetGroupIndex.database", False)
_dbSnIds = [k for _, k in _subnets[_dbsnindex]] if _dbsnindex and _subnets else []

_cachesnindex = get(_oxr, "spec.subnetGroupIndex.cache", False)
_cacheSnIds = [k for _, k in _subnets[_cachesnindex]] if _cachesnindex and _subnets else []

_dbPatch = {
    **get(_dcds, "rds-cluster.Resource", {}),
    **{
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "rds-cluster"
            }
        }
        "spec": {
            "subnetIds": _dbSnIds
            "vpcId": get(_oxr, "status.vpcId", "")
        }
    }
} if all_true([
    _dbSnIds,
    get(_dcds, "rds-cluster.Resource", False),
    get(_oxr, "status.vpcId", False),
]) else {}

_cachePatch = {
    **get(_dcds, "cache-cluster.Resource", {}),
    **{
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "cache-cluster"
            }
        }
        "spec": {
            "subnetIds": _cacheSnIds
            "vpcId": get(_oxr, "status.vpcId", "")
        }
    }
} if all_true([
    _cacheSnIds,
    get(_oxr, "spec.cache", False),
    get(_oxr, "status.vpcId", False),
]) else {}

items = [
    k for _, k in [_dbPatch, _cachePatch] if k
]
