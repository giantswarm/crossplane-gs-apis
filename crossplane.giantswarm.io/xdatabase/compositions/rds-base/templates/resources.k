import regex
import json

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

_createCluster = get(_oxr, "spec.createCluster", True)
_appName = get(_oxr, "spec.claimRef.name", "")
_clusterIdentifier = get(_oxr, "status.clusterIdentifier", None)
_clusterResourceId = get(_oxr, "status.clusterResourceId", None)
_monitoringRoleArn = get(_oxr, "status.monitoringRoleArn", None)
_dbSubnetGroupName = get(_oxr, "status.dbSubnetGroupName", None)
_region = get(_oxr, "spec.region", "eu-central-1")

_partition = get(_oxr, "spec.partition", "aws")
_labels = {}
_tags = {}

_keyId = get(_oxr, "status.kmsKeyId", False)

_restoreToPointInTime = {
    sourceDbInstanceIdentifier = get(_oxr, "spec.restoreToPointInTime.sourceDbClusterIdentifier", None),
    sourceDbInstanceAutomatedBackupsArn = get(_oxr, "spec.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn", None),
    sourceDbiResourceId = get(_oxr, "spec.restoreToPointInTime.sourceDbiResourceId", None),
} | {
    restoreTime = get(_oxr, "spec.restoreToPointInTime.restoreToTime", None),
} if get(_oxr, "spec.restoreToPointInTime.restoreToTime", False) else {
    useLatestRestorableTime = get(_oxr, "spec.restoreToPointInTime.useLatestRestorableTime", True),
}
_s3import = get(_oxr, "spec.s3Import", False)

# Has the master instance been built?
_masterInstance = get(_ocds, "instance-0.Resource.status.atProvider", {})
_specInstances = get(_oxr, "spec.instances", [])

# This will force the secondary (read) replicas to be built after the primary
# instance has been built. This is to ensure that the primary instance is
# available for binding.
_buildInstances = _specInstances[:1] if not _masterInstance else _specInstances

