import manifests

_appName = "test"

claimRef = {
    name: "testme"
} #option("params").oxr.spec.claimRef

if bool(claimRef):
    _appName = claimRef.name

labels = {}
region = {}
tags = {}
zones = {}
dp = {}

_subnets = option("params").oxr.status.subnets
_subnets += ["" for _i in range ((3 * 6) - len(_s))]

_s = [
    3, 4, 4
]

_public = 1
_private = 3

func = lambda pub: int, pri: int, subnets: [] -> [] {
    _a = [
        subnets[_i] if _i < (_public * 3) else 0
        for _i in range(0, (3 * 3))
    ]

    _a += [
        subnets[_i] if _i < (_public * 3) + (_private * 3) else 0
        for _i in range(_public * 3, (_public + 3) * 3)
    ]
}

subnets = func(_public, _private, _s)
length = len(subnets)


deployments = [ {
    metadata.name = _appName
}, {}]
services = [{}, {}]

manifests.yaml_stream(deployments + services)