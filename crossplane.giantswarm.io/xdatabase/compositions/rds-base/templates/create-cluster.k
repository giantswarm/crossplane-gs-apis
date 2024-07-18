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

_appName = get(_oxr, "spec.claimRef.name", "")
_createCluster = get(_oxr, "spec.createCluster", True)

_created = get(_ocds, "rds-cluster.Resource", {})
_clusterIdentifier = get(_created, "status.atProvider.id", "")
_clusterArn = get(_created, "status.atProvider.arn", "")
_clusterResourceId = get(_created, "status.atProvider.clusterResourceId", "")
_endpoint = get(_created, "status.atProvider.endpoint", "")
_port = get(_created, "status.atProvider.port", "")

_subnetGroup = get(_oxr, "status.dbSubnetGroupName", False)

_keyId = get(_oxr, "status.kmsKeyId", False)
_ipgn = get(_oxr, "spec.dbParameterGroup.name", "") if get(_oxr, "spec.allowMajorVersionUpgrade", False) else ""
_labels = get(_oxr, "metadata.labels", {}) | {
    "region": get(_oxr, "spec.region", "eu-central-1"),
}

_provisioned = get(_oxr, "spec.engineMode", "provisioned") == "provisioned"
_region = get(_oxr, "spec.region", "eu-central-1")
_regionedAzs = ["${_region}${az}" for az in get(_oxr, "spec.availabilityZones", ["a", "b", "c"])]
_restoreToPointInTime = {
    sourceDbClusterIdentifier = get(_oxr, "spec.restoreToPointInTime.sourceDbClusterIdentifier", None),
    restoreType = get(_oxr, "spec.restoreToPointInTime.restoreType", "full-copy"),
} | {
    restoreToTime = get(_oxr, "spec.restoreToPointInTime.restoreToTime", None),
} if get(_oxr, "spec.restoreToPointInTime.restoreToTime", False) else {
    useLatestRestorableTime = get(_oxr, "spec.restoreToPointInTime.useLatestRestorableTime", True),
}
_s3import = get(_oxr, "spec.s3Import", False)
_serverless = get(_oxr, "spec.engineMode", "provisioned") == "serverless"
_scalingConfiguration = get(_oxr, "spec.scalingConfiguration", False) if _serverless else False
_serverlessv2scaling = get(_oxr, "spec.serverlessv2scalingConfiguration", False) if _provisioned else False
_tags = get(_oxr, "spec.tags", {}) | _labels

