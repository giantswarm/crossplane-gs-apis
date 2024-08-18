import json

clusterId = get(oxr, "status.clusterIdentifier", None)
monitoringRoleArn = get(oxr, "status.monitoringRoleArn", None)
dbSubnetGroupName = get(oxr, "status.dbSubnetGroupName", None)

partition = get(oxr, "spec.partition", "aws")

# Has the master instance been built?
masterInstanceIdentifier = ocdsstatus("instance-0", "identifier", False)
masterInstanceArn = ocdsstatus("instance-0", "arn", False)

_specInstances = get(oxr, "spec.instances", [])

if not _specInstances and get(oxr, "spec.instanceCount", 0) > 0:
    _specInstances = [{} for i in range(get(oxr, "spec.instanceCount", 0))]

# This will force the secondary (read) replicas to be built after the primary
# instance has been built. This is to ensure that the primary instance is
# available for binding.
buildInstances = _specInstances[:1] if not masterInstance else _specInstances

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
instances = [
    {
        _availabilityZones = get(oxr, "spec.availabilityZones", [])
        _az = get(item, "availabilityZone", False)
        if not _az and len(_availabilityZones) > 0:
            _az = _availabilityZones[i % len(_availabilityZones)]
        _az = "${region}${_az}" if _az else ""

        _instanceRegion = get(item, "region", region)
        _isCrossRegion = _instanceRegion != region

        _cacert = get(oxr, "status.caCertIdentifier", False),
        _dbp = get(item, "parameterGroupName", get(oxr, "spec.parameterGroup.name", False)),
        _isPrimaryInstance = i == 0
        _multiAz = getwparent(item, oxr, "multiAz", False)
        _instanceUseAz = not createCluster and not _multiAz
        _pt = get(item, "promotionTier", False)

        _name = "${appName}-${_az}" if not _multiAz else "${appName}-instance-${i}"
        if createCluster and not _multiAz:
            _name = "${appName}-clusterinstance-${i}"

        _version = "v1beta1" if createCluster else "v1beta3"

        "apiVersion": "rds.aws.upbound.io/${_version}"
        "kind": "ClusterInstance" if createCluster else "Instance"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "instance-${i}"
                "krm.kcl.dev/ready" = readystr("instance-${i}")
            }
            "labels": labels
        }

        "spec": {
            "deletionPolicy": dp
            "initProvider": {
                if any_true([
                    getwparent(item, oxr, "allowMajorVersionUpgrade",  True),
                    getwparent(item, oxr, "autoMinorVersionUpgrade", True),
                ]):
                    "engineVersion": getwparent(item, oxr, "engineVersion", "14.0")
            }
            "forProvider": {
                if not createCluster:
                    # These options are specific to the Instance kind
                    "allowMajorVersionUpgrade": getwparent(item, oxr, "allowMajorVersionUpgrade", True)
                    "backupRetentionPeriod": getwparent(item, oxr, "backupRetentionPeriod", 7)
                    "backupWindow": getwparent(item, oxr, "preferredBackupWindow", "03:00-04:00")
                    "deleteAutomatedBackups": getwparent(item, oxr, "deleteAutomatedBackups", True)
                    "deletionProtection": getwparent(item, oxr, "deletionProtection", False)

                    _v = getwparent(item, oxr, "domainIamRoleName",  False)
                    if _v:
                        "domainIamRoleName": _v

                    "enabledCloudwatchLogsExports": getwparent(item, oxr, "enabledCloudwatchLogsExports", [])

                    _v = getwparent(item, oxr, "spec.finalSnapshotIdentifier", False)
                    if _v:
                        "finalSnapshotIdentifier": _v,

                    "iamDatabaseAuthenticationEnabled": getwparent(item, oxr, "iamDatabaseAuthenticationEnabled", False)

                    _v = getwparent(item, oxr, "iops", False)
                    if _v:
                        "iops": getwparent(item, oxr, "iops", 0)

                    "kmsKeyId": keyId,

                    _v = getwparent(item, oxr, "licenseModel", False)
                    if _v:
                        "licenseModel": _v

                    "maintenanceWindow": getwparent(item, oxr, "preferredMaintenanceWindow", "sun:05:00-sun:06:00"),
                    "multiAz": _multiAz,
                    "networkType": getwparent(item, oxr, "networkType", "ipv4")

                    "identifierPrefix": appName
                    # Option group is specific to non-postgresql instances but
                    # may be set for mysql and mssql instance types
                    _v = getwparent(item, oxr, "optionGroupName", False)
                    if _v:
                        "optionGroupName": _v

                    if restoreToPointInTime and get(oxr, "spec.restoreToPointInTime.identifier", False):
                        "restoreToPointInTime": [
                            restoreToPointInTime
                        ],

                    _skipFS = getwparent(item, oxr, "skipFinalSnapshot", True)
                    "skipFinalSnapshot": _skipFS
                    if not _skipFS:
                        "snapshotIdentifier": getwparent(item, oxr, "snapshotIdentifier", appName)

                    "storageEncrypted": getwparent(item, oxr, "storageEncrypted", True)

                    _storageType = getwparent(item, oxr, "storageType", "gp2")
                    _storageThroughput = getwparent(item, oxr, "storageThroughput", False)
                    if _storageType == "gp3" and _storageThroughput:
                        "storageThroughput": getwparent(item, oxr, "spec.storageThroughput", 0)

                    "storageType": _storageType

                    "vpcSecurityGroupIds": [
                        get(oxr, "status.securityGroupId", "")
                        for _ in [True]
                        if get(oxr, "status.securityGroupId", False)
                    ],

                    # You cannot have read replicas with manage master user password
                    #
                    # This means that in the longer term, this will be removed as an option
                    # and instead, the password will be pushed to secretsmanager via ESO
                    _managedMasterUserPassword = False # get(item, "manageMasterUserPassword", get(oxr, "spec.manageMasterUserPassword", True)),
                    _autoGeneratePassword = getwparent(item, oxr, "autoGeneratePassword", True)

                    # If this is the primary (non-cluster) instance, set
                    # the database name and master user password. Additionally,
                    # if s3Import has been defined, this is configured here.
                    if _isPrimaryInstance:
                        if _autoGeneratePassword and not _managedMasterUserPassword:
                            "autoGeneratePassword": _autoGeneratePassword,
                            "passwordSecretRef": {
                                "key": "password",
                                "namespace": namespace,
                                "name": "${appName}-${region}-rds-autogen-pass",
                            }

                        "allocatedStorage": getwparent(item, oxr, "allocatedStorage", 20)

                        _dbName = getwparent(item, oxr, "databaseName", False)
                        if _dbName:
                            "dbName": _dbName,
                        if _managedMasterUserPassword:
                            "manageMasterUserPassword": _managedMasterUserPassword,
                            # masterUserSecretKmsKeyId: _keyId,
                        "username": get(item, "username", get(oxr, "spec.masterUsername", "")),

                        if s3import:
                            "s3import": s3import,

                    # If this is not the primary (non-cluster) instance, the
                    # replication source
                    if all_true([
                        not _isPrimaryInstance,
                        masterInstance,
                        masterInstanceIdentifier,
                    ]):
                        "replicateSourceDb": masterInstanceIdentifier if not _isCrossRegion else masterInstanceArn,
                    if _dbp:
                        "parameterGroupName": _dbp

                "applyImmediately": getwparent(item, oxr, "applyImmediately", True)
                "autoMinorVersionUpgrade": getwparent(item, oxr, "autoMinorVersionUpgrade", True)

                # This needs verifying for postgres - it previously worked
                # when building posgtres instances
                if _isPrimaryInstance:
                    "dbSubnetGroupName": dbSubnetGroupName,

                "engine": engine,
                if any_true([
                    not getwparent(item, oxr, "allowMajorVersionUpgrade" True)
                    not getwparent(item, oxr, "autoMinorVersionUpgrade", True)
                ]):
                    "engineVersion": getwparent(item, oxr, "engineVersion", "14.0"),

                # cannot use getwparent here as the parameter names differ
                "instanceClass": get(item, "instanceClass", get(oxr, "spec.dbClusterInstanceClass", "db.t3.medium")),
                "monitoringInterval": get(item, "monitoringInterval", get(oxr, "spec.enhancedMonitoring.monitoringInterval", 0)),

                if monitoringRoleArn:
                    "monitoringRoleArn": monitoringRoleArn,

                _v = getwparent(item, oxr, "performanceInsightsEnabled" False)
                if _v:
                    "performanceInsightsEnabled": _v
                    "performanceInsightsKmsKeyId": getwparent(item, oxr, "performanceInsightsKmsKeyId", keyId)
                    "performanceInsightsRetentionPeriod": getwparent(item, oxr, "performanceInsightsRetentionPeriod", 7)

                # Only set the availability zone if this is a cluster instance
                # or if the instance is not multi-AZ and an availability zone is
                # provided
                if (createCluster or _instanceUseAz) and _az:
                    "availabilityZone": _az,

                if _cacert:
                    "caCertIdentifier": _cacert

                if createCluster:
                    "clusterIdentifier": clusterId,
                    if _pt:
                        "promotionTier": _pt,
                    if _dbp:
                        "dbParameterGroupName": _dbp,

                "copyTagsToSnapshot": getwparent(item, oxr, "copyTagsToSnapshot", True)
                "publiclyAccessible": getwparent(item, oxr, "publiclyAccessible", False)
                "region": region,
                "tags": tags | {
                    "Name": _name
                },
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
            if not createCluster and _isPrimaryInstance:
                "writeConnectionSecretToRef": {
                    "namespace": get(oxr, "spec.claimRef.namespace", "default")
                    "name": "${appName}-${region}-rds",
                }
        }
    }
    for i, item in buildInstances if all_true([
        any_true([
            (createCluster and clusterId != None),
            not createCluster,
        ]),
        keyId, dbSubnetGroupName
    ])
]