##
# Create Database Instances
#
# This block will create one of two kinds of instance. If the `createCluster`
# option is set to `true`, then a kind of `ClusterInstance` will be created.
# This has fewer options assigned to it as it is part of a cluster and by
# default inherits settings from the Cluster configuration.
#
# The other kind of instance is an `Instance`. This is created when the cluster
# is not being created and is a standalone instance. This instance has more
# options available to it even though many of them can be inherited from the
# Cluster configuration.
#
# In both instance types, the cluster configuration may be used to spedify
# common settings across all instances being built-
_instances = [
    {
        _version = "v1beta1" if _createCluster else "v1beta2"
        apiVersion: "rds.aws.upbound.io/${_version}"
        kind: "ClusterInstance" if _createCluster else "Instance"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "instance-${i}"
            }
            labels: _labels
        }

        _availabilityZones = get(_oxr, "spec.availabilityZones", [])
        _az = get(item, "spec.availabilityZone", False)
        if not _az and len(_availabilityZones) > 0:
            _az = _availabilityZones[i % len(_availabilityZones)]
        _az = "${_region}${_az}" if _az else ""

        _cacert = get(_oxr, "status.caCertIdentifier", False),
        _pt = get(item, "spec.promotionTier", False)
        _dbp = get(item, "spec.parameterGroupName", get(_oxr, "spec.parameterGroup.name", False)),
        _isPrimaryInstance = i == 0
        _multiAz = get(item, "spec.multiAz", get(_oxr, "spec.multiAz", False))
        _instanceUseAz = not _createCluster and not _multiAz

        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                if not _createCluster:
                    # These options are specific to the Instance kind
                    allocatedStorage: get(item, "spec.allocatedStorage", get(_oxr, "spec.allocatedStorage", 20)),
                    allowMajorVersionUpgrade: get(item, "spec.allowMajorVersionUpgrade", get(_oxr, "spec.allowMajorVersionUpgrade", True)),
                    backupRetentionPeriod: get(item, "spec.backupRetentionPeriod", get(_oxr, "spec.backupRetentionPeriod", 7)),
                    backupWindow: get(item, "spec.preferredBackupWindow", get(_oxr, "spec.preferredBackupWindow", "03:00-04:00")),
                    deleteAutomatedBackups: get(item, "spec.deleteAutomatedBackups", get(_oxr, "spec.deleteAutomatedBackups", True)),
                    deletionProtection: get(item, "spec.deletionProtection", get(_oxr, "spec.deletionProtection", False)),

                    if get(item, "spec.domainIamRoleName", get(_oxr, "spec.domainIamRoleName", False)):
                        domainIamRoleName: get(item, "spec.domainIamRoleName", get(_oxr, "spec.domainIamRoleName", None)),

                    enabledCloudwatchLogsExports: get(item, "spec.enabledCloudwatchLogsExports", get(_oxr, "spec.enabledCloudwatchLogsExports", [])),
                    if get(item, "spec.finalSnapshotIdentifier", get(_oxr, "spec.finalSnapshotIdentifier", False)):
                        finalSnapshotIdentifier: get(item, "spec.finalSnapshotIdentifier", get(_oxr, "spec.finalSnapshotIdentifier", None)),
                    iamDatabaseAuthenticationEnabled: get(item, "spec.iamDatabaseAuthenticationEnabled", get(_oxr, "spec.iamDatabaseAuthenticationEnabled", False)),
                    iops: get(item, "spec.iops", get(_oxr, "spec.iops", 0)),
                    kmsKeyId: _keyId,
                    licenseModel: get(item, "spec.licenseModel", get(_oxr, "spec.licenseModel", "general-public-license")),
                    maintenanceWindow: get(item, "spec.preferredMaintenanceWindow", get(_oxr, "spec.preferredMaintenanceWindow", "sun:05:00-sun:06:00")),
                    multiAz: _multiAz,
                    networkType: get(item, "spec.networkType", get(_oxr, "spec.networkType", "standard")),

                    # Option group is specific to non-postgresql instances but
                    # may be set for mysql and mssql instance types
                    if get(item, "spec.optionGroupName", get(_oxr, "spec.optionGroupName", False)):
                        optionGroupName: get(item, "spec.optionGroupName", get(_oxr, "spec.optionGroupName", None)),

                    if _restoreToPointInTime and get(_oxr, "spec.restoreToPointInTime.identifier", False):
                        identifier: get(_oxr, "spec.restoreToPointInTime.identifier", None),
                        restoreToPointInTime: [_restoreToPointInTime],
                    skipFinalSnapshot: get(item, "spec.skipFinalSnapshot", get(_oxr, "spec.skipFinalSnapshot", False)),

                    if get(item, "spec.snapshotIdentifier", get(_oxr, "spec.snapshotIdentifier", False)):
                        snapshotIdentifier: get(item, "spec.snapshotIdentifier", get(_oxr, "spec.snapshotIdentifier", None)),

                    storageEncrypted: get(item, "spec.storageEncrypted", get(_oxr, "spec.storageEncrypted", True)),
                    if get(item, "spec.storageType", get(_oxr, "spec.storageType", "gp2")) == "gp3":
                        storageThroughput: get(item, "spec.storageThroughput", get(_oxr, "spec.storageThroughput", 0)),
                    storageType: get(item, "spec.storageType", get(_oxr, "spec.storageType", "gp2")),
                    vpcSecurityGroupIds: [get(_oxr, "status.securityGroupId", "")],

                    # If this is the primary (non-cluster) instance, set
                    # the database name and master user password. Additionally,
                    # if s3Import has been defined, this is configured here.
                    if _isPrimaryInstance:
                        _dbName = get(item, "spec.databaseName", get(_oxr, "spec.databaseName", False))
                        if _dbName:
                            dbName: _dbName,
                        manageMasterUserPassword: get(item, "spec.manageMasterUserPassword", get(_oxr, "spec.manageMasterUserPassword", True)),
                        masterUserSecretKmsKeyId: _keyId,
                        username: get(item, "spec.username", get(_oxr, "spec.masterUsername", None)),
                        if _s3import:
                            s3import: _s3import,

                    # If this is not the primary (non-cluster) instance, the
                    # replication source
                    if not _isPrimaryInstance and _masterInstance:
                        replicateSourceDb: get(_masterInstance, "id", None),
                    if _dbp:
                        parameterGroupName: _dbp

                dbSubnetGroupName: _dbSubnetGroupName,
                engine: get(_oxr, "spec.engine", "postgres"),
                engineVersion: get(_oxr, "spec.engineVersion", "14.0"),
                instanceClass: get(item, "spec.instanceClass", get(_oxr, "spec.dbClusterInstanceClass", "db.t3.medium")),
                monitoringInterval: get(item, "spec.monitoringInterval", get(_oxr, "spec.enhancedMonitoring.monitoringInterval", 0)),
                if _monitoringRoleArn:
                    monitoringRoleArn: _monitoringRoleArn,
                performanceInsightsEnabled: get(item, "spec.performanceInsightsEnabled", get(_oxr, "spec.performanceInsightsEnabled", False)),
                performanceInsightsKmsKeyId: get(item, "spec.performanceInsightsKmsKeyId", get(_oxr, "spec.performanceInsightsKmsKeyId", _keyId)),
                performanceInsightsRetentionPeriod: get(item, "spec.performanceInsightsRetentionPeriod", get(_oxr, "spec.performanceInsightsRetentionPeriod", 7)),
                applyImmediately: get(item, "spec.applyImmediately", get(_oxr, "spec.applyImmediately", True)),
                autoMinorVersionUpgrade: get(item, "spec.autoMinorVersionUpgrade", get(_oxr, "spec.autoMinorVersionUpgrade", True)),

                # Only set the availability zone if this is a cluster instance
                # or if the instance is not multi-AZ and an availability zone is
                # provided
                if (_createCluster or _instanceUseAz) and _az:
                        availabilityZone: _az,

                if _cacert:
                    caCertIdentifier: _cacert

                if _createCluster:
                    clusterIdentifier: _clusterIdentifier,
                    preferredBackupWindow: get(item, "spec.preferredBackupWindow", get(_oxr, "spec.preferredBackupWindow", "03:00-04:00")),
                    preferredMaintenanceWindow: get(item, "spec.preferredMaintenanceWindow", get(_oxr, "spec.preferredMaintenanceWindow", "sun:05:00-sun:06:00")),
                    if _pt:
                        promotionTier: _pt,
                    if _dbp:
                        dbParameterGroupName: _dbp,

                copyTagsToSnapshot: get(item, "spec.copyTagsToSnapshot", get(_oxr, "spec.copyTagsToSnapshot", True)),
                publiclyAccessible: get(item, "spec.publiclyAccessible", get(_oxr, "spec.publiclyAccessible", False)),
                region: _region,
                tags: _tags | get(item, "spec.tags", {}) | {
                    "Name": "${_appName}-${_region}${_az}-${i}"
                },
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    }
    for i, item in _buildInstances if all_true([
        any_true([
            (_createCluster and _clusterIdentifier != None), not _createCluster
        ]),
        _keyId,
        _dbSubnetGroupName
    ])
]

