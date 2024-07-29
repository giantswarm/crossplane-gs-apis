# If we are not creating a replication group, check how many cache clusters have
# been requested and default a list of empty dictionaries as being the cache
# cluster template.
requiredClusters = get(_oxr, "spec.cacheClusters", []) if get(_oxr, "spec.cacheClusters", False) else [
    {}
    for i in range(get(_oxr, "spec.numCacheClusters", 1))
    if not get(_oxr, "spec.createReplicationGroup", False)
]

clusters = [
    {
        "apiVersion": "elasticache.aws.upbound.io/v1beta1"
        "kind": "Cluster"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "elasticache-cluster-${i}"
                "krm.kcl.dev/ready": readystr("elasticache-cluster-${i}")
                "crossplane.io/external-name": "${appName}-${region}-${i}"
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": get(_oxr, "spec.deletionPolicy", "Delete"),
            "initProvider": {
                if get(_oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(_oxr, "spec.engineVersion", False):
                        "engineVersion": get(_oxr, "spec.engineVersion", "7.x")
            }

            "forProvider": {
                _v = getwparent(cluster, _oxr, "applyImmediately",False)
                if _v:
                    "applyImmediately": _v

                _v = getwparent(cluster, _oxr, "autoMinorVersionUpgrade", False)
                if _v:
                    "autoMinorVersionUpgrade": _v

                _az = get(cluster, "availabilityZone", azs[i % len(azs)])
                if get(cluster, "availabilityZone", False):
                    "availabilityZone": _az

                if all_true([
                    getwparent(cluster, _oxr, "azMode", False),
                    getwparent(cluster, _oxr "engine", False) == "memcached",
                ]):
                    "azMode": getwparent(cluster, _oxr, "azMode", "cross-az"),
                    "numCacheNodes" = getwparent(cluster, _oxr, "numCacheNodes", len(azs)),

                _v = getwparent(cluster, _oxr, "engine", False)
                if _v:
                    "engine" = _v

                if not get(_oxr, "spec.autoMinorVersionUpgrade", False):
                    _v = getwparent(cluster, _oxr, "engineVersion", False)
                    if _v:
                        "engineVersion" = _v

                _v = getwparent(cluster, _oxr, "finalSnapshotIdentifier", False)
                if _v:
                    "finalSnapshotIdentifier" = _v

                _v = getwparent(cluster, _oxr, "ipDiscovery", False)
                if _v:
                    "ipDiscovery" = _v

                if all_true([
                    getwparent(cluster, _oxr, "engine", "redis") == "redis",
                    getwparent(cluster, _oxr, "logDeliveryConfiguration", False),
                ]):
                    _config = getwparent(cluster, _oxr, "logDeliveryConfiguration", [])
                    "logDeliveryConfiguration" = [{
                        if get(c, "destination", False):
                            "destination": get(c, "destination", ""),
                        if get(c, "destinationType", False):
                            "destinationType" = c.destinationType,
                        if get(c, "logFormat", False):
                            "logFormat" = c.logFormat,
                        if get(c, "logType", False):
                            "logType" = c.logType,
                    } for c in _config],

                _v = getwparent(cluster, _oxr, "maintenanceWindow", False)
                if _v:
                    "maintenanceWindow" = _v

                _v = getwparent(cluster, _oxr, "networkType", False)
                if _v:
                    "networkType" = _v

                _v = getwparent(cluster, _oxr, "nodeType", False)
                if _v:
                    "nodeType" = _v

                _v = getwparent(cluster, _oxr, "notificationTopicArn", False)
                if _v:
                    "notificationTopicArn" = _v

                _om = getwparent(cluster, _oxr, "outpostMode", False)
                _poa = getwparent(cluster, _oxr, "preferredOutpostArn", False)
                if all_true([_om, _poa]):
                    "outpostMode" = _om,
                    "preferredOutpostArn" = _poa

                _v = get(_oxr, "status.parameterGroupName", False)
                if _v:
                    "parameterGroupName" = _v

                _v = getwparent(cluster, _oxr, "port", False)
                    "port" = _v

                if not get(cluster, "availabilityZone", False):
                    "preferredAvailabilityZones" = azs

                "region" = region

                if all_true([
                    get(_oxr, "spec.createReplicationGroup", False),
                    get(_oxr, "status.localReplicationGroupId", False),
                ]):
                    "replicationGroupId" = get(_oxr, "status.localReplicationGroupId", "")

                if get(_oxr, "status.securityGroupId", False):
                    "securityGroupIds" = [
                        get(_oxr, "status.securityGroupId", None),
                    ] + getwparent(cluster, _oxr, "securityGroupIds", [])

                _v = getwparent(cluster, _oxr, "snapshotArns", False)
                if _v:
                    "snapshotArns" = _v

                _v = getwparent(cluster, _oxr, "snapshotName", False)
                if _v:
                    "snapshotName" = _v

                _v = getwparent(cluster, _oxr, "snapshotRetentionLimit", False)
                if _v:
                    "snapshotRetentionLimit" = _v

                _v = getwparent(cluster, _oxr, "snapshotWindow", False)
                if _v:
                    "snapshotWindow" = _v

                # Only assign subnetGroup if we are not creating a replication group
                if all_true([
                    get(_oxr, "status.subnetGroupName", False),
                    not getwparent(cluster, _oxr, "createReplicationGroup", False),
                ]):
                    _sgn = getwparent(cluster, _oxr, "subnetGroupName", "")
                    "subnetGroupName" = get(_oxr, "status.subnetGroupName", _sgn)

                "tags" = tags | get(cluster, "tags", {}) | {
                    "Name": "${appName}-${region}-${_az}"
                },

                _v = getwparent(cluster, _oxr, "transitEncryptionEnabled", False)
                if _v:
                    "transitEncryptionEnabled" = _v
            }
            "providerConfigRef": pcr
        }
    }
    for i, cluster in requiredClusters
    if all_true([
        get(_oxr, "status.subnetGroupName", False)
        get(_oxr, "status.securityGroupId", False)
    ])
]

port = get(_oxr, "status.port", False)
securityGroupRules = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "SecurityGroupRule"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "elasticache-security-group-rule-inbound-${i}"
                "krm.kcl.dev/ready": readystr("elasticache-security-group-rule-inbound-${i}")
                "crossplane.io/external-name": "${appName}-cache-sg-rule-inbound"
            }
        }
        "spec": {
            "deletionPolicy": _oxr.spec.deletionPolicy
            "forProvider": {
                "cidrBlocks": [cidr],
                "fromPort": port,
                "protocol": "tcp",
                "region": region,
                "securityGroupId": get(_oxr, "status.securityGroupId", ""),
                "toPort": port,
                "type": "ingress",
            }
            "providerConfigRef": get(_oxr, "spec.providerConfigRef", {"name": "default"})
        }
    }
    for i, cidr in get(_oxr, "spec.cidrBlocks", [])
    if all_true([
        get(_oxr, "status.securityGroupId", False),
        port, cidr,
    ])
]

_items = [
    i for r in [clusters, securityGroupRules]
    for i in r if i
]