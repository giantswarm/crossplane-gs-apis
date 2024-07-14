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

if get(_oxr, "spec.createReplicationGroup", False):
    assert get(_oxr, "spec.engine", "redis") == "redis", "engine must be redis when createReplicationGroup is true"

_azs = get(_oxr, "spec.availabilityZones", False)
_appName = get(_oxr, "spec.claimRef.name", "")
_created = get(_ocds, "elasticache-replication-group.Resource", {})
_createReplicationGroup = get(_oxr, "spec.createReplicationGroup", True)
_clusterModeEnabled = get(_oxr, "spec.clusterMode.enabled", False)
_region = get(_oxr, "spec.region", "eu-central-1")

_subnetGroup = get(_oxr, "status.subnetGroupName", False)
_keyId = get(_oxr, "status.kmsKeyId", False)
_ipgn = get(_oxr, "status.parameterGroupName", "") if get(_oxr, "spec.allowMajorVersionUpgrade", False) else ""
_labels = get(_oxr, "metadata.labels", {}) | {
    "region": get(_oxr, "spec.region", "eu-central-1"),
}

_securityGroupIds = [
    get(_oxr, "status.securityGroupId", None),
] + [
    i for r in get(_oxr, "spec.securityGroupIds", []) for i in r
]

# Currently Crossplane does not support the GlobalReplicationGroup resource
#
# Until this CRD is implemented, we will be defining, but force disabling the
# following block - this saves having to extend the composition to support this
# in the future but would just require re-enabling the block by removing `False`
# from the `all_true` check.
# https://github.com/crossplane-contrib/provider-upjet-aws/issues/1333

# In order to create a global replication group, we must be creating a
# local replication group as well. Global is secondary.
_globalEnabled = all_true([
    False,
    _createReplicationGroup,
    get(_oxr, "spec.globalReplicationGroup.enabled", False)
])

_primaryGlobalRID = get(_oxr, "spec.globalReplicationGroupId", "") if _globalEnabled else ""
_replicationGlobalRID = get(_oxr, "status.globalReplicationGroupId", "") if _globalEnabled else get(_oxr, "spec.globalReplicationGroupId", "")

_parameterGroup = [
    {
        apiVersion: "elasticache.aws.upbound.io/v1beta1"
        kind: "ParameterGroup"
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "elasticache-parameter-group"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: _oxr.spec.deletionPolicy
            forProvider: {
                description: _appName + " Parameter Group"
                family: get(_oxr, "spec.parameterGroupFamily", "redis6.x")
                name: _appName + "-parameter-group"
                if get(_oxr, "spec.parameters", False):
                    parameter = [
                        {
                            name: k,
                            value: v,
                        }
                        for k, v in get(_oxr, "spec.parameterGroupConfiguration.parameters", {})
                    ]
                region = _region
                tags = _labels | {
                    "Name": _appName
                } | get(_oxr, "spec.tags", {}) | get(_oxr, "spec.parameterGroupConfiguration.tags", {})
            }
            providerConfigRef: get(_oxr, "spec.providerConfigRef", {"name": "default"})
        }
    }
] if get(_oxr, "spec.parameterGroupConfiguration", False) else []

_globalReplicationGroup = [{
    apiVersion: "elasticache.aws.upbound.io/v1beta1"
    kind: "GlobalReplicationGroup"
    "metadata": {
        annotations: {
            "krm.kcl.dev/composition-resource-name": "global-elasticache-replication-group"
        }
        labels: _labels
    }
    spec: {
        deletionPolicy: _oxr.spec.deletionPolicy
        forProvider: {
            automaticFailoverEnabled: get(_oxr, "spec.globalReplicationGroup.automaticFailoverEnabled", False)
            cacheNodeType: get(_oxr, "spec.globalReplicationGroup.cacheNodeType", "cache.t3.micro")
            globalReplicationGroupIdSuffix: get(_oxr, "spec.globalReplicationGroup.suffix", "")
            globalReplicationGroupDescription: _appName + " Global Replication Group"
            if get(_oxr, "spec.globalReplicationGroup.numNodeGroups", False):
                numNodeGroups: _oxr.spec._globalReplicationGroup.numNodeGroups

            if _primaryGlobalRID:
                primaryReplicationGroupId: _primaryGlobalRID
        }
        providerConfigRef: get(_oxr, "spec.providerConfigRef", {"name": "default"})
    }
}] if _globalEnabled else []

_enabledReplicationGroups = [
    "global" if _globalEnabled else "",
    # We don't want to create the local replication group if global replication
    # is enabled until the GlobalReplicationGroup is ready.
    "local" if any_true([
        all_true([
            _globalEnabled,
            get(_ocds, "global-elasticache-replication-group.Resource.status.id", False),
        ]),
        not _globalEnabled,
    ]) else "",
]

