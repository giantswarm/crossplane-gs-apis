if get(_oxr, "spec.createReplicationGroup", False):
    assert get(_oxr, "spec.engine", "redis") == "redis", "engine must be redis when createReplicationGroup is true"

created = get(_ocds, "elasticache-replication-group.Resource", {})
clusterModeEnabled = get(_oxr, "spec.clusterMode.enabled", False)
ipgn = get(_oxr, "status.parameterGroupName", "") if get(_oxr, "spec.allowMajorVersionUpgrade", False) else ""

securityGroupIds = [
    get(_oxr, "status.securityGroupId", None),
] + [
    i for r in get(_oxr, "spec.securityGroupIds", []) for i in r
]

subnetGroup = get(_oxr, "status.subnetGroupName", False)

# Currently Crossplane does not support the GlobalReplicationGroup resource
#
# Until this CRD is implemented, we will be defining, but force disabling the
# following block - this saves having to extend the composition to support this
# in the future but would just require re-enabling the block by removing `False`
# from the `all_true` check.
# https://github.com/crossplane-contrib/provider-upjet-aws/issues/1333

# In order to create a global replication group, we must be creating a
# local replication group as well. Global is secondary.
primaryGlobalRID = get(_oxr, "spec.globalReplicationGroupId", "") if globalEnabled else ""
replicationGlobalRID = get(_oxr, "status.globalReplicationGroupId", "") if globalEnabled else get(_oxr, "spec.globalReplicationGroupId", "")

parameterGroup = [
    {
        "apiVersion": "elasticache.aws.upbound.io/v1beta1"
        "kind": "ParameterGroup"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "elasticache-parameter-group"
                "krm.kcl.dev/ready": readystr("elasticache-parameter-group")
                "crossplane.io/external-name": appName
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "description": appName + " Parameter Group"
                "family": get(_oxr, "spec.parameterGroupFamily", "redis6.x")
                "name": appName + "-parameter-group"
                if get(_oxr, "spec.parameters", False):
                    "parameter" = [
                        {
                            name: k,
                            value: v,
                        }
                        for k, v in get(_oxr, "spec.parameterGroupConfiguration.parameters", {})
                    ]
                "region" = region
                "tags" = tags | {
                    "Name": "${appName}-${region}"
                } | get(_oxr, "spec.parameterGroupConfiguration.tags", {})
            }
            "providerConfigRef": pcr
        }
    }
] if get(_oxr, "spec.parameterGroupConfiguration", False) else []

globalReplicationGroup = [{
    "apiVersion": "elasticache.aws.upbound.io/v1beta1"
    "kind": "GlobalReplicationGroup"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": "global-elasticache-replication-group"
            "krm.kcl.dev/ready": readystr("global-elasticache-replication-group")
            "crossplane.io/external-name": appName
        }
        "labels": labels
    }
    "spec": {
        "deletionPolicy": dp
        "forProvider": {
            "automaticFailoverEnabled": get(_oxr, "spec.globalReplicationGroup.automaticFailoverEnabled", False)
            "cacheNodeType": get(_oxr, "spec.globalReplicationGroup.cacheNodeType", "cache.t3.micro")
            "globalReplicationGroupIdSuffix": get(_oxr, "spec.globalReplicationGroup.suffix", "")
            "globalReplicationGroupDescription": appName + " Global Replication Group"
            if get(_oxr, "spec.globalReplicationGroup.numNodeGroups", False):
                "numNodeGroups": get(_oxr, "spec.globalReplicationGroup.numNodeGroups", 1)

            if primaryGlobalRID:
                "primaryReplicationGroupId": primaryGlobalRID

            "region": region

            "tags": tags | {
                "Name": "${appName}-${region}-global"
            }
        }
        "providerConfigRef": pcr
    }
}] if globalEnabled else []

enabledReplicationGroups = [
    "global" if globalEnabled else "",
    # We don't want to create the local replication group if global replication
    # is enabled until the GlobalReplicationGroup is ready.
    "local" if any_true([
        all_true([
            globalEnabled,
            ready("global-elasticache-replication-group"),
        ]),
        not globalEnabled,
    ]) else "",
]