##
# OptionGroups may be specified for non-cluster, non-postgresql instances.
# postgresql isntances do not use optiongroups but instead uses extensions.
_optionGroup = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "OptionGroup"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "option-group"
                "crossplane.io/external-name" = get(_oxr, "spec.optionGroup.name", "")
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                engineName: get(_oxr, "spec.engine", "postgres"),
                majorEngineVersion: get(_oxr, "spec.engineVersion", "14.0"),
                option: [
                    {
                        if get(item, "dbSecurityGroupMemberships", False):
                            dbSecurityGroupMemberships: get(item, "dbSecurityGroupMemberships", []),
                        optionName: get(item, "optionName", ""),
                        optionSettings: [
                            {
                                name: key,
                                value: value,
                            }
                            for key, value in get(item, "optionSettings", [])
                        ],
                    }
                    for i, item in get(_oxr, "spec.optionGroup.options", {})
                ],
                region: _region,
                if get(_oxr, "spec.optionGroup.version", False):
                    version: get(_oxr, "spec.optionGroup.version", ""),

                optionGroupDescription: get(_oxr, "spec.optionGroup.description", "${_appName} Option group"),

                tags: _tags | {
                    "Name": "${_appName}-option-group"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if not _createCluster and get(_oxr, "spec.optionGroup.create", False) else {}
]