_replicationGroups = [
    {
        apiVersion: "elasticache.aws.upbound.io/v1beta1"
        kind: "ReplicationGroup"
        "metadata": {
            annotations: {
                "krm.kcl.dev/composition-resource-name": "elasticache-replication-group-${i}"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: _oxr.spec.deletionPolicy
            initProvider: {
                if get(_oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(_oxr, "spec.engineVersion", False):
                        engineVersion: _oxr.spec.engineVersion
            }
            forProvider: {
                if get(_oxr, "spec.applyImmediately", None) != None:
                    applyImmediately: _oxr.spec.applyImmediately
                if get(_oxr, "spec.atRestEncryptionEnabled", None) != None:
                    atRestEncryptionEnabled: _oxr.spec.atRestEncryptionEnabled
                if get(_oxr, "spec.authToken", False):
                    authToken: _oxr.spec.authToken
                if get(_oxr, "spec.authTokenUpdateStrategy", False):
                    authTokenUpdateStrategy: _oxr.spec.authTokenUpdateStrategy
                if get(_oxr, "spec.autoMinorVersionUpgrade", None) != None:
                    autoMinorVersionUpgrade: _oxr.spec.autoMinorVersionUpgrade
                if get(_oxr, "spec.automaticFailoverEnabled", None) != None:
                    automaticFailoverEnabled: _oxr.spec.automaticFailoverEnabled
                if get(_oxr, "spec.dataTieringEnabled", False):
                    dataTieringEnabled: _oxr.spec.dataTieringEnabled

                if i == "global":
                    description: _appName + " Replication Group ${_region} (Global)"

                if i == "local":
                    description: _appName + " Replication Group ${_region} (Local)"

                if get(_oxr, "spec.engine", False):
                    engine: _oxr.spec.engine

                if not get(_oxr, "spec.autoMinorVersionUpgrade", False):
                    if get(_oxr, "spec.engineVersion", False):
                        engineVersion: _oxr.spec.engineVersion

                if get(_oxr, "spec.finalSnapshotIdentifier", False):
                    finalSnapshotIdentifier: _oxr.spec.finalSnapshotIdentifier

                if _replicationGlobalRID:
                    globalReplicationGroupId: _replicationGlobalRID

                if get(_oxr, "spec.ipDiscovery", False):
                    ipDiscovery: _oxr.spec.ipDiscovery
                if _keyId:
                    kmsKeyId: _keyId
                if get(_oxr, "spec.maintenanceWindow", False):
                    maintenanceWindow: _oxr.spec.maintenanceWindow
                if get(_oxr, "spec.multiAzEnabled", None) != None:
                    multiAzEnabled: _oxr.spec.multiAzEnabled
                if get(_oxr, "spec.networkType", False):
                    networkType: _oxr.spec.networkType

                if get(_oxr, "spec.notificationTopicArn", False):
                    notificationTopicArn: _oxr.spec.notificationTopicArn

                if all_true([
                    get(_oxr, "spec.numCacheClusters", False),
                    not get(_oxr, "spec.numNodeGroups", False),
                    not _clusterModeEnabled
                ]):
                    numCacheClusters: get(_oxr, "spec.numCacheClusters", 1)

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
                        nodeType: _oxr.spec.nodeType
                    if all_true([
                        _clusterModeEnabled,
                        get(_oxr, "spec.numNodeGroups", False)
                    ]):
                        numNodeGroups: _oxr.spec.numNodeGroups
                if _ipgn:
                    parameterGroupName: _ipgn

                if get(_oxr, "spec.port", False):
                    port: _oxr.spec.port

                if _azs:
                    preferredCacheClusterAzs: _azs

                if get(_oxr, "spec.replicasPerNodeGroup", None) != None:
                    replicasPerNodeGroup: get(_oxr, "spec.replicasPerNodeGroup", 0)

                region: _region

                if _securityGroupIds:
                    securityGroupIds: [i for i in _securityGroupIds if i]

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
                    subnetGroupName: _subnetGroup

                if get(_oxr, "spec.snapshotRetentionLimit", False):
                    snapshotRetentionLimit: _oxr.spec.snapshotRetentionLimit
                if get(_oxr, "spec.snapshotWindow", False):
                    snapshotWindow: _oxr.spec.snapshotWindow
                if get(_oxr, "spec.transitEncryptionEnabled", None) != None:
                    transitEncryptionEnabled: _oxr.spec.transitEncryptionEnabled
                if get(_oxr, "spec.userGroupIds", False):
                    userGroupIds: _oxr.spec.userGroupIds

                tags: _labels | {
                    "Name": "${_appName}-global"
                } | get(_oxr, "spec.tags", {})
            }
            providerConfigRef: get(_oxr, "spec.providerConfigRef", {"name": "default"})
        }
    } for _, i in _enabledReplicationGroups if all_true([
        _createReplicationGroup,
        i,
        get(_oxr, "spec.engine", "redis") == "redis",
        any_true([
            i == "global",
            all_true([i == "local", not _globalEnabled]),
            all_true([i == "local", _globalEnabled, _replicationGlobalRID]),
        ]),
        get(_oxr, "status.subnetGroupName", False)
        get(_oxr, "status.securityGroupId", False)
        get(_oxr, "status.kmsKeyId", False)
    ])
]

_items = [_replicationGroups, _globalReplicationGroup]
items = [i for r in _items for i in r if i]