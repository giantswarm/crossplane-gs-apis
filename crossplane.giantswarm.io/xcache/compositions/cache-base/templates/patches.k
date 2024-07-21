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


_requiredClusters = len(get(_oxr, "spec.cacheClusters", [])) if get(_oxr, "spec.cacheClusters", False) else get(_oxr, "spec.numCacheClusters", 1)

_connectionSecretName = ""
_localReplicationGroup = get(_ocds, "elasticache-replication-group-local.Resource", False)

if _localReplicationGroup and all_true([c.status == "True" for c in get(_localReplicationGroup, "status.conditions", [])]):
    _connectionSecretName = get(_localReplicationGroup, "spec.writeConnectionSecretToRef.name", "")

_globalConnectionSecretName = ""
_globalReplicationGroup = get(_ocds, "elasticache-replication-group-global.Resource", False)
if _globalReplicationGroup and all_true([c.status == "True" for c in get(_globalReplicationGroup, "status.conditions", [])]):
    _globalConnectionSecretName = get(_globalReplicationGroup, "spec.writeConnectionSecretToRef.name", "")

_clusterEndpoints = [
    get(_ocds, "elasticache-cluster-${i}.Resource.status.atProvider.clusterAddress", "")
    for i in range(_requiredClusters)
]
_eps = [e for e in _clusterEndpoints if e]

_globalReplicationId = get(_ocds, "elasticache-replication-group-global.Resource.status.atProvider.id", "")
_localReplicationId = get(_ocds, "elasticache-replication-group-local.Resource.status.atProvider.id", "")

_ipgn = get(_oxr, "spec.parameterGroupName", "")
if get(_oxr, "spec.parameterGroupConfiguration", False):
    _ipgn = get(_oxr, "spec.parameterGroupConfiguration.name", "")

_ugId = get(_ocds, "elasticache-user-group.Resource.status.atProvider.id", "")

_items = [{
    **_oxr,
    **{
        "status": {
            if _connectionSecretName:
                connectionSecret: _connectionSecretName,

            if _eps:
                clusterEndpoints = _eps,

            if _endpoint:
                endpoint: _endpoint,

            if _globalConnectionSecretName:
                globalConnectionSecret: _globalConnectionSecretName,

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

            if _readerep:
                readerEndpoint: _readerep,

            if _ugId:
                userGroupId: _ugId,
        },
    }
}]
