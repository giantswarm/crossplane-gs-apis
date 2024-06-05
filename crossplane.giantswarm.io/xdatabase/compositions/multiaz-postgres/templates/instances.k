_oxr = option("params").oxr

[
    {
        apiVersion: "rds.aws.upbound.io/v1beta1"
        kind: "ClusterInstance"
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "instance-${i}"
            }
            labels: {

            }
        }
        spec: {
            forProvider: {
                applyImmediately: item.applyImmediately if item.applyImmediately != None else _oxr.applyImmediately,
                autoMinorVersionUpgrade: item.autoMinorVersionUpgrade if item.autoMinorVersionUpgrade != None else _oxr.autoMinorVersionUpgrade,
                availabilityZone: item.availabilityZone,
                copyTagsToSnapshot: item.copyTagsToSnapshot if item.copyTagsToSnapshot != None else _oxr.copyTagsToSnapshot,
                dbParameterGroupName: item.dbParameterGroupName if item.dbParameterGroupName != None else _oxr.dbParameterGroupName,
                instanceClass: item.instanceClass if item.instanceClass != None else _oxr.instanceClass,
                monitoringInterval: item.monitoringInterval if item.monitoringInterval != None else _oxr.monitoringInterval,
                monitoringRoleArn: item.monitoringRoleArn if item.monitoringRoleArn != None else _oxr.monitoringRoleArn,
                multiAz: item.multiAz if item.multiAz != None else _oxr.multiAz,
                performanceInsightsEnabled: item.performanceInsightsEnabled if item.performanceInsightsEnabled != None else _oxr.performanceInsightsEnabled,
                performanceInsightsKmsKeyId: item.performanceInsightsKmsKeyId if item.performanceInsightsKmsKeyId != None else _oxr.performanceInsightsKmsKeyId,
                performanceInsightsRetentionPeriod: item.performanceInsightsRetentionPeriod if item.performanceInsightsRetentionPeriod != None else _oxr.performanceInsightsRetentionPeriod,
                publiclyAccessible: item.publiclyAccessible if item.publiclyAccessible != None else _oxr.publiclyAccessible,
                storageEncrypted: item.storageEncrypted if item.storageEncrypted != None else _oxr.storageEncrypted,
                dbSubnetGroupName: item.dbSubnetGroupName if item.dbSubnetGroupName != None else _oxr.dbSubnetGroupName,
                engine: item.engine if item.engine != None else _oxr.engine,
                engineVersion: item.engineVersion if item.engineVersion != None else _oxr.engineVersion,
                caCertIdentifier: item.caCertIdentifier if item.caCertIdentifier != None else _oxr.caCertIdentifier,
                clusterIdentifier: item.clusterIdentifier if item.clusterIdentifier != None else _oxr.clusterIdentifier,
                monitoringRoleArn: item.monitoringRoleArn if item.monitoringRoleArn != None else _oxr.monitoringRoleArn,
                preferredMaintenanceWindow: item.preferredMaintenanceWindow if item.preferredMaintenanceWindow != None else _oxr.preferredMaintenanceWindow,
                promotionTier: item.promotionTier if item.promotionTier != None else _oxr.promotionTier,
            }
        }
    }
    for i, item in _oxr.spec.instances
]1