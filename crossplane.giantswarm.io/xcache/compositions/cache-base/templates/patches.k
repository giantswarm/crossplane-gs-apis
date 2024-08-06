globalEndpoint = ocdsstatus("elasticache-replication-group-global", "primaryEndpointAddress", "") if globalEnabled else ""
globalROEndpoint = ocdsstatus("elasticache-replication-group-global", "readerEndpointAddress", "") if globalEnabled else ""

endpoint = ocdsstatus("elasticache-replication-group-local", "primaryEndpointAddress", "") if createReplicationGroup else ""
readerep = ocdsstatus("elasticache-replication-group-local", "readerEndpointAddress", "") if createReplicationGroup else ""

_port = 0
if globalEnabled:
    _port = ocdsstatus("elasticache-replication-group-global", "port", False)
elif createReplicationGroup:
    _port = ocdsstatus("elasticache-replication-group-local", "port", False)
else:
    _port = ocdsstatus("elasticache-cluster-0", "port", False)

localClusterName = "elasticache-replication-group-local"
_connectionSecretName = ""
if ready(localClusterName):
    _connectionSecretName = ocdsspec(localClusterName, "writeConnectionSecretToRef.name", "")

globalClusterName = "elasticache-replication-group-global"
_globalConnectionSecretName = ""
if ready(globalClusterName):
    _globalConnectionSecretName = ocdsspec(globalClusterName, "writeConnectionSecretToRef.name", "")


cc = get(oxr, "spec.cacheClusters", [])
rclen = len(cc) if cc else get(oxr, "spec.numCacheClusters", 1)
clusterEndpoints = [
    e for e in [
        ocdsstatus("elasticache-cluster-${i}", "clusterAddress", "")
        for i in range(rclen)
    ]
    if e
]

_globalReplicationId = ocdsstatus("elasticache-replication-group-global", "id", "")
_localReplicationId = ocdsstatus("elasticache-replication-group-local", "id", "")

_ipgn = get(oxr, "spec.parameterGroupName", "")
if get(oxr, "spec.parameterGroupConfiguration", False):
    _ipgn = get(oxr, "spec.parameterGroupConfiguration.name", "")

_ugId = ocdsstatus("elasticache-user-group", "id", "")

newdxr = {
    **oxr,
    **{
        "status": {
            if _connectionSecretName:
                "connectionSecret": _connectionSecretName,

            if clusterEndpoints:
                "clusterEndpoints" = clusterEndpoints,

            if endpoint:
                "endpoint": endpoint,

            if _globalConnectionSecretName:
                "globalConnectionSecret": _globalConnectionSecretName,

            if globalEndpoint:
                "globalEndpoint": globalEndpoint,

            if globalROEndpoint:
                "globalReaderEndpoint": globalROEndpoint,

            if _globalReplicationId:
                "globalReplicationGroupId": _globalReplicationId,

            if _localReplicationId:
                "replicationGroupId": _localReplicationId,

            if _ipgn:
                "parameterGroupName": _ipgn,

            if _port:
                "port": _port,

            if readerep:
                "readerEndpoint": readerep,

            if _ugId:
                "userGroupId": _ugId,
        },
    }
}

_items = [newdxr]