_endpoints = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ClusterEndpoint"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "endpoint-${i}"
            }
            labels: _labels
        }

        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                clusterEndpointIdentifier: get(item, "spec.clusterEndpointIdentifier", None),
                clusterIdentifier: _clusterIdentifier,
                customEndpointType: get(item, "spec.type", "ANY"),
                excludeMembers: get(item, "spec.excludeMembers", []),
                staticMembers: get(item, "spec.staticMembers", []),
                region: _region,
                tags: _tags | get(item, "spec.tags", {}) | {
                    "Name": "${_appName}-${_region}-${i}"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    }
    for i, item in get(_oxr, "spec.endpoints", []) if all_true([_createCluster, _clusterIdentifier != None])
]

##
# Create IAM Role associations
#
# This will create one of two kinds of IAM Role associations. If the
# `createCluster` option is set to `true`, then a kind of `ClusterRoleAssociation`
# will be created.
#
# The other kind of IAM Role association is an `InstanceRoleAssociation`. This is
# created when the cluster is not being created and is a standalone instance,
# multiAz instance, or standalone with read replicas.
_iam_roles = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        if _createCluster:
            kind: "ClusterRoleAssociation"
        if not _createCluster:
            kind: "InstanceRoleAssociation"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "iam-role-${i}"
            }
            labels: _labels
        }

        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                if _createCluster:
                    dbClusterIdentifier: _clusterIdentifier,
                if not _createCluster:
                    dbInstanceIdentifier: get(_ocds, "instance-0.Resource.status.atProvider.id", ""),
                featureName: get(item, "spec.featureName", "s3Import"),
                roleArn: get(item, "spec.roleArn", ""),
                region: _region,
                tags: _tags | get(item, "spec.tags", {}) | {
                    "Name": "${_appName}-${_region}-${i}"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    }
    for i, item in get(_oxr, "spec.iamRoles", [])
]

_createMonitoringRole = get(_oxr, "spec.enhancedMonitoring.enabled", False) and get(_oxr, "spec.enhancedMonitoring.monitoringInterval", 0) > 0

