instancesCreated = [
    i
    for i in ocds if i.startswith("instance-")
]

readyState = all_true([
    exists("instance-0"),
    ready("instance-0"),
])

provisionedSecrets = ocdsstatus("rds-provisioning", "connectionSecrets", {})

newdxr = {
    **dxr,
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
                if readerEndpoint:
                    "readerEndpoint" = readerEndpoint,

                _port = ocdsstatus("rds-cluster", "port", False) if createCluster else ocdsstatus("instance-0", "port", False)
                if _port:
                    "port" = _port

            "ready" = readyState

            if all_true([
                get(oxr, "spec.provisionSql.enabled", True),
                provisionedSecrets,
                readyState,
            ]):
                "provisionedSecrets" = provisionedSecrets,

        }
    }
}

_items = [newdxr]