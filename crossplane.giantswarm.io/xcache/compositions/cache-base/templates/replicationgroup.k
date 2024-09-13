if get(oxr, "spec.createReplicationGroup", False):
    assert get(oxr, "spec.engine", "redis") == "redis", "engine must be redis when createReplicationGroup is true"

clusterModeEnabled = get(oxr, "spec.clusterMode.enabled", False)
ipgn = get(oxr, "status.parameterGroupName", "") if get(oxr, "spec.allowMajorVersionUpgrade", False) else ""

securityGroupIds = [
    get(oxr, "status.securityGroupId", None),
] + [
    i for r in get(oxr, "spec.securityGroupIds", []) for i in r
]

subnetGroup = get(oxr, "status.subnetGroupName", False)

# Currently Crossplane does not support the GlobalReplicationGroup resource
#
# Until this CRD is implemented, we will be defining, but force disabling the
# following block - this saves having to extend the composition to support this
# in the future but would just require re-enabling the block by removing `False`
# from the `all_true` check.
# https://github.com/crossplane-contrib/provider-upjet-aws/issues/1333

# In order to create a global replication group, we must be creating a
# local replication group as well. Global is secondary.
primaryGlobalRID = get(oxr, "spec.globalReplicationGroupId", "") if globalEnabled else ""
replicationGlobalRID = get(oxr, "status.globalReplicationGroupId", "") if globalEnabled else get(oxr, "spec.globalReplicationGroupId", "")

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
                "family": get(oxr, "spec.parameterGroupFamily", "redis6.x")
                "name": appName + "-parameter-group"
                if get(oxr, "spec.parameters", False):
                    "parameter" = [
                        {
                            name: k,
                            value: v,
                        }
                        for k, v in get(oxr, "spec.parameterGroupConfiguration.parameters", {})
                    ]
                "region" = region
                "tags" = tags | {
                    "Name": "${appName}-${region}"
                } | get(oxr, "spec.parameterGroupConfiguration.tags", {})
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
] if get(oxr, "spec.parameterGroupConfiguration", False) else []

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
            "automaticFailoverEnabled": get(oxr, "spec.globalReplicationGroup.automaticFailoverEnabled", False)
            "cacheNodeType": get(oxr, "spec.globalReplicationGroup.cacheNodeType", "cache.t3.micro")
            "globalReplicationGroupIdSuffix": get(oxr, "spec.globalReplicationGroup.suffix", "")
            "globalReplicationGroupDescription": appName + " Global Replication Group"
            if get(oxr, "spec.globalReplicationGroup.numNodeGroups", False):
                "numNodeGroups": get(oxr, "spec.globalReplicationGroup.numNodeGroups", 1)

            if primaryGlobalRID:
                "primaryReplicationGroupId": primaryGlobalRID

            "region": region

            "tags": tags | {
                "Name": "${appName}-${region}-global"
            }
        }
        "managementPolicies": mgmtPolicy,
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
                if get(oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(oxr, "spec.engineVersion", False):
                        "engineVersion": get(oxr, "spec.engineVersion", "")
            }
            "forProvider": {
                if get(oxr, "spec.applyImmediately", None) != None:
                    "applyImmediately": get(oxr, "spec.applyImmediately", True)

                "atRestEncryptionEnabled" = get(oxr, "spec.atRestEncryptionEnabled", True)

                if get(oxr, "spec.transitEncryptionEnabled", False):
                    if get(oxr, "spec.enableAuthToken", False):
                        "autoGenerateAuthToken": True
                        "authTokenUpdateStrategy": get(oxr, "spec.authTokenUpdateStrategy", "ROTATE")
                        "authTokenSecretRef": {
                            "key": "token"
                            "name": "${appName}-elasticache-auth-token"
                            "namespace": get(oxr, "spec.claimRef.namespace", "default")
                        }
                    "transitEncryptionEnabled": get(oxr, "spec.transitEncryptionEnabled", True)

                if get(oxr, "spec.autoMinorVersionUpgrade", None) != None:
                    "autoMinorVersionUpgrade": get(oxr, "spec.autoMinorVersionUpgrade", True)
                if get(oxr, "spec.automaticFailoverEnabled", None) != None:
                    "automaticFailoverEnabled": get(oxr, "spec.automaticFailoverEnabled", False)
                if get(oxr, "spec.dataTieringEnabled", False):
                    "dataTieringEnabled": get(oxr, "spec.dataTieringEnabled", False)

                if i == "global":
                    "description": appName + " Replication Group ${region} (Global)"

                if i == "local":
                    "description": appName + " Replication Group ${region} (Local)"

                if get(oxr, "spec.engine", False):
                    "engine": get(oxr, "spec.engine", "redis")

                if not get(oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(oxr, "spec.engineVersion", False):
                        "engineVersion": get(oxr, "spec.engineVersion", "7.x")

                if get(oxr, "spec.finalSnapshotIdentifier", False):
                    "finalSnapshotIdentifier": get(oxr, "spec.finalSnapshotIdentifier", "")

                if replicationGlobalRID:
                    "globalReplicationGroupId": replicationGlobalRID

                if get(oxr, "spec.ipDiscovery", False):
                    "ipDiscovery": get(oxr, "spec.ipDiscovery", "ipv4")

                "kmsKeyId": keyId

                if get(oxr, "spec.maintenanceWindow", False):
                    "maintenanceWindow": get(oxr, "spec.maintenanceWindow", "")
                if get(oxr, "spec.multiAzEnabled", None) != None:
                    "multiAzEnabled": get(oxr, "spec.multiAzEnabled", True)
                if get(oxr, "spec.networkType", False):
                    "networkType": get(oxr, "spec.networkType", "ipv4")

                if get(oxr, "spec.notificationTopicArn", False):
                    "notificationTopicArn": get(oxr, "spec.notificationTopicArn", "")

                if all_true([
                    get(oxr, "spec.numCacheClusters", False),
                    not get(oxr, "spec.numNodeGroups", False),
                    not clusterModeEnabled
                ]):
                    "numCacheClusters": get(oxr, "spec.numCacheClusters", 1)

                # numNodeGroups cannot be set if global replication group id is set
                if any_true([
                    get(oxr, "spec.globalReplicationGroupId", False),
                    i == "global"
                    all_true([
                        not get(oxr, "spec.globalReplicationGroup.enabled", False),
                        not get(oxr, "spec.globalReplicationGroupId", False),
                        i == "local"
                    ])
                ]):
                    if get(oxr, "spec.nodeType", False):
                        "nodeType": get(oxr, "spec.nodeType", "cache.t3.micro")
                    if all_true([
                        clusterModeEnabled,
                        get(oxr, "spec.numNodeGroups", False)
                    ]):
                        "numNodeGroups": get(oxr, "spec.numNodeGroups", 1)
                if ipgn:
                    "parameterGroupName": ipgn

                if get(oxr, "spec.port", False):
                    "port": get(oxr, "spec.port", 6379)

                if azs:
                    "preferredCacheClusterAzs": azs

                if get(oxr, "spec.replicasPerNodeGroup", None) != None:
                    "replicasPerNodeGroup": get(oxr, "spec.replicasPerNodeGroup", 0)

                "region": region

                if securityGroupIds:
                    "securityGroupIds": [i for i in securityGroupIds if i]

                if any_true([
                    all_true([
                        i == "global",
                        get(oxr, "status.subnetGroupName", False),
                    ]),
                    all_true([
                        not get(oxr, "spec.globalReplicationGroup.enabled", False),
                        i == "local",
                        get(oxr, "status.subnetGroupName", False),
                    ])
                ]):
                    "subnetGroupName": subnetGroup

                if get(oxr, "spec.snapshotRetentionLimit", False):
                    "snapshotRetentionLimit": get(oxr, "spec.snapshotRetentionLimit", 1)
                if get(oxr, "spec.snapshotWindow", False):
                    "snapshotWindow": get(oxr, "spec.snapshotWindow", "00:00-01:00")
                if get(oxr, "spec.userGroupIds", False):
                    "userGroupIds": [
                        get(oxr, "status.userGroupId", "")
                    ]

                "tags": tags | {
                    "Name": "${appName}-${region}-${i}"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr

            "writeConnectionSecretToRef": {
                "name": "${appName}-elasticache-${i}"
                "namespace": get(oxr, "spec.claimRef.namespace", "default")
            }
        }
    } for _, i in enabledReplicationGroups if all_true([
        createReplicationGroup, keyId, i,
        get(oxr, "spec.engine", "redis") == "redis",
        any_true([
            i == "global",
            all_true([i == "local", not globalEnabled]),
            all_true([i == "local", globalEnabled, replicationGlobalRID]),
        ]),
        get(oxr, "status.subnetGroupName", False)
        get(oxr, "status.securityGroupId", False)
    ])
]

_items = [
    i for r in [
        replicationGroups, globalReplicationGroup,
        parameterGroup
    ] for i in r if i
]