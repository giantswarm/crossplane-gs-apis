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

_globalEndpoint = get(_ocds, "elasticache-replication-group-global.Resource.status.atProvider.primaryEndpointAddress", "") if _globalEnabled else ""
_globalROEndpoint = get(_ocds, "elasticache-replication-group-global.Resource.status.atProvider.readerEndpointAddress", "") if _globalEnabled else ""

_endpoint = get(_ocds, "elasticache-replication-group-local.Resource.status.atProvider.primaryEndpointAddress", "") if _createReplicationGroup else ""
_readerep = get(_ocds, "elasticache-replication-group-local.Resource.status.atProvider.readerEndpointAddress", "") if _createReplicationGroup else ""
_port = 0
if _globalEnabled:
    _port = get(_ocds, "elasticache-replication-group-global.Resource.status.atProvider.port", "")
elif _createReplicationGroup:
    _port = get(_ocds, "elasticache-replication-group-local.Resource.status.atProvider.port", "")
else:
    _port = get(_ocds, "elasticache-cluster-0.Resource.status.atProvider.port", "")
    _endpoint = get(_ocds, "elasticache-cluster-0.Resource.status.atProvider.clusterAddress", "")

_globalReplicationId = get(_ocds, "elasticache-replication-group-global.Resource.status.atProvider.id", "")
_localReplicationId = get(_ocds, "elasticache-replication-group-local.Resource.status.atProvider.id", "")

_ipgn = get(_oxr, "spec.parameterGroupName", "")
if get(_oxr, "spec.parameterGroupConfiguration", False):
    _ipgn = get(_oxr, "spec.parameterGroupConfiguration.name", "")

_newdxr = {
    **_oxr,
    **{
        "status": {
            if _globalEndpoint:
                globalEndpoint: _globalEndpoint,
            if _globalROEndpoint:
                globalReaderEndpoint: _globalROEndpoint,

            if _globalReplicationId:
                globalReplicationGroupId: _globalReplicationId,
            if _localReplicationId:
                replicationGroupId: _localReplicationId,

            if _ipgn:
                parameterGroupName: _ipgn,
            if _port:
                port: _port,
            if _endpoint:
                endpoint: _endpoint,
            if _readerep:
                readerEndpoint: _readerep,
        },
    }
}

items = [_newdxr]