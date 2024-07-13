import regex

_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds
_dcds = option("params").dcds

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

# If we are not creating a replication group, check how many cache clusters have
# been requested and default a list of empty dictionaries as being the cache
# cluster template.
_requiredClusters = get(_oxr, "spec.cacheClusters", []) if get(_oxr, "spec.cacheClusters", False) else [
    {}
    for i in range(get(_oxr, "spec.numCacheClusters", 1))
    if not get(_oxr, "spec.createReplicationGroup", False)
]

_region = get(_oxr, "spec.region", "eu-central-1")

_clusters = [
    {
        apiVersion: "elasticache.aws.upbound.io/v1beta1"
        kind: "Cluster"
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "elasticache-cluster-${i}"
            }
        }
        "spec": {
            forProvider: {
                if get(cluster, "applyImmediately", get(_oxr, "spec.applyImmediately", False)):
                    applyImmediately: get(cluster, "applyImmediately", get(_oxr, "spec.applyImmediately", True))
                if get(cluster, "autoMinorVersionUpgrade", get(_oxr, "spec.autoMinorVersionUpgrade", False)):
                    autoMinorVersionUpgrade: get(cluster, "autoMinorVersionUpgrade", get(_oxr, "spec.autoMinorVersionUpgrade", True)),

                _az = get(cluster, "availabilityZone", _azs[i % len(_azs)])
                _clusterName = get(cluster, "clusterName", "${_appName}-${_region}")
                if get(cluster, "availabilityZone", False):
                    availabilityZone: _az,
                    _clusterName = "${_appName}-${_region}-${_az}"

                if all_true([
                    get(cluster, "azMode", get(_oxr, "spec.azMode", False)),
                    get(cluster, "engine", get(_oxr, "spec.engine", False)) == "memcached",
                ]):
                    azMode: get(cluster, "azMode", get(_oxr, "spec.azMode", "single-az")),
                clusterId = "${_clusterName}",

                if get(cluster, "engine", get(_oxr, "spec.engine", False)):
                    engine = get(cluster, "engine", get(_oxr, "spec.engine", "redis")),
                if get(cluster, "engineVersion", get(_oxr, "spec.engineVersion", False)):
                    engineVersion = get(cluster, "engineVersion", get(_oxr, "spec.engineVersion", "6.x")),
                if get(cluster, "finalSnapshotIdentifier", get(_oxr, "spec.finalSnapshotIdentifier", False)):
                    finalSnapshotIdentifier = get(cluster, "finalSnapshotIdentifier", get(_oxr, "spec.finalSnapshotIdentifier", "")),

                if get(cluster, "ipDiscovery", get(_oxr, "spec.ipDiscovery", False)):
                    ipDiscovery = get(cluster, "ipDiscovery", get(_oxr, "spec.ipDiscovery", "dns")),

                if all_true([
                    get(cluster, "spec.engine", get(_oxr, "spec.engine", "redis")) == "redis",
                    get(cluster, "logDeliveryConfiguration", get(_oxr, "spec.logDeliveryConfiguration", False)),
                ]):
                    _config = get(cluster, "logDeliveryConfiguration", get(_oxr, "spec.logDeliveryConfiguration", []))
                    logDeliveryConfiguration = [{
                        if get(c, "destination", False):
                            destination: get(c, "destination", ""),
                        if get(c, "destinationType", False):
                            destinationType = c.destinationType,
                        if get(c, "logFormat", False):
                            logFormat = c.logFormat,
                        if get(c, "logType", False):
                            logType = c.logType,
                    } for c in _config],

                if get(cluster, "maintenanceWindow", get(_oxr, "spec.maintenanceWindow", False)):
                    maintenanceWindow = get(cluster, "maintenanceWindow", get(_oxr, "spec.maintenanceWindow", "Sun:05:00-Mon:09:00")),
                if get(cluster, "networkType", get(_oxr, "spec.networkType", False)):
                    networkType = get(cluster, "networkType", get(_oxr, "spec.networkType", "ipv4")),

                if get(cluster, "nodeType", get(_oxr, "spec.nodeType", False)):
                    nodeType = get(cluster, "nodeType", get(_oxr, "spec.nodeType", "cache.t3.micro")),

                if get(cluster, "notificationTopicArn", get(_oxr, "spec.notificationTopicArn", False)):
                    notificationTopicArn = get(cluster, "notificationTopicArn", get(_oxr, "spec.notificationTopicArn", "")),

                if get(cluster, "numCacheNodes", get(_oxr, "spec.numCacheNodes", False)):
                    numCacheNodes = get(cluster, "numCacheNodes", get(_oxr, "spec.numCacheNodes", 1)),

                if all_true([
                    get(cluster, "outpostMode", get(_oxr, "spec.outpostMode", False)),
                    get(cluster, "preferredOutpostArn", get(_oxr, "spec.preferredOutpostArn", False)),
                ]):
                    outpostMode = get(cluster, "outpostMode", get(_oxr, "spec.outpostMode", "none")),
                    preferredOutpostArn = get(cluster, "preferredOutpostArn", get(_oxr, "spec.preferredOutpostArn", "")),

                if get(cluster, "parameterGroupName", get(_oxr, "spec.parameterGroupName", False)):
                    parameterGroupName = get(cluster, "parameterGroupName", get(_oxr, "spec.parameterGroupName", "")),

                if get(cluster, "port", get(_oxr, "spec.port", 6379)):
                    port = get(cluster, "port", get(_oxr, "spec.port", 6379))

                if not get(cluster, "availabilityZone", False):
                    preferredAvailabilityZones = _azs

                region = _region,

                if all_true([
                    get(_oxr, "spec.createReplicationGroup", False),
                    get(_oxr, "status.localReplicationGroupId", False),
                ]):
                    replicationGroupId = get(_oxr, "status.localReplicationGroupId", ""),

                if get(_oxr, "status.securityGroupId", False):
                    securityGroupIds = [
                        get(_oxr, "status.securityGroupId", None),
                    ] + get(cluster, "securityGroupIds", get(_oxr, "spec.securityGroupIds", [])),

                if get(cluster, "snapshotArns", get(_oxr, "spec.snapshotArns", False)):
                    snapshotArns = get(cluster, "snapshotArns", get(_oxr, "spec.snapshotArns", [])),

                if get(cluster, "snapshotName", get(_oxr, "spec.snapshotName", False)):
                    snapshotName = get(cluster, "snapshotName", get(_oxr, "spec.snapshotName", "")),
                if get(cluster, "snapshotRetentionLimit", get(_oxr, "spec.snapshotRetentionLimit", False)):
                    snapshotRetentionLimit = get(cluster, "snapshotRetentionLimit", get(_oxr, "spec.snapshotRetentionLimit", 1)),
                if get(cluster, "snapshotWindow", get(_oxr, "spec.snapshotWindow", False)):
                    snapshotWindow = get(cluster, "snapshotWindow", get(_oxr, "spec.snapshotWindow", "00:00-01:00")),

                # Only assign subnetGroup if we are not creating a replication group
                if all_true([
                    get(_oxr, "status.subnetGroupName", False),
                    not get(cluster, "createReplicationGroup", get(_oxr, "spec.createReplicationGroup", False)),
                ]):
                    subnetGroupName = get(cluster, "subnetGroupName", get(_oxr, "spec.subnetGroupName", "")),

                tags = get(cluster, "tags", get(_oxr, "spec.tags", {})) | {
                    "Name": "${_appName}-${_region}-${_az}"
                },
                if get(cluster, "transitEncryptionEnabled", get(_oxr, "spec.transitEncryptionEnabled", False)):
                    transitEncryptionEnabled = get(cluster, "transitEncryptionEnabled", get(_oxr, "spec.transitEncryptionEnabled", False)),
            }
        }
    }
    for i, cluster in _requiredClusters
    if all_true([
        get(_oxr, "spec.subnetGroupName", False),
    ])
]