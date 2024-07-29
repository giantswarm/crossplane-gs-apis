_secretRef: bool|str = False
if createCluster:
    if ready("rds-cluster"):
        _secretRef = ocdsspec("rds-cluster", "writeConnectionSecretToRef.name", "")

clusterCreated: bool = ready("rds-cluster")

newdxr = {
    **_oxr,
    **{
        "status": {
            if get(_oxr, "spec.eso.enabled", True) and connectionSecret:
                "esoConnectionSecret": "${appName}-rds-master"
            if not createCluster and masterInstance:
                "endpoint": get(masterInstance, "address", ""),
                "port": get(masterInstance, "port", 0),
            if _secretRef:
                "connectionSecret": _secretRef
            if createCluster and clusterCreated:
                "clusterIdentifier": clusterIdentifier,
                "clusterResourceId": clusterResourceId,
                "clusterArn": clusterArn,
                "endpoint": endpoint,

                _port = ocdsstatus("rds-cluster", "port", False) if createCluster else ocdsstatus("instance-0", "port", False)
                if _port:
                    "port": _port

        }
    }
}