replicationGroups = [
    {
        "apiVersion": "elasticache.aws.upbound.io/v1beta2"
        "kind": "ReplicationGroup"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": "elasticache-replication-group-${i}"
                "krm.kcl.dev/ready": readystr("elasticache-replication-group-${i}")
                "crossplane.io/external-name": "${appName}-${i}"
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "initProvider": {
                if get(_oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(_oxr, "spec.engineVersion", False):
                        "engineVersion": get(_oxr, "spec.engineVersion", "")
            }
            "forProvider": {
                if get(_oxr, "spec.applyImmediately", None) != None:
                    "applyImmediately": get(_oxr, "spec.applyImmediately", True)

                "atRestEncryptionEnabled" = get(_oxr, "spec.atRestEncryptionEnabled", True)

                if get(_oxr, "spec.transitEncryptionEnabled", False):
                    "autoGenerateAuthToken": True
                    "authTokenSecretRef": {
                        "key": "token"
                        "name": "${appName}-elasticache-auth-token"
                        "namespace": get(_oxr, "spec.claimRef.namespace", "default")
                    }
                    "transitEncryptionEnabled": get(_oxr, "spec.transitEncryptionEnabled", True)

                if get(_oxr, "spec.authTokenUpdateStrategy", False):
                    "authTokenUpdateStrategy": get(_oxr, "spec.authTokenUpdateStrategy", "ROTATE")
                if get(_oxr, "spec.autoMinorVersionUpgrade", None) != None:
                    "autoMinorVersionUpgrade": get(_oxr, "spec.autoMinorVersionUpgrade", True)
                if get(_oxr, "spec.automaticFailoverEnabled", None) != None:
                    "automaticFailoverEnabled": get(_oxr, "spec.automaticFailoverEnabled", False)
                if get(_oxr, "spec.dataTieringEnabled", False):
                    "dataTieringEnabled": get(_oxr, "spec.dataTieringEnabled", False)

                if i == "global":
                    "description": appName + " Replication Group ${region} (Global)"

                if i == "local":
                    "description": appName + " Replication Group ${region} (Local)"

                if get(_oxr, "spec.engine", False):
                    "engine": get(_oxr, "spec.engine", "redis")

                if not get(_oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(_oxr, "spec.engineVersion", False):
                        "engineVersion": get(_oxr, "spec.engineVersion", "7.x")

                if get(_oxr, "spec.finalSnapshotIdentifier", False):
                    "finalSnapshotIdentifier": get(_oxr, "spec.finalSnapshotIdentifier", "")

                if replicationGlobalRID:
                    "globalReplicationGroupId": replicationGlobalRID

                if get(_oxr, "spec.ipDiscovery", False):
                    "ipDiscovery": get(_oxr, "spec.ipDiscovery", "ipv4")

                "kmsKeyId": keyId

                if get(_oxr, "spec.maintenanceWindow", False):
                    "maintenanceWindow": get(_oxr, "spec.maintenanceWindow", "")
                if get(_oxr, "spec.multiAzEnabled", None) != None:
                    "multiAzEnabled": get(_oxr, "spec.multiAzEnabled", True)
                if get(_oxr, "spec.networkType", False):
                    "networkType": get(_oxr, "spec.networkType", "ipv4")

                if get(_oxr, "spec.notificationTopicArn", False):
                    "notificationTopicArn": get(_oxr, "spec.notificationTopicArn", "")

                if all_true([
                    get(_oxr, "spec.numCacheClusters", False),
                    not get(_oxr, "spec.numNodeGroups", False),
                    not clusterModeEnabled
                ]):
                    "numCacheClusters": get(_oxr, "spec.numCacheClusters", 1)

                # numNodeGroups cannot be set if global replication group id is set
                if any_true([
                    get(_oxr, "spec.globalReplicationGroupId", False),
                    i == "global"
                    all_true([
                        not get(_oxr, "spec.globalReplicationGroup.enabled", False),
                        not get(_oxr, "spec.globalReplicationGroupId", False),
                        i == "local"
                    ])
                ]):
                    if get(_oxr, "spec.nodeType", False):
                        "nodeType": get(_oxr, "spec.nodeType", "cache.t3.micro")
                    if all_true([
                        clusterModeEnabled,
                        get(_oxr, "spec.numNodeGroups", False)
                    ]):
                        "numNodeGroups": get(_oxr, "spec.numNodeGroups", 1)
                if ipgn:
                    "parameterGroupName": ipgn

                if get(_oxr, "spec.port", False):
                    "port": get(_oxr, "spec.port", 6379)

                if azs:
                    "preferredCacheClusterAzs": azs

                if get(_oxr, "spec.replicasPerNodeGroup", None) != None:
                    "replicasPerNodeGroup": get(_oxr, "spec.replicasPerNodeGroup", 0)

                "region": region

                if securityGroupIds:
                    "securityGroupIds": [i for i in securityGroupIds if i]

                if any_true([
                    all_true([
                        i == "global",
                        get(_oxr, "status.subnetGroupName", False),
                    ]),
                    all_true([
                        not get(_oxr, "spec.globalReplicationGroup.enabled", False),
                        i == "local",
                        get(_oxr, "status.subnetGroupName", False),
                    ])
                ]):
                    "subnetGroupName": subnetGroup

                if get(_oxr, "spec.snapshotRetentionLimit", False):
                    "snapshotRetentionLimit": get(_oxr, "spec.snapshotRetentionLimit", 1)
                if get(_oxr, "spec.snapshotWindow", False):
                    "snapshotWindow": get(_oxr, "spec.snapshotWindow", "00:00-01:00")
                if get(_oxr, "spec.userGroupIds", False):
                    "userGroupIds": [
                        get(_oxr, "status.userGroupId", "")
                    ]

                "tags": tags | {
                    "Name": "${appName}-${region}-${i}"
                }
            }
            "providerConfigRef": pcr

            "writeConnectionSecretToRef": {
                "name": "${appName}-elasticache-${i}"
                "namespace": get(_oxr, "spec.claimRef.namespace", "default")
            }
        }
    } for _, i in enabledReplicationGroups if all_true([
        createReplicationGroup, keyId, i,
        get(_oxr, "spec.engine", "redis") == "redis",
        any_true([
            i == "global",
            all_true([i == "local", not globalEnabled]),
            all_true([i == "local", globalEnabled, replicationGlobalRID]),
        ]),
        get(_oxr, "status.subnetGroupName", False)
        get(_oxr, "status.securityGroupId", False)
    ])
]

_items = [
    i for r in [
        replicationGroups, globalReplicationGroup,
        parameterGroup
    ] for i in r if i
]