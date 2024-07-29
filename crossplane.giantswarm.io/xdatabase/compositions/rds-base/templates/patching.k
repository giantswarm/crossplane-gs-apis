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
                "esoConnectionSecret" = "${appName}-rds-master"
            if not createCluster and masterInstance:
                "endpoint" = ocdsstatus("instance-0", "address", ""),
                "port" = ocdsstatus("instance-0", "port", 0),
            if _secretRef:
                "connectionSecret" = _secretRef
            if createCluster and clusterCreated:
                if clusterIdentifier:
                    "clusterIdentifier" = clusterIdentifier
                if clusterResourceId:
                    "clusterResourceId" = clusterResourceId,
                if clusterArn:
                    "clusterArn" = clusterArn,
                if endpoint:
                    "endpoint" = endpoint,

                _port = ocdsstatus("rds-cluster", "port", False) if createCluster else ocdsstatus("instance-0", "port", False)
                if _port:
                    "port" = _port

        }
    }
}

_items = [newdxr]