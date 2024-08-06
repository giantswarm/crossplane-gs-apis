clusterCreated: bool = ready("rds-cluster")

newdxr = {
    **oxr,
    **{
        "status": {
            if get(oxr, "spec.eso.enabled", True) and _connectionSecret:
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