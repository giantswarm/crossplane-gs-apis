localClusterName = "elasticache-replication-group-local"
_connectionSecretName = ""
if ready(localClusterName):
    _connectionSecretName = ocdsspec(localClusterName, "writeConnectionSecretToRef.name", "")

globalClusterName = "elasticache-replication-group-global"
_globalConnectionSecretName = ""
if ready(globalClusterName):
    _globalConnectionSecretName = ocdsspec(globalClusterName, "writeConnectionSecretToRef.name", "")

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