_secretRef = False
if all_true([
    not createCluster,
    ready("instance-0"),
]):
    _secretRef = ocdsspec("instance-0", "writeConnectionSecretToRef", "")

##
# OptionGroups may be specified for non-cluster, non-postgresql instances.
# postgresql isntances do not use optiongroups but instead uses extensions.
optionGroup = [
    {
        "apiVersion": "rds.aws.upbound.io/v1beta1"
        "kind": "OptionGroup"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "option-group"
                "krm.kcl.dev/ready" = readystr("option-group")
                "crossplane.io/external-name" = get(oxr, "spec.optionGroup.name", "")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "engineName": engine,
                "majorEngineVersion": get(oxr, "spec.engineVersion", "14.0"),
                "option": [
                    {
                        if get(item, "dbSecurityGroupMemberships", False):
                            "dbSecurityGroupMemberships": get(item, "dbSecurityGroupMemberships", []),
                        "optionName": get(item, "optionName", ""),
                        "optionSettings": [
                            {
                                "name": key,
                                "value": value,
                            }
                            for key, value in get(item, "optionSettings", [])
                        ],
                    }
                    for i, item in get(oxr, "spec.optionGroup.options", {})
                ],

                "region": region,
                if get(oxr, "spec.optionGroup.version", False):
                    "version": get(oxr, "spec.optionGroup.version", ""),

                "optionGroupDescription": get(oxr, "spec.optionGroup.description", "${appName} Option group"),

                "tags": tags | {
                    "Name": "${appName}-option-group"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if not createCluster and get(oxr, "spec.optionGroup.create", False) else {}
]

endpoints = [
    {
        "apiVersion": "rds.aws.upbound.io/v1beta1"
        "kind": "ClusterEndpoint"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "endpoint-${i}"
                "krm.kcl.dev/ready" = readystr("endpoint-${i}")
                "crossplane.io/external-name" = "${appName}-${region}-${i}"
            }
            "labels": labels
        }

        spec: {
            "deletionPolicy": dp
            "forProvider": {
                "clusterEndpointIdentifier": get(item, "clusterEndpointIdentifier", None),
                "clusterIdentifier": clusterId,
                "customEndpointType": get(item, "type", "ANY"),
                "excludeMembers": get(item, "excludeMembers", []),
                "staticMembers": get(item, "staticMembers", []),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}-${i}"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, item in get(oxr, "spec.endpoints", []) if all_true([
        createCluster, clusterId != None
    ])
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
iam_roles = [
    {
        "apiVersion": "rds.aws.upbound.io/v1beta1"
        "kind": "ClusterRoleAssociation" if createCluster else "InstanceRoleAssociation"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "iam-role-${i}"
                "krm.kcl.dev/ready" = readystr("iam-role-${i}")
                "crossplane.io/external-name" = "${appName}-${region}-${i}"
            }
            "labels": labels
        }

        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                if createCluster:
                    "dbClusterIdentifier": clusterId,
                else:
                    _v = ocdsstatus("instance-0", "id", False)
                    if _v:
                        "dbInstanceIdentifier": _v
                "featureName": get(item, "featureName", "s3Import"),
                "roleArn": get(item, "roleArn", ""),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-${region}-${i}"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, item in get(oxr, "spec.iamRoles", [])
]

