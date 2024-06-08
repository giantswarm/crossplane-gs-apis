import regex
import json

_oxr = option("params").oxr
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

_clusterIdentifier = get(_oxr, "status.clusterIdentifier", None)
_monitoringRoleArn = get(_oxr, "status.monitoringRoleArn", None)
_dbSubnetGroupName = get(_oxr, "status.dbSubnetGroupName", None)
_region = get(_oxr, "spec.region", "eu-central-1")

_accountId = get(_oxr, "status.accountId", "")
_labels = {}
_tags = {}

_ipgn = get(_oxr, "spec.dbParameterGroup.name", "") if get(_oxr, "spec.allowMajorVersionUpgrade", False) else ""

_cluster = _dcds["rds-cluster"].Resource | {
    spec = {
        forProvider = {
            dbInstanceParameterGroupName = _ipgn,
        }
    }
}

_instances = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ClusterInstance"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "instance-${i}"
            }
            labels: _labels
        }

        spec: {
            forProvider: {
                applyImmediately: get(item, "spec.applyImmediately", get(_oxr, "spec.applyImmediately", True)),
                autoMinorVersionUpgrade: get(item, "spec.autoMinorVersionUpgrade", get(_oxr, "spec.autoMinorVersionUpgrade", True)),
                availabilityZone: get(item, "spec.availabilityZone", None),
                caCertIdentifier: get(_oxr, "status.caCertIdentifier", None),
                clusterIdentifier: _clusterIdentifier,
                copyTagsToSnapshot: get(item, "spec.copyTagsToSnapshot", get(_oxr, "spec.copyTagsToSnapshot", True)),
                dbParameterGroupName: get(item, "spec.parameterGroupName", get(_oxr, "spec.parameterGroup.name", "")),
                dbSubnetGroupName: _dbSubnetGroupName,
                engine: get(_oxr, "spec.engine", "postgres"),
                engineVersion: get(_oxr, "spec.engineVersion", "14.0"),
                instanceClass: get(item, "spec.instanceClass", get(_oxr, "spec.instanceClass", "db.t3.medium")),
                monitoringInterval: get(item, "spec.monitoringInterval", get(_oxr, "spec.enhancedMonitoring.monitoringInterval", 0)),
                monitoringRoleArn: _monitoringRoleArn,
                multiAz: get(item, "spec.multiAz", get(_oxr, "spec.multiAz", False)),
                performanceInsightsEnabled: get(item, "spec.performanceInsightsEnabled", get(_oxr, "spec.performanceInsightsEnabled", False)),
                performanceInsightsKmsKeyId: get(item, "spec.performanceInsightsKmsKeyId", get(_oxr, "spec.performanceInsightsKmsKeyId", None)),
                performanceInsightsRetentionPeriod: get(item, "spec.performanceInsightsRetentionPeriod", get(_oxr, "spec.performanceInsightsRetentionPeriod", 7)),
                preferredMaintenanceWindow: get(item, "spec.preferredMaintenanceWindow", get(_oxr, "spec.preferredMaintenanceWindow", "sun:05:00-sun:06:00")),
                promotionTier: get(item, "spec.promotionTier", None),
                publiclyAccessible: get(item, "spec.publiclyAccessible", get(_oxr, "spec.publiclyAccessible", False)),
                region: _region,
                tags: _tags | get(item, "spec.tags", {}),
            }
        }
    }
    for i, item in get(_oxr, "spec.instances", []) if _clusterIdentifier != None
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
            forProvider: {
                clusterEndpointIdentifier: get(item, "spec.clusterEndpointIdentifier", None),
                clusterIdentifier: _clusterIdentifier,
                customEndpointType: get(item, "spec.type", "ANY"),
                excludeMembers: get(item, "spec.excludeMembers", []),
                staticMembers: get(item, "spec.staticMembers", []),
                region: _region,
                tags: _tags | get(item, "spec.tags", {})
            }
        }
    }
    for i, item in get(_oxr, "spec.endpoints", []) if _clusterIdentifier != None
]

_iam_roles = [
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ClusterRoleAssociation"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "iam-role-${i}"
            }
            labels: _labels
        }

        spec: {
            forProvider: {
                dbClusterIdentifier: _clusterIdentifier,
                featureName: get(item, "spec.featureName", "s3Import"),
                roleArn: get(item, "spec.roleArn", ""),
                region: _region,
                tags: _tags
            }
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
                tags: _tags
            }
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
            forProvider: {
                policyArn: "arn:${_accountId}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole",
                role: "rds-monitoring-role",
                tags: _tags
            }
        }
    } if _createMonitoringRole else {}
]

