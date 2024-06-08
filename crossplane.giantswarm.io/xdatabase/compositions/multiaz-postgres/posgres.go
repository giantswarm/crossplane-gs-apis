package main

import (
	xpt "github.com/crossplane-contrib/function-patch-and-transform/input/v1beta1"
	cb "github.com/mproffitt/crossbuilder/pkg/generate/utils"
	rdsv1beta1 "github.com/upbound/provider-aws/apis/rds/v1beta1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
)

func createClusterResource() xpt.ComposedTemplate {
	return xpt.ComposedTemplate{
		Name: "rds-cluster",
		Base: &runtime.RawExtension{
			Object: &rdsv1beta1.Cluster{
				TypeMeta: metav1.TypeMeta{
					APIVersion: "rds.aws.upbound.io/v1beta1",
					Kind:       "Cluster",
				},
				Spec: rdsv1beta1.ClusterSpec{
					ForProvider: rdsv1beta1.ClusterParameters{
						CopyTagsToSnapshot:       cb.BoolPtr(true),
						ManageMasterUserPassword: cb.BoolPtr(true),
						NetworkType:              cb.StrPtr("IPV4"),
						SkipFinalSnapshot:        cb.BoolPtr(true),
						StorageEncrypted:         cb.BoolPtr(true),
					},
					InitProvider: rdsv1beta1.ClusterInitParameters{},
				},
			},
		},
		Patches: []xpt.ComposedPatch{
			cb.FromPatch("spec.allocatedStorage", "spec.forProvider.allocatedStorage"),
			cb.FromPatch("spec.allowMajorVersionUpgrade", "spec.forProvider.allowMajorVersionUpgrade"),
			cb.FromPatch("spec.applyImmediately", "spec.forProvider.applyImmediately"),
			cb.FromPatch("spec.backupRetentionPeriod", "spec.forProvider.backupRetentionPeriod"),
			cb.FromPatch("spec.backtrackWindow", "spec.forProvider.backtrackWindow"),
			cb.FromPatch("spec.clusterMembers", "spec.forProvider.clusterMembers"),
			cb.FromPatch("spec.dbClusterInstanceClass", "spec.forProvider.dbClusterInstanceClass"),
			cb.FromPatch("spec.dbClusterParameterGroup.name", "spec.forProvider.dbClusterParameterGroupName"),
			cb.FromPatch("spec.dbInstanceParameterGroupName", "spec.forProvider.dbInstanceParameterGroupName"),
			cb.FromPatch("spec.dbSubnetGroupName", "spec.forProvider.dbSubnetGroupName"),
			cb.FromPatch("spec.deleteAutomatedBackups", "spec.forProvider.deleteAutomatedBackups"),
			cb.FromPatch("spec.deletionProtection", "spec.forProvider.deletionProtection"),
			cb.FromPatch("spec.domain", "spec.forProvider.domain"),
			cb.FromPatch("spec.domainIAMRoleName", "spec.forProvider.domainIAMRoleName"),
			cb.FromPatch("spec.enableHttpEndpoint", "spec.forProvider.enableHttpEndpoint"),
			cb.FromPatch("spec.enableGlobalWriteForwarding", "spec.forProvider.enableGlobalWriteForwarding"),
			cb.FromPatch("spec.enableLocalWriteForwarding", "spec.forProvider.enableLocalWriteForwarding"),
			cb.FromPatch("spec.enabledCloudwatchLogsExports", "spec.forProvider.enabledCloudwatchLogsExports"),
			cb.FromPatch("spec.engine", "spec.forProvider.engine"),
			cb.FromPatch("spec.engineMode", "spec.forProvider.engineMode"),
			cb.FromPatch("spec.claimRef.name", "spec.forProvider.finalSnapshotIdentifier"),
			cb.FromPatch("spec.globalClusterIdentifier", "spec.forProvider.globalClusterIdentifier"),
			cb.FromPatch("spec.iamDatabaseAuthenticationEnabled", "spec.forProvider.iamDatabaseAuthenticationEnabled"),
			cb.FromPatch("spec.iops", "spec.forProvider.iops"),
			cb.FromPatch("status.kmsKeyID", "spec.forProvider.kmsKeyID"),
			cb.FromPatch("spec.masterUsername", "spec.forProvider.masterUsername"),
			cb.FromPatch("spec.preferredBackupWindow", "spec.forProvider.preferredBackupWindow"),
			cb.FromPatch("spec.preferredMaintenanceWindow", "spec.forProvider.preferredMaintenanceWindow"),
			cb.FromPatch("spec.region", "spec.forProvider.region"),
			cb.FromPatch(("status.vpcSecurityGroupIDs"), "spec.forProvider.vpcSecurityGroupIDs"),

			// Init provider settings
			cb.FromPatch("spec.engineVersion", "spec.initProvider.engineVersion"),
			cb.FromPatch("spec.globalClusterIdentifier", "spec.initProvider.globalClusterIdentifier"),
			cb.FromPatch("spec.replicationSourceIdentifier", "spec.initProvider.replicationSourceIdentifier"),

			// PatchSets
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("commontags"),
			},
			{
				Type:         xpt.PatchTypePatchSet,
				PatchSetName: cb.StrPtr("metadata"),
			},

			combineNameRegionPatch("spec.forProvider.tags.Name", ""),
			cb.FromPatch("spec.claimRef.name", "spec.forProvider.tags.Name"),
			cb.FromPatchMergeObjects("spec.tags.rds", "spec.forProvider.tags"),
			cb.FromPatchMergeObjects("spec.tags.common", "spec.forProvider.tags"),
			combineNameRegionPatch("spec.writeConnectionSecretToRef.name", "-rds"),
			cb.FromPatch("spec.claimRef.namespace", "spec.writeConnectionSecretToRef.namespace"),

			cb.ToPatch("status.clusterIdentifier", "status.atProvider.clusterIdentifier"),
			cb.ToPatch("status.clusterArn", "status.atProvider.arn"),
			cb.ToPatch("status.endpoint", "status.atProvider.endpoint"),
			cb.ToPatch("status.port", "status.atProvider.port"),

			// The following will come from KCL
			//
			// - restorePointInTime
			// - s3Import
			// - scalingConfiguration
			// - serverlessv2ScalingConfiguration
		},
	}
}