_monitoringRole = [
    {
        apiVersion: "iam.aws.upbound.io/v1beta1"
        kind: "Role"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "enhanced-monitoring-role"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                assumeRolePolicy: json.encode({
                    Version: "2012-10-17",
                    Statement: [
                        {
                            Effect: "Allow",
                            Principal: {
                                Service: "monitoring.rds.amazonaws.com"
                            },
                            Action: "sts:AssumeRole"
                        }
                    ]
                }, ignore_private=True),
                description: get(_oxr, "spec.enhancedMonitoring.description", "Role for RDS monitoring"),
                managedPolicyArns: get(_oxr, "spec.enhancedMonitoring.managedPolicyArns", None),
                permissionsBoundary: get(_oxr, "spec.enhancedMonitoring.permissionsBoundary", None),
                forceDetachPolicies: get(_oxr, "spec.enhancedMonitoring.forceDetachPolicies", False),
                maxSessionDuration: get(_oxr, "spec.enhancedMonitoring.maxSessionDuration", None),
                path: get(_oxr, "spec.enhancedMonitoring.path", "/"),
                name: "rds-monitoring-role",
                tags: _tags | get(_oxr, "spec.enhancedMonitoring.tags", {}) | {
                    "Name": "${_appName}-monitoring-role"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if _createMonitoringRole else {}
] + [
    {
        apiVersion: "iam.aws.upbound.io/v1beta1"
        kind: "RolePolicyAttachment"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "monitoring-role-attachment"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                policyArn: "arn:${_partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole",
                role: "rds-monitoring-role",
                tags: _tags | {
                    "Name": "${_appName}-monitoring-role-attachment"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if _createMonitoringRole else {}
]

_instanceCreated = get(_ocds, "instance-0.Resource.status.atProvider.id", False) and _createCluster

# Define autoscaling if this is the required scaling mode for RDS Cluster builds
_autoscalingTarget = [
    {
        apiVersion: "appautoscaling.aws.upbound.io/v1beta1"
        kind: "Target"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "autoscaling-target"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            initProvider: {
                tags: _tags | get(_oxr, "spec.autoscaling.tags", {}) | {
                    "Name": "${_appName}-autoscaling"
                }
            }
            forProvider: {
                maxCapacity: get(_oxr, "spec.autoscaling.maxCapacity", 2),
                minCapacity: get(_oxr, "spec.autoscaling.minCapacity", 2),
                resourceId: "cluster:${_clusterIdentifier}",
                region: _region,
                scalableDimension: "rds:cluster:ReadReplicaCount",
                serviceNamespace: "rds",
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if all_true([
        _instanceCreated,
        get(_oxr, "spec.autoscaling.enabled", False),
        _createCluster,
     ]) else {}
]

_tc = get(_oxr, "spec.autoscaling.metricType", "RDSReaderAverageCPUUtilization")
_tv = get(_oxr, "spec.autoscaling.targetCPU", 70) if _tc == "RDSReaderAverageCPUUtilization" else get(_oxr, "spec.autoscaling.targetConnections", 700)

_autoscalingTargetCreated = get(_ocds, "autoscaling-target.Resource.status.atProvider.id", False)

_autoscalingPolicy = [
    {
        apiVersion: "appautoscaling.aws.upbound.io/v1beta1"
        kind: "Policy"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "autoscaling-policy"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                policyType: "TargetTrackingScaling",
                resourceId: "cluster:${_clusterIdentifier}",
                scalableDimension: "rds:cluster:ReadReplicaCount",
                serviceNamespace: "rds",
                targetTrackingScalingPolicyConfiguration: [
                    {
                        predefinedMetricSpecification: [
                            {
                                predefinedMetricType: _tc,
                            },
                        ],
                        disableScaleIn: get(_oxr, "spec.autoscaling.disableScaleIn", False),
                        scaleInCooldown: get(_oxr, "spec.autoscaling.scaleInCooldown", 60),
                        scaleOutCooldown: get(_oxr, "spec.autoscaling.scaleOutCooldown", 60),
                        targetValue: _tv
                    },
                ],
                region: _region,
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if all_true([
        _autoscalingTargetCreated,
        get(_oxr, "spec.autoscaling.enabled", False),
        _createCluster,
     ]) else {}
]

_autoscaling = _autoscalingTarget + _autoscalingPolicy

_engine = get(_oxr, "spec.engine", "postgres")
_port = get(_oxr, "status.port", False)
_optionGroupPort = get(_oxr, "spec.optionGroup.port", False)

# Create security group rules for the cluster
_securityGroupRules = [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "SecurityGroupRule"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "security-group-rule-${i}"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                securityGroupId: get(_oxr, "status.securityGroupId", ""),
                cidrBlocks: [cidr],
                fromPort: -1,
                protocol: "tcp",
                region: _region,
                toPort: _port,
                type: "ingress",
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    }
    for i, cidr in get(_oxr, "spec.cidrBlocks", []) if _port
] + [
    {
        apiVersion: "ec2.aws.upbound.io/v1beta1"
        kind: "SecurityGroupRule"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "security-group-rule-${i}"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                securityGroupId: get(_oxr, "status.securityGroupId", ""),
                cidrBlocks: [cidr],
                fromPort: -1,
                protocol: "tcp",
                region: _region,
                toPort: _optionGroupPort,
                type: "ingress",
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    }
    for i, cidr in get(_oxr, "spec.cidrBlocks", []) if all_true([
        get(_oxr, "spec.optionGroup.enabled", False),
        _optionGroupPort,
        _optionGroupPort != _port
    ])
]

# If the cluster parameter group is requested and we're creating a cluster
_clusterParameterGroup = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ClusterParameterGroup"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "cluster-parameter-group"
                "crossplane.io/external-name" = get(_oxr, "spec.dbClusterParameterGroup.name", "")
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                description: get(_oxr, "spec.parameterGroup.description", "Cluster parameter group"),
                family: get(_oxr, "spec.parameterGroup.family", "aurora-postgresql11"),
                parameter: get(_oxr, "spec.parameterGroup.parameters", {}),
                region: _region,
                tags: _tags | {
                    "Name": "${_appName}-cluster-parameter-group"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if get(_oxr, "spec.dbClusterParameterGroup.create", False) and _createCluster else {}
]

# If the db parameter group is requested create it
_dbParameterGroup = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ParameterGroup"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "db-parameter-group"
                "crossplane.io/external-name" = get(_oxr, "spec.dbParameterGroup.name", "")
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                description: get(_oxr, "spec.parameterGroup.description", "DB parameter group"),
                family: get(_oxr, "spec.parameterGroup.family", "aurora-postgresql11"),
                parameter: get(_oxr, "spec.parameterGroup.parameters", {}),
                region: _region,
                tags: _tags | {
                    "Name": "${_appName}-db-parameter-group"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if get(_oxr, "spec.dbParameterGroup.create", False) else {}
]

# Cloudwatch log groups
_logGroups = get(_oxr, "spec.enabledCloudwatchLogsExports", [])
_lgEnabled = get(_oxr, "spec.cloudwatchLogGroupParameters.create", False) and len(_logGroups) > 0
_cloudwatchLogGroups = [
    {
        apiVersion: "cloudwatchlogs.aws.upbound.io/v1beta1"
        kind: "Group"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "log-group-${i}"
                "crossplane.io/external-name" = "/aws/rds/cluster/${_clusterIdentifier}/${item}"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                logGroupClass: get(item, "spec.cloudwatchLogGroupParameters.class", "Standard"),
                retentionInDays: get(item, "spec.cloudwatchLogGroupParameters.retentionInDays", 0),
                kmsKeyId: get(_oxr, "status.kmsKeyId", None),
                skipDestroy: get(item, "spec.cloudwatchLogGroupParameters.skipDestroy", False),
                region: _region,
                tags: _tags | get(item, "spec.tags", {}) | {
                    "Name": "${_appName}-log-group-${i}"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    }
    for i, item in _logGroups if _lgEnabled and _keyId
]

# If we're creating a cluster and the activity stream is enabled, create it
_clusterActivityStream = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ClusterActivityStream"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "activity-stream"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                applyImmediately: get(_oxr, "spec.activityStream.applyImmediately", True),
                enabled: get(_oxr, "spec.activityStream.enabled", False),
                kmsKeyId: get(_oxr, "status.kmsKeyId", None),
                mode: get(_oxr, "spec.activityStream.mode", "sync"),
                region: _region,
                tags: _tags | {
                    "Name": "${_appName}-activity-stream"
                }
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if get(_oxr, "spec.activityStream.enabled", False) and _createCluster else {}
]

# If secret rotation is enabled, create the secret rotation resource
_secretRotation = [
    {
        apiVersion: "secretsmanager.aws.upbound.io/v1beta1"
        kind: "SecretRotation"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "secret-rotation"
            }
            labels: _labels
        }
        spec: {
            deletionPolicy: get(_oxr, "spec.deletionPolicy", "Delete"),
            forProvider: {
                secretId: get(_oxr, "status.secretId", ""),
                region: _region,
                rotateImmediately: get(_oxr, "spec.secretRotation.rotateImmediately", False),
                rotationRules: [
                    {
                        duration: get(_oxr, "spec.secretRotation.duration", 0),
                    } | {
                        automaticallyAfterDays: get(_oxr, "spec.secretRotation.afterDays", 30),
                    } if get(_oxr, "spec.secretRotation.afterDays", False) != False else {
                        scheduleExpression: get(_oxr, "spec.secretRotation.scheduleExpression", "")
                    }
                ],
            }
            providerConfigRef: _oxr.spec.providerConfigRef
        }
    } if get(_oxr, "spec.secretRotation.enabled", False) else {}
]

# If this is a non-cluster build, the DXR is created to patch the master
# instance endpoint and port back to the XR status
_newdxr = {
    **_dxr,
    **{
        "status": {
            endpoint: get(_masterInstance, "address", ""),
            port: get(_masterInstance, "port", 0),
        }
    }
} if not _createCluster and _masterInstance else {}

# Bring all items together in a list of lists
_items = [
    _instances, _endpoints, _iam_roles, _monitoringRole,
    _autoscaling, _securityGroupRules, _clusterParameterGroup,
    _dbParameterGroup, _cloudwatchLogGroups, _clusterActivityStream,
    _secretRotation, [_newdxr]
]

# Flatten items to a single list for processing
items = [i for x in _items for i in x if i]