_subnets = get(oxr, "status.vpc.privateSubnets", [])

_dbsnindex = get(oxr, "spec.subnetGroupIndexes.database", False)
_dbSnIds = [k.id for _, k in _subnets[_dbsnindex]] if _dbsnindex != False and _subnets else []

_cachesnindex = get(oxr, "spec.subnetGroupIndexes.cache", False)
_cacheSnIds = [k.id for _, k in _subnets[_cachesnindex]] if _cachesnindex != False and _subnets else []


vpcs = ocdsstatus("peered-vpc-network", "vpcs", {})

cidrBlocks = [
    i for r in [
        [ get(vpc, "cidrBlock", "") ] + get(vpc, "additionalCidrBlocks", [])
        for _, vpc in vpcs
    ]
    for i in r if i
]

_dbPatch = {
    **get(dcds, "rds-base.Resource", {}),
    **{
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "rds-base"
            }
        }
        "spec": {
            "cidrBlocks": cidrBlocks,
            "subnetIds": _dbSnIds
        }
    }
} if all_true([
    _dbSnIds,
    get(ocds, "rds-base.Resource", False),
    get(oxr, "status.vpc.id", False),
]) else {}

_cachePatch = {
    **get(dcds, "cache-base.Resource", {}),
    **{
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "cache-base"
            }
        }
        "spec": {
            "cidrBlocks": cidrBlocks,
            "subnetIds": _cacheSnIds
        }
    }
} if all_true([
    _cacheSnIds,
    get(ocds, "cache-base.Resource", False),
    get(oxr, "spec.cache", False),
    get(oxr, "status.vpc.id", False),
]) else {}

newdxr = {
    **dxr,
    **{
        "status" = {
            "ready" = allReady()
        },
    },
}

items = [
    k for _, k in [_dbPatch, _cachePatch, newdxr] if k
]
