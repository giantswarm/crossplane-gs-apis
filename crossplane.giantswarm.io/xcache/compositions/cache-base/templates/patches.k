import regex

_oxr = option("params").oxr
_ocds = option("params").ocds

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

_createReplicationGroup = get(_oxr, "spec.createReplicationGroup", True)
_globalEnabled = all_true([
    False,
    _createReplicationGroup,
    get(_oxr, "spec.globalReplicationGroup.enabled", False)
])

_globalEndpoint = get(_ocds, "elasticache-replication-group-global.Resource.status.endpoint", "") if _globalEnabled else ""
_endpoint = get(_ocds, "elasticache-replication-group-local.Resource.status.endpoint", "") if _createReplicationGroup else ""

_port = 0
if _globalEnabled:
    _port = get(_ocds, "elasticache-replication-group-global.Resource.status.port", "")
elif _createReplicationGroup:
    _port = get(_ocds, "elasticache-replication-group-local.Resource.status.port", "")
else:
    _port = get(_ocds, "elasticache-cluster-0.Resource.status.port", "")
    _endpoint = get(_ocds, "elasticache-cluster-0.Resource.status.endpoint", "")

_globalReplicationId = get(_ocds, "elasticache-replication-group-global.Resource.status.id", "")
_localReplicationId = get(_ocds, "elasticache-replication-group-local.Resource.status.id", "")

_newdxr = {
    **_oxr,
    **{
        "status": {
            if _globalEndpoint:
                globalEndpoint: _globalEndpoint,
            if _globalReplicationId:
                globalReplicationGroupId: _globalReplicationId,
            if _localReplicationId:
                replicationGroupId: _localReplicationId,
            if _port:
                port: _port,
            if _endpoint:
                endpoint: _endpoint,
        },
    }
}

items = [_newdxr]