_cluster = {
    apiVersion: "rds.aws.upbound.io/v1beta1"
    kind: "Cluster"
    "metadata": {
        annotations: {
            "krm.kcl.dev/composition-resource-name": "rds-cluster"
        }
        labels: _labels
    }
    "spec": {
        deletionPolicy: _oxr.spec.deletionPolicy
        initProvider: {
            if get(_oxr, "spec.engineVersion", False):
                engineVersion: _oxr.spec.engineVersion
            if get(_oxr, "spec.globalClusterIdentifier", False):
                globalClusterIdentifier: _oxr.spec.globalClusterIdentifier
            if get(_oxr, "spec.replicationSourceIdentifier", False):
                replicationSourceIdentifier: _oxr.spec.replicationSourceIdentifier
        }
        forProvider: {
            copyTagsToSnapshot: True
            manageMasterUserPassword: True
            networkType: "IPV4"
            skipFinalSnapshot: True
            storageEncrypted: True
            region: _region
            kmsKeyId: _keyId
            dbSubnetGroupName: _subnetGroup
            tags: _tags | {
                Name: "${_appName}-${_region}"
            }

            if get(_oxr, "spec.allocatedStorage", False):
                allocatedStorage: _oxr.spec.allocatedStorage
            if get(_oxr, "spec.allowMajorVersionUpgrade", None) != None:
                allowMajorVersionUpgrade: _oxr.spec.allowMajorVersionUpgrade
            if get(_oxr, "spec.applyImmediately", None) != None:
                applyImmediately: _oxr.spec.applyImmediately
            if get(_oxr, "spec.availabilityZones", False):
                availabilityZones: _regionedAzs
            if get(_oxr, "spec.backupRetentionPeriod", False):
                backupRetentionPeriod: _oxr.spec.backupRetentionPeriod
            if get(_oxr, "spec.backtrackWindow", False):
                backtrackWindow: _oxr.spec.backtrackWindow
            if get(_oxr, "spec.clusterMembers", False):
                clusterMembers: _oxr.spec.clusterMembers
            if get(_oxr, "spec.databaseName", False):
                databaseName: _oxr.spec.databaseName
            if get(_oxr, "spec.dbClusterInstanceClass", False):
                dbClusterInstanceClass: _oxr.spec.dbClusterInstanceClass
            if get(_oxr, "spec.dbClusterParameterGroup.name", False):
                dbClusterParameterGroupName: _oxr.spec.dbClusterParameterGroup.name
            if get(_oxr, "spec.dbInstanceParameterGroup.name", False):
                dbInstanceParameterGroupName: _oxr.spec.dbInstanceParameterGroup.name
            if get(_oxr, "spec.deletionProtection", None) != None:
                deletionProtection: _oxr.spec.deletionProtection
            if get(_oxr, "spec.deleteAutomatedBackups", None) != None:
                deleteAutomatedBackups: _oxr.spec.deleteAutomatedBackups
            if get(_oxr, "spec.domain", False):
                domain: _oxr.spec.domain
            if get(_oxr, "spec.domainIAMRoleName", False):
                domainIAMRoleName: _oxr.spec.domainIAMRoleName
            if get(_oxr, "spec.enableHttpEndpoint", False):
                enableHttpEndpoint: _oxr.spec.enableHttpEndpoint
            if get(_oxr, "spec.enableGlobalWriteForwarding", None) != None:
                enableGlobalWriteForwarding: _oxr.spec.enableGlobalWriteForwarding
            if get(_oxr, "spec.enableLocalWriteForwarding", None) != None:
                enableLocalWriteForwarding: _oxr.spec.enableLocalWriteForwarding
            if get(_oxr, "spec.enabledCloudwatchLogsExports", False):
                enabledCloudwatchLogsExports: _oxr.spec.enabledCloudwatchLogsExports
            if get(_oxr, "spec.engine", False):
                engine: _oxr.spec.engine
            if get(_oxr, "spec.engineMode", False):
                engineMode: _oxr.spec.engineMode
            if get(_oxr, "spec.claimRef.name", False):
                finalSnapshotIdentifier: _oxr.spec.claimRef.name
            if get(_oxr, "spec.iamDatabaseAuthenticationEnabled", None) != None:
                iamDatabaseAuthenticationEnabled: _oxr.spec.iamDatabaseAuthenticationEnabled
            if get(_oxr, "spec.iops", False):
                iops: _oxr.spec.iops
            if get(_oxr, "spec.masterUsername", False):
                masterUsername: _oxr.spec.masterUsername
            if get(_oxr, "spec.preferredBackupWindow", False):
                preferredBackupWindow: _oxr.spec.preferredBackupWindow
            if get(_oxr, "spec.preferredMaintenanceWindow", False):
                preferredMaintenanceWindow: _oxr.spec.preferredMaintenanceWindow
            if get(_oxr, "spec.restoreToPointInTime", False):
                restoreToPointInTime: [_restoreToPointInTime]
            if get(_oxr, "status.securityGroupId", False):
                vpcSecurityGroupIds: [_oxr.status.securityGroupId]
            if get(_oxr, "spec.storageType", False):
                storageType: _oxr.spec.storageType
            if get(_oxr, "spec.sourceRegion", False):
                sourceRegion: _oxr.spec.sourceRegion

            if _s3import:
                s3Import: [_s3import]
            if _scalingConfiguration:
                scalingConfiguration: [_scalingConfiguration]
            if _serverlessv2scaling:
                serverlessv2ScalingConfiguration: [_serverlessv2scaling]
            if _ipgn:
                dbInstanceParameterGroupName: _ipgn
        }
        providerConfigRef: get(_oxr, "spec.providerConfigRef", {"name": "default"})
        writeConnectionSecretToRef: {
            name: "${_oxr.spec.claimRef.name}-${_region}-cluster"
            namespace: _oxr.spec.claimRef.namespace
        }
    }
} if _keyId and _subnetGroup else False

_secretRef = False
if _createCluster:
    if get(_ocds, "rds-cluster.Resource", False) and all_true([
        c.status == "True" for c in get(_ocds, "rds-cluster.Resource.status.conditions", [])
    ]):
        _secretRef = get(_ocds, "rds-cluster.Resource.spec.writeConnectionSecretToRef.name", "")

_newdxr = {
    **_dxr,
    **{
        "status": {
            clusterIdentifier: _clusterIdentifier,
            clusterResourceId: _clusterResourceId,
            clusterArn: _clusterArn,
            endpoint: _endpoint,
            port: _port,
            if _secretRef:
                connectionSecret: _secretRef,
        }
    }
} if _cluster and _created else False

items = [x for x in [_cluster, _newdxr] if x and _createCluster]