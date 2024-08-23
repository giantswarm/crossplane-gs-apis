ipgn = get(oxr, "spec.dbParameterGroup.name", "") if get(oxr, "spec.allowMajorVersionUpgrade", False) else ""
provisioned = get(oxr, "spec.engineMode", "provisioned") == "provisioned"
regionedAzs = ["${region}${az}" for az in get(oxr, "spec.availabilityZones", ["a", "b", "c"])]
subnetGroup = get(oxr, "status.dbSubnetGroupName", False)
serverless = get(oxr, "spec.engineMode", "provisioned") == "serverless"
scalingConfiguration = get(oxr, "spec.scalingConfiguration", False) if serverless else False
serverlessv2scaling = get(oxr, "spec.serverlessv2scalingConfiguration", False) if provisioned else False

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
            if get(oxr, "spec.allowMajorVersionUpgrade", True):
                if get(oxr, "spec.engineVersion", False):
                    "engineVersion": oxr.spec.engineVersion
            if get(oxr, "spec.globalClusterIdentifier", False):
                "globalClusterIdentifier": oxr.spec.globalClusterIdentifier
            if get(oxr, "spec.replicationSourceIdentifier", False):
                "replicationSourceIdentifier": oxr.spec.replicationSourceIdentifier
        }

        "forProvider": {
            _managedMasterUserPassword = False
            _autoGeneratePassword = get(oxr, "spec.autoGeneratePassword", True),
            if _autoGeneratePassword and not _managedMasterUserPassword:
                "autoGeneratePassword": _autoGeneratePassword,
                "masterPasswordSecretRef": {
                    "key": "password",
                    "namespace": get(oxr, "spec.claimRef.namespace", "default"),
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

            if get(oxr, "spec.allocatedStorage", False):
                "allocatedStorage": oxr.spec.allocatedStorage
            if get(oxr, "spec.allowMajorVersionUpgrade", None) != None:
                "allowMajorVersionUpgrade": oxr.spec.allowMajorVersionUpgrade
            if get(oxr, "spec.applyImmediately", None) != None:
                "applyImmediately": oxr.spec.applyImmediately
            if get(oxr, "spec.availabilityZones", False):
                "availabilityZones": regionedAzs
            if get(oxr, "spec.backupRetentionPeriod", False):
                "backupRetentionPeriod": oxr.spec.backupRetentionPeriod
            if get(oxr, "spec.backtrackWindow", False):
                "backtrackWindow": oxr.spec.backtrackWindow
            if get(oxr, "spec.clusterMembers", False):
                "clusterMembers": oxr.spec.clusterMembers
            if get(oxr, "spec.databaseName", False):
                "databaseName": oxr.spec.databaseName
            if all_true([
                get(oxr, "spec.dbClusterInstanceClass", False),
                not get(oxr, "spec.engine", "").startswith("aurora"),
            ]):
                "dbClusterInstanceClass": oxr.spec.dbClusterInstanceClass
            if get(oxr, "spec.dbClusterParameterGroup.name", False):
                "dbClusterParameterGroupName": oxr.spec.dbClusterParameterGroup.name
            if get(oxr, "spec.dbInstanceParameterGroup.name", False):
                "dbInstanceParameterGroupName": oxr.spec.dbInstanceParameterGroup.name
            if get(oxr, "spec.deletionProtection", None) != None:
                "deletionProtection": oxr.spec.deletionProtection
            if get(oxr, "spec.deleteAutomatedBackups", None) != None:
                "deleteAutomatedBackups": oxr.spec.deleteAutomatedBackups
            if get(oxr, "spec.domain", False):
                "domain": oxr.spec.domain
            if get(oxr, "spec.domainIAMRoleName", False):
                "domainIAMRoleName": oxr.spec.domainIAMRoleName
            if get(oxr, "spec.enableHttpEndpoint", False):
                "enableHttpEndpoint": oxr.spec.enableHttpEndpoint
            if get(oxr, "spec.enableGlobalWriteForwarding", None) != None:
                "enableGlobalWriteForwarding": oxr.spec.enableGlobalWriteForwarding
            if get(oxr, "spec.enableLocalWriteForwarding", None) != None:
                "enableLocalWriteForwarding": oxr.spec.enableLocalWriteForwarding
            if get(oxr, "spec.enabledCloudwatchLogsExports", False):
                "enabledCloudwatchLogsExports": oxr.spec.enabledCloudwatchLogsExports
            if get(oxr, "spec.engine", False):
                "engine": oxr.spec.engine
            if get(oxr, "spec.engineMode", False):
                "engineMode": oxr.spec.engineMode

            if not get(oxr, "spec.allowMajorVersionUpgrade", True):
                if get(oxr, "spec.engineVersion", False):
                    "engineVersion": get(oxr, "spec.engineVersion", "")

            if get(oxr, "spec.claimRef.name", False):
                "finalSnapshotIdentifier": oxr.spec.claimRef.name
            if get(oxr, "spec.iamDatabaseAuthenticationEnabled", None) != None:
                "iamDatabaseAuthenticationEnabled": oxr.spec.iamDatabaseAuthenticationEnabled
            if get(oxr, "spec.iops", False):
                "iops": oxr.spec.iops
            if get(oxr, "spec.masterUsername", False):
                "masterUsername": oxr.spec.masterUsername
            if get(oxr, "spec.preferredBackupWindow", False):
                "preferredBackupWindow": oxr.spec.preferredBackupWindow
            if get(oxr, "spec.preferredMaintenanceWindow", False):
                "preferredMaintenanceWindow": oxr.spec.preferredMaintenanceWindow
            if get(oxr, "spec.restoreToPointInTime", False):
                "restoreToPointInTime": [restoreToPointInTime]
            if get(oxr, "status.securityGroupId", False):
                "vpcSecurityGroupIds": [oxr.status.securityGroupId]
            if get(oxr, "spec.storageType", False):
                "storageType": oxr.spec.storageType
            if get(oxr, "spec.sourceRegion", False):
                "sourceRegion": oxr.spec.sourceRegion

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
        "managementPolicies": mgmtPolicy,
        "providerConfigRef": pcr,
        "writeConnectionSecretToRef": {
            "name": "${appName}-${region}-rds"
            "namespace": get(oxr, "spec.claimRef.namespace", "default")
        }
    }
} if keyId and subnetGroup else {}

_items = [
    x for x in [cluster]
    if x and createCluster
]