_autoscalingTarget = [
    {
        apiVersion: "appautoscaling.aws.upbound.io/v1beta1"
        kind: "Target"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "autoscaling"
            }
            labels: _labels
        }
        spec: {
            forProvider: {
                clusterIdentifier: _clusterIdentifier,
                enabled: get(_oxr, "spec.autoscaling.enabled", False),
                maxCapacity: get(_oxr, "spec.autoscaling.maxCapacity", 2),
                minCapacity: get(_oxr, "spec.autoscaling.minCapacity", 2),
                resourceId: "cluster:${_clusterIdentifier}",
                region: _region,
                scalableDimension: "rds:cluster:ReadReplicaCount",
                serviceNamespace: "rds",
            }

            initProvider: {
                tags: _tags
            }
        }
    } if _clusterIdentifier != None and get(_oxr, "spec.autoscaling.enabled", False) else {}
]

_tc = get(_oxr, "spec.autoscaling.metricType", "RDSReaderAverageCPUUtilization")
_tv = get(_oxr, "spec.autoscaling.targetCPU", 70) if _tc == "RDSReaderAverageCPUUtilization" else get(_oxr, "spec.autoscaling.targetConnections", 700)

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
            forProvider: {
                policyName: get(_oxr, "spec.autoscaling.policyName", "rds-autoscaling-policy"),
                policyType: "TargetTrackingScaling",
                resourceId: "cluster:${_clusterIdentifier}",
                scalableDimension: "rds:cluster:ReadReplicaCount",
                serviceNamespace: "rds",
                targetTrackingScalingPolicyConfiguration: {
                    predefinedMetricSpecification: {
                        predefinedMetricType: _tc
                    },
                    disableScaleIn: get(_oxr, "spec.autoscaling.disableScaleIn", False),
                    scaleInCooldown: get(_oxr, "spec.autoscaling.scaleInCooldown", 60),
                    scaleOutCooldown: get(_oxr, "spec.autoscaling.scaleOutCooldown", 60),
                    targetValue: _tv
                },
                region: _region,
            }
        }
    } if _clusterIdentifier != None and get(_oxr, "spec.autoscaling.enabled", False) else {}
]

_autoscaling = _autoscalingTarget + _autoscalingPolicy

_engine = get(_oxr, "spec.engine", "postgres")
_port = get(_oxr, "status.port", 5432 if _engine in ["aurora-postgres", "postgres"] else 3306)
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
            forProvider: {
                securityGroupId: get(_oxr, "status.securityGroupId", ""),
                cidrBlocks: cidr,
                fromPort: _port,
                toPort: _port,
                protocol: "tcp",
                region: _region,
            }
        }
    }
    for i, cidr in get(_oxr, "spec.cidrBlocks", [])
]

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
            forProvider: {
                description: get(_oxr, "spec.parameterGroup.description", "Cluster parameter group"),
                family: get(_oxr, "spec.parameterGroup.family", "aurora-postgresql11"),
                parameter: get(_oxr, "spec.parameterGroup.parameters", {}),
                region: _region,
                tags: _tags
            }
        }
    } if get(_oxr, "spec.dbClusterParameterGroup.create", False) else {}
]

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
            forProvider: {
                description: get(_oxr, "spec.parameterGroup.description", "DB parameter group"),
                family: get(_oxr, "spec.parameterGroup.family", "aurora-postgresql11"),
                parameter: get(_oxr, "spec.parameterGroup.parameters", {}),
                region: _region,
                tags: _tags
            }
        }
    } if get(_oxr, "spec.dbParameterGroup.create", False) else {}
]

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
            forProvider: {
                logGroupClass: get(item, "spec.cloudwatchLogGroupParameters.class", "Standard"),
                retentionInDays: get(item, "spec.cloudwatchLogGroupParameters.retentionInDays", 0),
                kmsKeyId: get(_oxr, "status.kmsKeyId", None),
                skipDestroy: get(item, "spec.cloudwatchLogGroupParameters.skipDestroy", False),
                tags: _tags | get(item, "spec.tags", {})
            }
        }
    }
    for i, item in _logGroups if _lgEnabled
]

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
            forProvider: {
                applyImmediately: get(_oxr, "spec.activityStream.applyImmediately", True),
                enabled: get(_oxr, "spec.activityStream.enabled", False),
                kmsKeyId: get(_oxr, "status.kmsKeyId", None),
                mode: get(_oxr, "spec.activityStream.mode", "sync"),
                region: _region,
                tags: _tags
            }
        }
    }
]

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
            forProvider: {
                secretId: get(_oxr, "status.secretId", ""),
                rotateImmediately: get(_oxr, "spec.secretRotation.rotateImmediately", False),
                rotationRules: {
                    duration: get(_oxr, "spec.secretRotation.duration", 0),
                } | {
                    automaticallyAfterDays: get(_oxr, "spec.secretRotation.afterDays", 30),
                } if get(_oxr, "spec.secretRotation.afterDays", False) != False else {
                    scheduleExpression: get(_oxr, "spec.secretRotation.scheduleExpression", "")
                },
            }
        }
    }
]

_items = [
    _cluster, _instances, _endpoints, _iam_roles, _monitoringRole,
    _autoscaling, _securityGroupRules, _clusterParameterGroup,
    _dbParameterGroup, _cloudwatchLogGroups, _clusterActivityStream,
    _secretRotation,
]

items = [i for x in _items for i in x if i]