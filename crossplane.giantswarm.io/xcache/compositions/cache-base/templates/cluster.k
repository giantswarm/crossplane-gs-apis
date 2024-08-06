# If we are not creating a replication group, check how many cache clusters have
# been requested and default a list of empty dictionaries as being the cache
# cluster template.
requiredClusters = get(oxr, "spec.cacheClusters", []) if get(oxr, "spec.cacheClusters", False) else [
    {}
    for i in range(get(oxr, "spec.numCacheClusters", 1))
    if not get(oxr, "spec.createReplicationGroup", False)
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
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "initProvider": {
                if get(oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(oxr, "spec.engineVersion", False):
                        "engineVersion": get(oxr, "spec.engineVersion", "7.x")
            }

            "forProvider": {
                _v = getwparent(cluster, oxr, "applyImmediately",False)
                if _v:
                    "applyImmediately": _v

                _v = getwparent(cluster, oxr, "autoMinorVersionUpgrade", False)
                if _v:
                    "autoMinorVersionUpgrade": _v

                _az = get(cluster, "availabilityZone", azs[i % len(azs)])
                if get(cluster, "availabilityZone", False):
                    "availabilityZone": _az

                if all_true([
                    getwparent(cluster, oxr, "azMode", False),
                    getwparent(cluster, oxr "engine", False) == "memcached",
                ]):
                    "azMode": getwparent(cluster, oxr, "azMode", "cross-az"),
                    "numCacheNodes" = getwparent(cluster, oxr, "numCacheNodes", len(azs)),

                _v = getwparent(cluster, oxr, "engine", False)
                if _v:
                    "engine" = _v

                if not get(oxr, "spec.autoMinorVersionUpgrade", False):
                    _v = getwparent(cluster, oxr, "engineVersion", False)
                    if _v:
                        "engineVersion" = _v

                _v = getwparent(cluster, oxr, "finalSnapshotIdentifier", False)
                if _v:
                    "finalSnapshotIdentifier" = _v

                _v = getwparent(cluster, oxr, "ipDiscovery", False)
                if _v:
                    "ipDiscovery" = _v

                if all_true([
                    getwparent(cluster, oxr, "engine", "redis") == "redis",
                    getwparent(cluster, oxr, "logDeliveryConfiguration", False),
                ]):
                    _config = getwparent(cluster, oxr, "logDeliveryConfiguration", [])
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

                _v = getwparent(cluster, oxr, "maintenanceWindow", False)
                if _v:
                    "maintenanceWindow" = _v

                _v = getwparent(cluster, oxr, "networkType", False)
                if _v:
                    "networkType" = _v

                _v = getwparent(cluster, oxr, "nodeType", False)
                if _v:
                    "nodeType" = _v

                _v = getwparent(cluster, oxr, "notificationTopicArn", False)
                if _v:
                    "notificationTopicArn" = _v

                _om = getwparent(cluster, oxr, "outpostMode", False)
                _poa = getwparent(cluster, oxr, "preferredOutpostArn", False)
                if all_true([_om, _poa]):
                    "outpostMode" = _om,
                    "preferredOutpostArn" = _poa

                _v = get(oxr, "status.parameterGroupName", False)
                if _v:
                    "parameterGroupName" = _v

                _v = getwparent(cluster, oxr, "port", False)
                    "port" = _v

                if not get(cluster, "availabilityZone", False):
                    "preferredAvailabilityZones" = azs

                "region" = region

                if all_true([
                    get(oxr, "spec.createReplicationGroup", False),
                    get(oxr, "status.localReplicationGroupId", False),
                ]):
                    "replicationGroupId" = get(oxr, "status.localReplicationGroupId", "")

                if get(oxr, "status.securityGroupId", False):
                    "securityGroupIds" = [
                        get(oxr, "status.securityGroupId", None),
                    ] + getwparent(cluster, oxr, "securityGroupIds", [])

                _v = getwparent(cluster, oxr, "snapshotArns", False)
                if _v:
                    "snapshotArns" = _v

                _v = getwparent(cluster, oxr, "snapshotName", False)
                if _v:
                    "snapshotName" = _v

                _v = getwparent(cluster, oxr, "snapshotRetentionLimit", False)
                if _v:
                    "snapshotRetentionLimit" = _v

                _v = getwparent(cluster, oxr, "snapshotWindow", False)
                if _v:
                    "snapshotWindow" = _v

                # Only assign subnetGroup if we are not creating a replication group
                if all_true([
                    get(oxr, "status.subnetGroupName", False),
                    not getwparent(cluster, oxr, "createReplicationGroup", False),
                ]):
                    _sgn = getwparent(cluster, oxr, "subnetGroupName", "")
                    "subnetGroupName" = get(oxr, "status.subnetGroupName", _sgn)

                "tags" = tags | get(cluster, "tags", {}) | {
                    "Name": "${appName}-${region}-${_az}"
                },

                _v = getwparent(cluster, oxr, "transitEncryptionEnabled", False)
                if _v:
                    "transitEncryptionEnabled" = _v
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, cluster in requiredClusters
    if all_true([
        get(oxr, "status.subnetGroupName", False)
        get(oxr, "status.securityGroupId", False)
    ])
]

port = get(oxr, "status.port", False)
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
            "deletionPolicy": oxr.spec.deletionPolicy
            "forProvider": {
                "cidrBlocks": [cidr],
                "fromPort": port,
                "protocol": "tcp",
                "region": region,
                "securityGroupId": get(oxr, "status.securityGroupId", ""),
                "toPort": port,
                "type": "ingress",
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": get(oxr, "spec.providerConfigRef", {"name": "default"})
        }
    }
    for i, cidr in get(oxr, "spec.cidrBlocks", [])
    if all_true([
        get(oxr, "status.securityGroupId", False),
        port, cidr,
    ])
]

_items = [
    i for r in [clusters, securityGroupRules]
    for i in r if i
]