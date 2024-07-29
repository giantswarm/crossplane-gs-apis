ipgn = get(_oxr, "spec.dbParameterGroup.name", "") if get(_oxr, "spec.allowMajorVersionUpgrade", False) else ""
provisioned = get(_oxr, "spec.engineMode", "provisioned") == "provisioned"
regionedAzs = ["${region}${az}" for az in get(_oxr, "spec.availabilityZones", ["a", "b", "c"])]
subnetGroup = get(_oxr, "status.dbSubnetGroupName", False)
serverless = get(_oxr, "spec.engineMode", "provisioned") == "serverless"
scalingConfiguration = get(_oxr, "spec.scalingConfiguration", False) if serverless else False
serverlessv2scaling = get(_oxr, "spec.serverlessv2scalingConfiguration", False) if provisioned else False

cluster = {
    "apiVersion": "rds.aws.upbound.io/v1beta1"
    "kind": "Cluster"
    "metadata": {
        "annotations": {
            "krm.kcl.dev/composition-resource-name": "rds-cluster"
            "krm.kcl.dev/ready": readystr("rds-cluster")
            "crossplane.io/external-name": appName
        }
        "labels": labels
    }
    "spec": {
        "deletionPolicy": dp
        "initProvider": {
            if get(_oxr, "spec.allowMajorVersionUpgrade", True):
                if get(_oxr, "spec.engineVersion", False):
                    "engineVersion": _oxr.spec.engineVersion
            if get(_oxr, "spec.globalClusterIdentifier", False):
                "globalClusterIdentifier": _oxr.spec.globalClusterIdentifier
            if get(_oxr, "spec.replicationSourceIdentifier", False):
                "replicationSourceIdentifier": _oxr.spec.replicationSourceIdentifier
        }

        "forProvider": {
            _managedMasterUserPassword = False
            _autoGeneratePassword = get(_oxr, "spec.autoGeneratePassword", True),
            if _autoGeneratePassword and not _managedMasterUserPassword:
                "autoGeneratePassword": _autoGeneratePassword,
                "masterPasswordSecretRef": {
                    "key": "password",
                    "namespace": get(_oxr, "spec.claimRef.namespace", "default"),
                    "name": "${appName}-${region}-rds-autogen-pass",
                }

            "copyTagsToSnapshot": True
            "networkType": "IPV4"
            "skipFinalSnapshot": True
            "storageEncrypted": True
            "region": region
            "kmsKeyId": keyId
            "dbSubnetGroupName": subnetGroup
            "tags": tags | {
                Name: "${appName}-${region}"
            }

            if get(_oxr, "spec.allocatedStorage", False):
                "allocatedStorage": _oxr.spec.allocatedStorage
            if get(_oxr, "spec.allowMajorVersionUpgrade", None) != None:
                "allowMajorVersionUpgrade": _oxr.spec.allowMajorVersionUpgrade
            if get(_oxr, "spec.applyImmediately", None) != None:
                "applyImmediately": _oxr.spec.applyImmediately
            if get(_oxr, "spec.availabilityZones", False):
                "availabilityZones": regionedAzs
            if get(_oxr, "spec.backupRetentionPeriod", False):
                "backupRetentionPeriod": _oxr.spec.backupRetentionPeriod
            if get(_oxr, "spec.backtrackWindow", False):
                "backtrackWindow": _oxr.spec.backtrackWindow
            if get(_oxr, "spec.clusterMembers", False):
                "clusterMembers": _oxr.spec.clusterMembers
            if get(_oxr, "spec.databaseName", False):
                "databaseName": _oxr.spec.databaseName
            if get(_oxr, "spec.dbClusterInstanceClass", False):
                "dbClusterInstanceClass": _oxr.spec.dbClusterInstanceClass
            if get(_oxr, "spec.dbClusterParameterGroup.name", False):
                "dbClusterParameterGroupName": _oxr.spec.dbClusterParameterGroup.name
            if get(_oxr, "spec.dbInstanceParameterGroup.name", False):
                "dbInstanceParameterGroupName": _oxr.spec.dbInstanceParameterGroup.name
            if get(_oxr, "spec.deletionProtection", None) != None:
                "deletionProtection": _oxr.spec.deletionProtection
            if get(_oxr, "spec.deleteAutomatedBackups", None) != None:
                "deleteAutomatedBackups": _oxr.spec.deleteAutomatedBackups
            if get(_oxr, "spec.domain", False):
                "domain": _oxr.spec.domain
            if get(_oxr, "spec.domainIAMRoleName", False):
                "domainIAMRoleName": _oxr.spec.domainIAMRoleName
            if get(_oxr, "spec.enableHttpEndpoint", False):
                "enableHttpEndpoint": _oxr.spec.enableHttpEndpoint
            if get(_oxr, "spec.enableGlobalWriteForwarding", None) != None:
                "enableGlobalWriteForwarding": _oxr.spec.enableGlobalWriteForwarding
            if get(_oxr, "spec.enableLocalWriteForwarding", None) != None:
                "enableLocalWriteForwarding": _oxr.spec.enableLocalWriteForwarding
            if get(_oxr, "spec.enabledCloudwatchLogsExports", False):
                "enabledCloudwatchLogsExports": _oxr.spec.enabledCloudwatchLogsExports
            if get(_oxr, "spec.engine", False):
                "engine": _oxr.spec.engine
            if get(_oxr, "spec.engineMode", False):
                "engineMode": _oxr.spec.engineMode

            if not get(_oxr, "spec.allowMajorVersionUpgrade", True):
                if get(_oxr, "spec.engineVersion", False):
                    "engineVersion": get(_oxr, "spec.engineVersion", "")

            if get(_oxr, "spec.claimRef.name", False):
                "finalSnapshotIdentifier": _oxr.spec.claimRef.name
            if get(_oxr, "spec.iamDatabaseAuthenticationEnabled", None) != None:
                "iamDatabaseAuthenticationEnabled": _oxr.spec.iamDatabaseAuthenticationEnabled
            if get(_oxr, "spec.iops", False):
                "iops": _oxr.spec.iops
            if get(_oxr, "spec.masterUsername", False):
                "masterUsername": _oxr.spec.masterUsername
            if get(_oxr, "spec.preferredBackupWindow", False):
                "preferredBackupWindow": _oxr.spec.preferredBackupWindow
            if get(_oxr, "spec.preferredMaintenanceWindow", False):
                "preferredMaintenanceWindow": _oxr.spec.preferredMaintenanceWindow
            if get(_oxr, "spec.restoreToPointInTime", False):
                "restoreToPointInTime": [restoreToPointInTime]
            if get(_oxr, "status.securityGroupId", False):
                "vpcSecurityGroupIds": [_oxr.status.securityGroupId]
            if get(_oxr, "spec.storageType", False):
                "storageType": _oxr.spec.storageType
            if get(_oxr, "spec.sourceRegion", False):
                "sourceRegion": _oxr.spec.sourceRegion

            if s3import:
                "s3Import": [
                    s3import
                ]
            if scalingConfiguration:
                "scalingConfiguration": [
                    scalingConfiguration
                ]

            if serverlessv2scaling:
                "serverlessv2ScalingConfiguration": [
                    serverlessv2scaling
                ]
            if ipgn:
                "dbInstanceParameterGroupName": ipgn
        }
        "providerConfigRef": pcr
        "writeConnectionSecretToRef": {
            "name": "${appName}-${region}-rds"
            "namespace": get(_oxr, "spec.claimRef.namespace", "default")
        }
    }
} if keyId and subnetGroup else {}

_items = [
    x for x in [cluster]
    if x and createCluster
]