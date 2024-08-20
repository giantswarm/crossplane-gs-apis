_subnets = get(oxr, "status.vpc.privateSubnets", [])

_dbsnindex = get(oxr, "spec.subnetGroupIndexes.database", False)

_dbSnIds = [
    k.id
    for _, k in _subnets[_dbsnindex]
] if all_true([
    _dbsnindex != False,
    _subnets,
    len(_subnets) > _dbsnindex
]) else []

_cachesnindex = get(oxr, "spec.subnetGroupIndexes.cache", False)
_cacheSnIds = [
    k.id
    for _, k in _subnets[_cachesnindex]
] if all_true([
    _cachesnindex != False,
    _subnets,
    len(_subnets) > _cachesnindex
]) else []


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

# cb.ToPatch("status.cacheConnectionSecret", "status.connectionSecret"),
# cb.ToPatch("status.rdsConnectionSecret", "status.connectionSecret"),

cacheConnectionSecret = ocdsstatus("cache-base", "userSecrets.app", ocdsstatus("cache-base", "connectionSecret", ""))
rdsConnectionSecret = ocdsstatus("rds-base", "provisionedSecrets.app", ocdsstatus("rds-base", "connectionSecret", ""))

newdxr = {
    **dxr,
    **{
        "status" = {
            "ready" = allReady(),

            if allReady():
                "cacheConnectionSecret" = cacheConnectionSecret,
                "rdsConnectionSecret" = rdsConnectionSecret,
        },
    },
}

items = [
    k for _, k in [_dbPatch, _cachePatch, newdxr] if k
]