createMonitoringRole = all_true([
    get(oxr, "spec.enhancedMonitoring.enabled", False),
    get(oxr, "spec.enhancedMonitoring.monitoringInterval", 0) > 0,
])

monitoringRole = [
    {
        "apiVersion": "iam.aws.upbound.io/v1beta1"
        "kind": "Role"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "enhanced-monitoring-role"
                "krm.kcl.dev/ready" = readystr("enhanced-monitoring-role")
                "crossplane.io/external-name" = appName
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "assumeRolePolicy": json.encode({
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Principal": {
                                "Service": "monitoring.rds.amazonaws.com"
                            },
                            "Action": "sts:AssumeRole"
                        }
                    ]
                }, ignore_private=True),

                "description": get(oxr, "spec.enhancedMonitoring.description", "Role for RDS monitoring"),
                "managedPolicyArns": get(oxr, "spec.enhancedMonitoring.managedPolicyArns", None),
                "permissionsBoundary": get(oxr, "spec.enhancedMonitoring.permissionsBoundary", None),
                "forceDetachPolicies": get(oxr, "spec.enhancedMonitoring.forceDetachPolicies", False),
                "maxSessionDuration": get(oxr, "spec.enhancedMonitoring.maxSessionDuration", None),
                "path": get(oxr, "spec.enhancedMonitoring.path", "/"),
                "name": "rds-monitoring-role",
                "tags": tags | get(oxr, "spec.enhancedMonitoring.tags", {}) | {
                    "Name": "${appName}-monitoring-role"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if createMonitoringRole else {}
] + [
    {
        "apiVersion": "iam.aws.upbound.io/v1beta1"
        "kind": "RolePolicyAttachment"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "monitoring-role-attachment"
                "krm.kcl.dev/ready" = readystr("monitoring-role-attachment")
                "crossplane.io/external-name" = appName
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "policyArn": "arn:${partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole",
                "role": "rds-monitoring-role",
                "tags": tags | {
                    "Name": "${appName}-monitoring-role-attachment"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if createMonitoringRole else {}
]

instanceCreated = ocdsstatus("instance-0", "id", False) and createCluster

# Define autoscaling if this is the required scaling mode for RDS Cluster builds
autoscalingTarget = [
    {
        "apiVersion": "appautoscaling.aws.upbound.io/v1beta1"
        "kind": "Target"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "autoscaling-target"
                "krm.kcl.dev/ready" = readystr("autoscaling-target")
                "crossplane.io/external-name" = "${appName}-autoscaling"
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "maxCapacity": get(oxr, "spec.autoscaling.maxCapacity", 2),
                "minCapacity": get(oxr, "spec.autoscaling.minCapacity", 2),
                "resourceId": "cluster:${clusterId}",
                "region": region,
                "scalableDimension": "rds:cluster:ReadReplicaCount",
                "serviceNamespace": "rds",
                "tags": tags | get(oxr, "spec.autoscaling.tags", {}) | {
                    "Name": "${appName}-autoscaling"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if all_true([
        instanceCreated,
        get(oxr, "spec.autoscaling.enabled", False),
        createCluster,
     ]) else {}
]

_metricTypes = {
    "RDSReaderAverageCPUUtilization": get(oxr, "spec.autoscaling.targetCPU", 70),
    "RDSReaderAverageDatabaseConnections": get(oxr, "spec.autoscaling.targetConnections", 700),
}

tc = get(oxr, "spec.autoscaling.metricType", "RDSReaderAverageCPUUtilization")
tv =  _metricTypes[tc]

autoscalingTargetCreated = ocdsstatus("autoscaling-target", "id", False)

autoscalingPolicy = [
    {
        "apiVersion": "appautoscaling.aws.upbound.io/v1beta1"
        "kind": "Policy"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "autoscaling-policy"
                "krm.kcl.dev/ready" = readystr("autoscaling-policy")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "policyType": "TargetTrackingScaling",
                "resourceId": "cluster:${clusterId}",
                "scalableDimension": "rds:cluster:ReadReplicaCount",
                "serviceNamespace": "rds",
                "targetTrackingScalingPolicyConfiguration": [
                    {
                        "predefinedMetricSpecification": [
                            {
                                "predefinedMetricType": tc,
                            },
                        ],
                        "disableScaleIn": get(oxr, "spec.autoscaling.disableScaleIn", False),
                        "scaleInCooldown": get(oxr, "spec.autoscaling.scaleInCooldown", 60),
                        "scaleOutCooldown": get(oxr, "spec.autoscaling.scaleOutCooldown", 60),
                        "targetValue": tv
                    },
                ],
                "region": region,
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if all_true([
        autoscalingTargetCreated,
        get(oxr, "spec.autoscaling.enabled", False),
        createCluster,
     ]) else {}
]

autoscaling = autoscalingTarget + autoscalingPolicy

optionGroupPort = get(oxr, "spec.optionGroup.port", False)

# Create security group rules for the cluster
securityGroupRules = [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "SecurityGroupRule"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "security-group-rule-${i}"
                "krn.kcl.dev/ready" = readystr("security-group-rule-${i}")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "securityGroupId": get(oxr, "status.securityGroupId", ""),
                "cidrBlocks": [cidr],
                "fromPort": port,
                "protocol": "tcp",
                "region": region,
                "toPort": port,
                "type": "ingress",
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, cidr in get(oxr, "spec.cidrBlocks", []) if all_true([
        port, cidr,
        get(oxr, "status.securityGroupId", False),
    ])
] + [
    {
        "apiVersion": "ec2.aws.upbound.io/v1beta1"
        "kind": "SecurityGroupRule"
        "metadata": {
            "annotations": {
                _cm = regex.replace(cidr, "[^0-9]", "")
                _resourceName = "security-group-rule-${_cm}"
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krn.kcl.dev/ready" = readystr(_resourceName)
                "crossplane.io/external-name" = "${appName}-sgr-${_cm}"
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "securityGroupId": get(oxr, "status.securityGroupId", ""),
                "cidrBlocks": [cidr],
                "fromPort": optionGroupPort,
                "protocol": "tcp",
                "region": region,
                "toPort": optionGroupPort,
                type: "ingress",
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, cidr in get(oxr, "spec.cidrBlocks", []) if all_true([
        get(oxr, "spec.optionGroup.enabled", False),
        get(oxr, "status.securityGroupId", False),
        optionGroupPort, port,
        optionGroupPort != port,
        cidr
    ])
]

# If the cluster parameter group is requested and we're creating a cluster
clusterParameterGroup = [
    {
        "apiVersion": "rds.aws.upbound.io/v1beta1"
        "kind": "ClusterParameterGroup"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "cluster-parameter-group"
                "krm.kcl.dev/ready" = readystr("cluster-parameter-group")
                "crossplane.io/external-name" = get(oxr, "spec.dbClusterParameterGroup.name", "")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "description": get(oxr, "spec.parameterGroup.description", "Cluster parameter group"),
                "family": get(oxr, "spec.parameterGroup.family", "aurora-postgresql11"),
                "parameter": get(oxr, "spec.parameterGroup.parameters", {}),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-cluster-parameter-group"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if get(oxr, "spec.dbClusterParameterGroup.create", False) and createCluster else {}
]

# If the db parameter group is requested create it
dbParameterGroup = [
    {
        "apiVersion": "rds.aws.upbound.io/v1beta1"
        "kind": "ParameterGroup"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "db-parameter-group"
                "krm.kcl.dev/ready" = readystr("db-parameter-group")
                "crossplane.io/external-name" = get(oxr, "spec.dbParameterGroup.name", "")
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": get(oxr, "spec.deletionPolicy", "Delete"),
            "forProvider": {
                "description": get(oxr, "spec.parameterGroup.description", "DB parameter group"),
                "family": get(oxr, "spec.parameterGroup.family", "aurora-postgresql11"),
                "parameter": get(oxr, "spec.parameterGroup.parameters", {}),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-db-parameter-group"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if get(oxr, "spec.dbParameterGroup.create", False) else {}
]

# Cloudwatch log groups
logGroups = get(oxr, "spec.enabledCloudwatchLogsExports", [])
lgEnabled = get(oxr, "spec.cloudwatchLogGroupParameters.create", False) and len(logGroups) > 0
cloudwatchLogGroups = [
    {
        "apiVersion": "cloudwatchlogs.aws.upbound.io/v1beta1"
        "kind": "Group"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "log-group-${i}"
                "krm.kcl.dev/ready" = readystr("log-group-${i}")
                "crossplane.io/external-name" = "/aws/rds/cluster/${clusterId}/${item}"
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp,
            "forProvider": {
                "logGroupClass": get(item, "cloudwatchLogGroupParameters.class", "Standard"),
                "retentionInDays": get(item, "cloudwatchLogGroupParameters.retentionInDays", 0),
                "kmsKeyId": keyId,
                "skipDestroy": get(item, "cloudwatchLogGroupParameters.skipDestroy", False),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-log-group-${i}"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for i, item in logGroups if lgEnabled and keyId
]

# If we're creating a cluster and the activity stream is enabled, create it
clusterActivityStream = [
    {
        "apiVersion": "rds.aws.upbound.io/v1beta1"
        "kind": "ClusterActivityStream"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "activity-stream"
                "krm.kcl.dev/ready" = readystr("activity-stream")
                "crossplane.io/external-name" = appName
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "applyImmediately": get(oxr, "spec.activityStream.applyImmediately", True),
                "enabled": get(oxr, "spec.activityStream.enabled", False),
                "kmsKeyId": get(oxr, "status.kmsKeyId", None),
                "mode": get(oxr, "spec.activityStream.mode", "sync"),
                "region": region,
                "tags": tags | {
                    "Name": "${appName}-activity-stream"
                }
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if get(oxr, "spec.activityStream.enabled", False) and createCluster else {}
]

# If secret rotation is enabled, create the secret rotation resource
secretRotation = [
    {
        "apiVersion": "secretsmanager.aws.upbound.io/v1beta1"
        "kind": "SecretRotation"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "secret-rotation"
                "krm.kcl.dev/ready" = readystr("secret-rotation")
                "crossplane.io/external-name" = appName
            }
            "labels": labels
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "secretId": get(oxr, "status.secretId", ""),
                "region": region,
                "rotateImmediately": get(oxr, "spec.secretRotation.rotateImmediately", False),
                "rotationRules": [
                    {
                        "duration": get(oxr, "spec.secretRotation.duration", 0),
                    } | {
                        "automaticallyAfterDays": get(oxr, "spec.secretRotation.afterDays", 30),
                    } if get(oxr, "spec.secretRotation.afterDays", False) != False else {
                        "scheduleExpression": get(oxr, "spec.secretRotation.scheduleExpression", "")
                    }
                ],
            }
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    } if get(oxr, "spec.secretRotation.enabled", False) else {}
]

# Merge all resources into a single flat list
_items = [
    i for r in [
        instances, endpoints, iam_roles, monitoringRole,
        autoscaling, securityGroupRules, clusterParameterGroup,
        dbParameterGroup, cloudwatchLogGroups, clusterActivityStream,
        secretRotation,
    ]
    for i in r if i
]