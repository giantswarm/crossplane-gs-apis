//go:build !ignore_autogenerated

// Code generated by controller-gen. DO NOT EDIT.

package v1alpha1

import (
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ActivityStream) DeepCopyInto(out *ActivityStream) {
	*out = *in
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.EngineNativeAuditFieldsIncluded != nil {
		in, out := &in.EngineNativeAuditFieldsIncluded, &out.EngineNativeAuditFieldsIncluded
		*out = new(bool)
		**out = **in
	}
	if in.Mode != nil {
		in, out := &in.Mode, &out.Mode
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ActivityStream.
func (in *ActivityStream) DeepCopy() *ActivityStream {
	if in == nil {
		return nil
	}
	out := new(ActivityStream)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Autoscaling) DeepCopyInto(out *Autoscaling) {
	*out = *in
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.MaxCapacity != nil {
		in, out := &in.MaxCapacity, &out.MaxCapacity
		*out = new(int64)
		**out = **in
	}
	if in.MinCapacity != nil {
		in, out := &in.MinCapacity, &out.MinCapacity
		*out = new(int64)
		**out = **in
	}
	if in.MetricType != nil {
		in, out := &in.MetricType, &out.MetricType
		*out = new(string)
		**out = **in
	}
	if in.PolicyName != nil {
		in, out := &in.PolicyName, &out.PolicyName
		*out = new(string)
		**out = **in
	}
	if in.ScaleInCooldown != nil {
		in, out := &in.ScaleInCooldown, &out.ScaleInCooldown
		*out = new(int64)
		**out = **in
	}
	if in.ScaleOutCooldown != nil {
		in, out := &in.ScaleOutCooldown, &out.ScaleOutCooldown
		*out = new(int64)
		**out = **in
	}
	if in.TargetCPU != nil {
		in, out := &in.TargetCPU, &out.TargetCPU
		*out = new(int64)
		**out = **in
	}
	if in.TargetConnections != nil {
		in, out := &in.TargetConnections, &out.TargetConnections
		*out = new(int64)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Autoscaling.
func (in *Autoscaling) DeepCopy() *Autoscaling {
	if in == nil {
		return nil
	}
	out := new(Autoscaling)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *CloudwatchLogGroup) DeepCopyInto(out *CloudwatchLogGroup) {
	*out = *in
	if in.Class != nil {
		in, out := &in.Class, &out.Class
		*out = new(string)
		**out = **in
	}
	if in.Create != nil {
		in, out := &in.Create, &out.Create
		*out = new(bool)
		**out = **in
	}
	if in.RetentionInDays != nil {
		in, out := &in.RetentionInDays, &out.RetentionInDays
		*out = new(int64)
		**out = **in
	}
	if in.SkipDestroy != nil {
		in, out := &in.SkipDestroy, &out.SkipDestroy
		*out = new(bool)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new CloudwatchLogGroup.
func (in *CloudwatchLogGroup) DeepCopy() *CloudwatchLogGroup {
	if in == nil {
		return nil
	}
	out := new(CloudwatchLogGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterInstance) DeepCopyInto(out *ClusterInstance) {
	*out = *in
	if in.AllocatedStorage != nil {
		in, out := &in.AllocatedStorage, &out.AllocatedStorage
		*out = new(int64)
		**out = **in
	}
	if in.AllowMajorVersionUpgrade != nil {
		in, out := &in.AllowMajorVersionUpgrade, &out.AllowMajorVersionUpgrade
		*out = new(bool)
		**out = **in
	}
	if in.ApplyImmediately != nil {
		in, out := &in.ApplyImmediately, &out.ApplyImmediately
		*out = new(bool)
		**out = **in
	}
	if in.AutoMinorVersionUpgrade != nil {
		in, out := &in.AutoMinorVersionUpgrade, &out.AutoMinorVersionUpgrade
		*out = new(bool)
		**out = **in
	}
	if in.AvailabilityZone != nil {
		in, out := &in.AvailabilityZone, &out.AvailabilityZone
		*out = new(string)
		**out = **in
	}
	if in.BackupRetentionPeriod != nil {
		in, out := &in.BackupRetentionPeriod, &out.BackupRetentionPeriod
		*out = new(int64)
		**out = **in
	}
	if in.CopyTagsToSnapshot != nil {
		in, out := &in.CopyTagsToSnapshot, &out.CopyTagsToSnapshot
		*out = new(bool)
		**out = **in
	}
	if in.DatabaseName != nil {
		in, out := &in.DatabaseName, &out.DatabaseName
		*out = new(string)
		**out = **in
	}
	if in.DeleteAutomatedBackups != nil {
		in, out := &in.DeleteAutomatedBackups, &out.DeleteAutomatedBackups
		*out = new(bool)
		**out = **in
	}
	if in.DeletionProtection != nil {
		in, out := &in.DeletionProtection, &out.DeletionProtection
		*out = new(bool)
		**out = **in
	}
	if in.DomainIamRoleName != nil {
		in, out := &in.DomainIamRoleName, &out.DomainIamRoleName
		*out = new(string)
		**out = **in
	}
	if in.EnabledCloudwatchLogsExports != nil {
		in, out := &in.EnabledCloudwatchLogsExports, &out.EnabledCloudwatchLogsExports
		*out = make([]*LogGroup, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(LogGroup)
				**out = **in
			}
		}
	}
	if in.FinalSnapshotIdentifier != nil {
		in, out := &in.FinalSnapshotIdentifier, &out.FinalSnapshotIdentifier
		*out = new(string)
		**out = **in
	}
	if in.IamDatabaseAuthenticationEnabled != nil {
		in, out := &in.IamDatabaseAuthenticationEnabled, &out.IamDatabaseAuthenticationEnabled
		*out = new(bool)
		**out = **in
	}
	if in.Iops != nil {
		in, out := &in.Iops, &out.Iops
		*out = new(int64)
		**out = **in
	}
	if in.InstanceClass != nil {
		in, out := &in.InstanceClass, &out.InstanceClass
		*out = new(string)
		**out = **in
	}
	if in.LicenseModel != nil {
		in, out := &in.LicenseModel, &out.LicenseModel
		*out = new(string)
		**out = **in
	}
	if in.MonitoringInterval != nil {
		in, out := &in.MonitoringInterval, &out.MonitoringInterval
		*out = new(int64)
		**out = **in
	}
	if in.MultiAz != nil {
		in, out := &in.MultiAz, &out.MultiAz
		*out = new(bool)
		**out = **in
	}
	if in.NetworkType != nil {
		in, out := &in.NetworkType, &out.NetworkType
		*out = new(string)
		**out = **in
	}
	if in.OptionGroupName != nil {
		in, out := &in.OptionGroupName, &out.OptionGroupName
		*out = new(string)
		**out = **in
	}
	if in.ParameterGroupName != nil {
		in, out := &in.ParameterGroupName, &out.ParameterGroupName
		*out = new(string)
		**out = **in
	}
	if in.PerformanceInsightsEnabled != nil {
		in, out := &in.PerformanceInsightsEnabled, &out.PerformanceInsightsEnabled
		*out = new(bool)
		**out = **in
	}
	if in.PerformanceInsightsKmsKeyID != nil {
		in, out := &in.PerformanceInsightsKmsKeyID, &out.PerformanceInsightsKmsKeyID
		*out = new(string)
		**out = **in
	}
	if in.PerformanceInsightsRetentionPeriod != nil {
		in, out := &in.PerformanceInsightsRetentionPeriod, &out.PerformanceInsightsRetentionPeriod
		*out = new(int64)
		**out = **in
	}
	if in.PreferredMaintenanceWindow != nil {
		in, out := &in.PreferredMaintenanceWindow, &out.PreferredMaintenanceWindow
		*out = new(string)
		**out = **in
	}
	if in.PromotionTier != nil {
		in, out := &in.PromotionTier, &out.PromotionTier
		*out = new(int64)
		**out = **in
	}
	if in.PubliclyAccessible != nil {
		in, out := &in.PubliclyAccessible, &out.PubliclyAccessible
		*out = new(bool)
		**out = **in
	}
	if in.SkipFinalSnapshot != nil {
		in, out := &in.SkipFinalSnapshot, &out.SkipFinalSnapshot
		*out = new(bool)
		**out = **in
	}
	if in.StorageEncrypted != nil {
		in, out := &in.StorageEncrypted, &out.StorageEncrypted
		*out = new(bool)
		**out = **in
	}
	if in.StorageThroughput != nil {
		in, out := &in.StorageThroughput, &out.StorageThroughput
		*out = new(int64)
		**out = **in
	}
	if in.StorageType != nil {
		in, out := &in.StorageType, &out.StorageType
		*out = new(string)
		**out = **in
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterInstance.
func (in *ClusterInstance) DeepCopy() *ClusterInstance {
	if in == nil {
		return nil
	}
	out := new(ClusterInstance)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterParameterGroup) DeepCopyInto(out *ClusterParameterGroup) {
	*out = *in
	if in.ApplyMethod != nil {
		in, out := &in.ApplyMethod, &out.ApplyMethod
		*out = new(string)
		**out = **in
	}
	if in.Description != nil {
		in, out := &in.Description, &out.Description
		*out = new(string)
		**out = **in
	}
	if in.Create != nil {
		in, out := &in.Create, &out.Create
		*out = new(bool)
		**out = **in
	}
	if in.Family != nil {
		in, out := &in.Family, &out.Family
		*out = new(string)
		**out = **in
	}
	if in.Name != nil {
		in, out := &in.Name, &out.Name
		*out = new(string)
		**out = **in
	}
	if in.Parameters != nil {
		in, out := &in.Parameters, &out.Parameters
		*out = make([]*Parameter, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Parameter)
				**out = **in
			}
		}
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterParameterGroup.
func (in *ClusterParameterGroup) DeepCopy() *ClusterParameterGroup {
	if in == nil {
		return nil
	}
	out := new(ClusterParameterGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ClusterParameters) DeepCopyInto(out *ClusterParameters) {
	*out = *in
	if in.ActivityStream != nil {
		in, out := &in.ActivityStream, &out.ActivityStream
		*out = new(ActivityStream)
		(*in).DeepCopyInto(*out)
	}
	if in.AllocatedStorage != nil {
		in, out := &in.AllocatedStorage, &out.AllocatedStorage
		*out = new(int64)
		**out = **in
	}
	if in.AllowMajorVersionUpgrade != nil {
		in, out := &in.AllowMajorVersionUpgrade, &out.AllowMajorVersionUpgrade
		*out = new(bool)
		**out = **in
	}
	if in.ApplyImmediately != nil {
		in, out := &in.ApplyImmediately, &out.ApplyImmediately
		*out = new(bool)
		**out = **in
	}
	if in.AutoMinorVersionUpgrade != nil {
		in, out := &in.AutoMinorVersionUpgrade, &out.AutoMinorVersionUpgrade
		*out = new(bool)
		**out = **in
	}
	if in.Autoscaling != nil {
		in, out := &in.Autoscaling, &out.Autoscaling
		*out = new(Autoscaling)
		(*in).DeepCopyInto(*out)
	}
	if in.AvailabilityZones != nil {
		in, out := &in.AvailabilityZones, &out.AvailabilityZones
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.BackupRetentionPeriod != nil {
		in, out := &in.BackupRetentionPeriod, &out.BackupRetentionPeriod
		*out = new(int64)
		**out = **in
	}
	if in.BacktrackWindow != nil {
		in, out := &in.BacktrackWindow, &out.BacktrackWindow
		*out = new(int64)
		**out = **in
	}
	if in.CidrBlocks != nil {
		in, out := &in.CidrBlocks, &out.CidrBlocks
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.CopyTagsToSnapshot != nil {
		in, out := &in.CopyTagsToSnapshot, &out.CopyTagsToSnapshot
		*out = new(bool)
		**out = **in
	}
	if in.CreateCluster != nil {
		in, out := &in.CreateCluster, &out.CreateCluster
		*out = new(bool)
		**out = **in
	}
	if in.DatabaseName != nil {
		in, out := &in.DatabaseName, &out.DatabaseName
		*out = new(string)
		**out = **in
	}
	if in.DbClusterInstanceClass != nil {
		in, out := &in.DbClusterInstanceClass, &out.DbClusterInstanceClass
		*out = new(string)
		**out = **in
	}
	if in.DbClusterParameterGroup != nil {
		in, out := &in.DbClusterParameterGroup, &out.DbClusterParameterGroup
		*out = new(ClusterParameterGroup)
		(*in).DeepCopyInto(*out)
	}
	if in.DbParameterGroup != nil {
		in, out := &in.DbParameterGroup, &out.DbParameterGroup
		*out = new(DbParameterGroup)
		(*in).DeepCopyInto(*out)
	}
	if in.DeleteAutomatedBackups != nil {
		in, out := &in.DeleteAutomatedBackups, &out.DeleteAutomatedBackups
		*out = new(bool)
		**out = **in
	}
	if in.DeletionProtection != nil {
		in, out := &in.DeletionProtection, &out.DeletionProtection
		*out = new(bool)
		**out = **in
	}
	if in.Domain != nil {
		in, out := &in.Domain, &out.Domain
		*out = new(string)
		**out = **in
	}
	if in.DomainIAMRoleName != nil {
		in, out := &in.DomainIAMRoleName, &out.DomainIAMRoleName
		*out = new(string)
		**out = **in
	}
	if in.EnableGlobalWriteForwarding != nil {
		in, out := &in.EnableGlobalWriteForwarding, &out.EnableGlobalWriteForwarding
		*out = new(bool)
		**out = **in
	}
	if in.EnableHttpEndpoint != nil {
		in, out := &in.EnableHttpEndpoint, &out.EnableHttpEndpoint
		*out = new(bool)
		**out = **in
	}
	if in.EnableLocalWriteForwarding != nil {
		in, out := &in.EnableLocalWriteForwarding, &out.EnableLocalWriteForwarding
		*out = new(bool)
		**out = **in
	}
	if in.EnabledCloudwatchLogsExports != nil {
		in, out := &in.EnabledCloudwatchLogsExports, &out.EnabledCloudwatchLogsExports
		*out = make([]*LogGroup, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(LogGroup)
				**out = **in
			}
		}
	}
	if in.EnhancedMonitoring != nil {
		in, out := &in.EnhancedMonitoring, &out.EnhancedMonitoring
		*out = new(EnhancedMonitoring)
		(*in).DeepCopyInto(*out)
	}
	if in.Endpoints != nil {
		in, out := &in.Endpoints, &out.Endpoints
		*out = make([]*Endpoint, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Endpoint)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.Engine != nil {
		in, out := &in.Engine, &out.Engine
		*out = new(string)
		**out = **in
	}
	if in.EngineMode != nil {
		in, out := &in.EngineMode, &out.EngineMode
		*out = new(string)
		**out = **in
	}
	if in.EngineVersion != nil {
		in, out := &in.EngineVersion, &out.EngineVersion
		*out = new(string)
		**out = **in
	}
	if in.GlobalClusterIdentifier != nil {
		in, out := &in.GlobalClusterIdentifier, &out.GlobalClusterIdentifier
		*out = new(string)
		**out = **in
	}
	if in.IAMDatabaseAuthenticationEnabled != nil {
		in, out := &in.IAMDatabaseAuthenticationEnabled, &out.IAMDatabaseAuthenticationEnabled
		*out = new(bool)
		**out = **in
	}
	if in.IamRoles != nil {
		in, out := &in.IamRoles, &out.IamRoles
		*out = make([]*RdsBaseDbRole, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(RdsBaseDbRole)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.Iops != nil {
		in, out := &in.Iops, &out.Iops
		*out = new(int64)
		**out = **in
	}
	if in.Instances != nil {
		in, out := &in.Instances, &out.Instances
		*out = make([]*ClusterInstance, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(ClusterInstance)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.CloudwatchLogGroupParameters != nil {
		in, out := &in.CloudwatchLogGroupParameters, &out.CloudwatchLogGroupParameters
		*out = new(CloudwatchLogGroup)
		(*in).DeepCopyInto(*out)
	}
	if in.MasterUsername != nil {
		in, out := &in.MasterUsername, &out.MasterUsername
		*out = new(string)
		**out = **in
	}
	if in.MultiAz != nil {
		in, out := &in.MultiAz, &out.MultiAz
		*out = new(bool)
		**out = **in
	}
	if in.Partition != nil {
		in, out := &in.Partition, &out.Partition
		*out = new(string)
		**out = **in
	}
	if in.PerformanceInsightsEnabled != nil {
		in, out := &in.PerformanceInsightsEnabled, &out.PerformanceInsightsEnabled
		*out = new(bool)
		**out = **in
	}
	if in.PerformanceInsightsKmsKeyID != nil {
		in, out := &in.PerformanceInsightsKmsKeyID, &out.PerformanceInsightsKmsKeyID
		*out = new(string)
		**out = **in
	}
	if in.PerformanceInsightsRetentionPeriod != nil {
		in, out := &in.PerformanceInsightsRetentionPeriod, &out.PerformanceInsightsRetentionPeriod
		*out = new(int64)
		**out = **in
	}
	if in.PreferredBackupWindow != nil {
		in, out := &in.PreferredBackupWindow, &out.PreferredBackupWindow
		*out = new(string)
		**out = **in
	}
	if in.PreferredMaintenanceWindow != nil {
		in, out := &in.PreferredMaintenanceWindow, &out.PreferredMaintenanceWindow
		*out = new(string)
		**out = **in
	}
	if in.PubliclyAccessible != nil {
		in, out := &in.PubliclyAccessible, &out.PubliclyAccessible
		*out = new(bool)
		**out = **in
	}
	if in.ReplicationSourceIdentifier != nil {
		in, out := &in.ReplicationSourceIdentifier, &out.ReplicationSourceIdentifier
		*out = new(string)
		**out = **in
	}
	if in.RestoreToPointInTime != nil {
		in, out := &in.RestoreToPointInTime, &out.RestoreToPointInTime
		*out = new(RestoreToPointInTime)
		(*in).DeepCopyInto(*out)
	}
	if in.S3Import != nil {
		in, out := &in.S3Import, &out.S3Import
		*out = new(S3Import)
		(*in).DeepCopyInto(*out)
	}
	if in.ScalingConfiguration != nil {
		in, out := &in.ScalingConfiguration, &out.ScalingConfiguration
		*out = new(ScalingConfiguration)
		(*in).DeepCopyInto(*out)
	}
	if in.SecretRotation != nil {
		in, out := &in.SecretRotation, &out.SecretRotation
		*out = new(SecretRotation)
		(*in).DeepCopyInto(*out)
	}
	if in.ServerlessV2ScalingConfiguration != nil {
		in, out := &in.ServerlessV2ScalingConfiguration, &out.ServerlessV2ScalingConfiguration
		*out = new(ServerlessV2ScalingConfiguration)
		(*in).DeepCopyInto(*out)
	}
	if in.StorageType != nil {
		in, out := &in.StorageType, &out.StorageType
		*out = new(string)
		**out = **in
	}
	if in.SubnetIds != nil {
		in, out := &in.SubnetIds, &out.SubnetIds
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
	if in.VpcId != nil {
		in, out := &in.VpcId, &out.VpcId
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ClusterParameters.
func (in *ClusterParameters) DeepCopy() *ClusterParameters {
	if in == nil {
		return nil
	}
	out := new(ClusterParameters)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *DbParameterGroup) DeepCopyInto(out *DbParameterGroup) {
	*out = *in
	if in.Description != nil {
		in, out := &in.Description, &out.Description
		*out = new(string)
		**out = **in
	}
	if in.Create != nil {
		in, out := &in.Create, &out.Create
		*out = new(bool)
		**out = **in
	}
	if in.Family != nil {
		in, out := &in.Family, &out.Family
		*out = new(string)
		**out = **in
	}
	if in.Name != nil {
		in, out := &in.Name, &out.Name
		*out = new(string)
		**out = **in
	}
	if in.Parameters != nil {
		in, out := &in.Parameters, &out.Parameters
		*out = make([]*Parameter, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Parameter)
				**out = **in
			}
		}
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new DbParameterGroup.
func (in *DbParameterGroup) DeepCopy() *DbParameterGroup {
	if in == nil {
		return nil
	}
	out := new(DbParameterGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Endpoint) DeepCopyInto(out *Endpoint) {
	*out = *in
	if in.CustomEndpointType != nil {
		in, out := &in.CustomEndpointType, &out.CustomEndpointType
		*out = new(string)
		**out = **in
	}
	if in.ExcludedMembers != nil {
		in, out := &in.ExcludedMembers, &out.ExcludedMembers
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.StaticMembers != nil {
		in, out := &in.StaticMembers, &out.StaticMembers
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Endpoint.
func (in *Endpoint) DeepCopy() *Endpoint {
	if in == nil {
		return nil
	}
	out := new(Endpoint)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *EnhancedMonitoring) DeepCopyInto(out *EnhancedMonitoring) {
	*out = *in
	if in.Description != nil {
		in, out := &in.Description, &out.Description
		*out = new(string)
		**out = **in
	}
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.ForceDetachPolicies != nil {
		in, out := &in.ForceDetachPolicies, &out.ForceDetachPolicies
		*out = new(bool)
		**out = **in
	}
	if in.ManagedPolicyArns != nil {
		in, out := &in.ManagedPolicyArns, &out.ManagedPolicyArns
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.PermissionsBoundary != nil {
		in, out := &in.PermissionsBoundary, &out.PermissionsBoundary
		*out = new(string)
		**out = **in
	}
	if in.MaxSessionDuration != nil {
		in, out := &in.MaxSessionDuration, &out.MaxSessionDuration
		*out = new(int64)
		**out = **in
	}
	if in.MonitoringInterval != nil {
		in, out := &in.MonitoringInterval, &out.MonitoringInterval
		*out = new(int64)
		**out = **in
	}
	if in.Path != nil {
		in, out := &in.Path, &out.Path
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new EnhancedMonitoring.
func (in *EnhancedMonitoring) DeepCopy() *EnhancedMonitoring {
	if in == nil {
		return nil
	}
	out := new(EnhancedMonitoring)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *OptionGroup) DeepCopyInto(out *OptionGroup) {
	*out = *in
	if in.Description != nil {
		in, out := &in.Description, &out.Description
		*out = new(string)
		**out = **in
	}
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.EngineName != nil {
		in, out := &in.EngineName, &out.EngineName
		*out = new(string)
		**out = **in
	}
	if in.MajorEngineVersion != nil {
		in, out := &in.MajorEngineVersion, &out.MajorEngineVersion
		*out = new(string)
		**out = **in
	}
	if in.Name != nil {
		in, out := &in.Name, &out.Name
		*out = new(string)
		**out = **in
	}
	if in.Options != nil {
		in, out := &in.Options, &out.Options
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]*string, len(*in))
		for key, val := range *in {
			var outVal *string
			if val == nil {
				(*out)[key] = nil
			} else {
				inVal := (*in)[key]
				in, out := &inVal, &outVal
				*out = new(string)
				**out = **in
			}
			(*out)[key] = outVal
		}
	}
	if in.Version != nil {
		in, out := &in.Version, &out.Version
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new OptionGroup.
func (in *OptionGroup) DeepCopy() *OptionGroup {
	if in == nil {
		return nil
	}
	out := new(OptionGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RdsBaseDbCluster) DeepCopyInto(out *RdsBaseDbCluster) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RdsBaseDbCluster.
func (in *RdsBaseDbCluster) DeepCopy() *RdsBaseDbCluster {
	if in == nil {
		return nil
	}
	out := new(RdsBaseDbCluster)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *RdsBaseDbCluster) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RdsBaseDbList) DeepCopyInto(out *RdsBaseDbList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]RdsBaseDbCluster, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RdsBaseDbList.
func (in *RdsBaseDbList) DeepCopy() *RdsBaseDbList {
	if in == nil {
		return nil
	}
	out := new(RdsBaseDbList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *RdsBaseDbList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RdsBaseDbRole) DeepCopyInto(out *RdsBaseDbRole) {
	*out = *in
	if in.FeatureName != nil {
		in, out := &in.FeatureName, &out.FeatureName
		*out = new(string)
		**out = **in
	}
	if in.RoleArn != nil {
		in, out := &in.RoleArn, &out.RoleArn
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RdsBaseDbRole.
func (in *RdsBaseDbRole) DeepCopy() *RdsBaseDbRole {
	if in == nil {
		return nil
	}
	out := new(RdsBaseDbRole)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RdsBaseDbSpec) DeepCopyInto(out *RdsBaseDbSpec) {
	*out = *in
	in.ResourceSpec.DeepCopyInto(&out.ResourceSpec)
	in.ClusterParameters.DeepCopyInto(&out.ClusterParameters)
	if in.Region != nil {
		in, out := &in.Region, &out.Region
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RdsBaseDbSpec.
func (in *RdsBaseDbSpec) DeepCopy() *RdsBaseDbSpec {
	if in == nil {
		return nil
	}
	out := new(RdsBaseDbSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RdsBaseDbStatus) DeepCopyInto(out *RdsBaseDbStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
	if in.AccountId != nil {
		in, out := &in.AccountId, &out.AccountId
		*out = new(string)
		**out = **in
	}
	if in.ClusterIdentifier != nil {
		in, out := &in.ClusterIdentifier, &out.ClusterIdentifier
		*out = new(string)
		**out = **in
	}
	if in.ClusterArn != nil {
		in, out := &in.ClusterArn, &out.ClusterArn
		*out = new(string)
		**out = **in
	}
	if in.ClusterResourceId != nil {
		in, out := &in.ClusterResourceId, &out.ClusterResourceId
		*out = new(string)
		**out = **in
	}
	if in.DbParameterGroupName != nil {
		in, out := &in.DbParameterGroupName, &out.DbParameterGroupName
		*out = new(string)
		**out = **in
	}
	if in.DbSubnetGroupName != nil {
		in, out := &in.DbSubnetGroupName, &out.DbSubnetGroupName
		*out = new(string)
		**out = **in
	}
	if in.Endpoint != nil {
		in, out := &in.Endpoint, &out.Endpoint
		*out = new(string)
		**out = **in
	}
	if in.KmsKeyId != nil {
		in, out := &in.KmsKeyId, &out.KmsKeyId
		*out = new(string)
		**out = **in
	}
	if in.MonitoringRoleArn != nil {
		in, out := &in.MonitoringRoleArn, &out.MonitoringRoleArn
		*out = new(string)
		**out = **in
	}
	if in.Port != nil {
		in, out := &in.Port, &out.Port
		*out = new(int64)
		**out = **in
	}
	if in.SecurityGroupId != nil {
		in, out := &in.SecurityGroupId, &out.SecurityGroupId
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RdsBaseDbStatus.
func (in *RdsBaseDbStatus) DeepCopy() *RdsBaseDbStatus {
	if in == nil {
		return nil
	}
	out := new(RdsBaseDbStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *RestoreToPointInTime) DeepCopyInto(out *RestoreToPointInTime) {
	*out = *in
	if in.Identifier != nil {
		in, out := &in.Identifier, &out.Identifier
		*out = new(string)
		**out = **in
	}
	if in.RestoreToTime != nil {
		in, out := &in.RestoreToTime, &out.RestoreToTime
		*out = (*in).DeepCopy()
	}
	if in.UseLatestRestorableTime != nil {
		in, out := &in.UseLatestRestorableTime, &out.UseLatestRestorableTime
		*out = new(bool)
		**out = **in
	}
	if in.RestoreType != nil {
		in, out := &in.RestoreType, &out.RestoreType
		*out = new(string)
		**out = **in
	}
	if in.SourceDbClusterIdentifier != nil {
		in, out := &in.SourceDbClusterIdentifier, &out.SourceDbClusterIdentifier
		*out = new(string)
		**out = **in
	}
	if in.SourceDbInstanceIdentifier != nil {
		in, out := &in.SourceDbInstanceIdentifier, &out.SourceDbInstanceIdentifier
		*out = new(string)
		**out = **in
	}
	if in.SourceDbInstanceAutomatedBackupsArn != nil {
		in, out := &in.SourceDbInstanceAutomatedBackupsArn, &out.SourceDbInstanceAutomatedBackupsArn
		*out = new(string)
		**out = **in
	}
	if in.SourceDbiResourceId != nil {
		in, out := &in.SourceDbiResourceId, &out.SourceDbiResourceId
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new RestoreToPointInTime.
func (in *RestoreToPointInTime) DeepCopy() *RestoreToPointInTime {
	if in == nil {
		return nil
	}
	out := new(RestoreToPointInTime)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *S3Import) DeepCopyInto(out *S3Import) {
	*out = *in
	if in.BucketName != nil {
		in, out := &in.BucketName, &out.BucketName
		*out = new(string)
		**out = **in
	}
	if in.BucketPrefix != nil {
		in, out := &in.BucketPrefix, &out.BucketPrefix
		*out = new(string)
		**out = **in
	}
	if in.IngestionRole != nil {
		in, out := &in.IngestionRole, &out.IngestionRole
		*out = new(string)
		**out = **in
	}
	if in.SourceEngine != nil {
		in, out := &in.SourceEngine, &out.SourceEngine
		*out = new(string)
		**out = **in
	}
	if in.SourceEngineVersion != nil {
		in, out := &in.SourceEngineVersion, &out.SourceEngineVersion
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new S3Import.
func (in *S3Import) DeepCopy() *S3Import {
	if in == nil {
		return nil
	}
	out := new(S3Import)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ScalingConfiguration) DeepCopyInto(out *ScalingConfiguration) {
	*out = *in
	if in.AutoPause != nil {
		in, out := &in.AutoPause, &out.AutoPause
		*out = new(bool)
		**out = **in
	}
	if in.MaxCapacity != nil {
		in, out := &in.MaxCapacity, &out.MaxCapacity
		*out = new(int64)
		**out = **in
	}
	if in.MinCapacity != nil {
		in, out := &in.MinCapacity, &out.MinCapacity
		*out = new(int64)
		**out = **in
	}
	if in.SecondsUntilAutoPause != nil {
		in, out := &in.SecondsUntilAutoPause, &out.SecondsUntilAutoPause
		*out = new(int64)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ScalingConfiguration.
func (in *ScalingConfiguration) DeepCopy() *ScalingConfiguration {
	if in == nil {
		return nil
	}
	out := new(ScalingConfiguration)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *SecretRotation) DeepCopyInto(out *SecretRotation) {
	*out = *in
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.AutomaticallyAfterDays != nil {
		in, out := &in.AutomaticallyAfterDays, &out.AutomaticallyAfterDays
		*out = new(int64)
		**out = **in
	}
	if in.RotateImmediately != nil {
		in, out := &in.RotateImmediately, &out.RotateImmediately
		*out = new(bool)
		**out = **in
	}
	if in.ScheduleExpression != nil {
		in, out := &in.ScheduleExpression, &out.ScheduleExpression
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new SecretRotation.
func (in *SecretRotation) DeepCopy() *SecretRotation {
	if in == nil {
		return nil
	}
	out := new(SecretRotation)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ServerlessV2ScalingConfiguration) DeepCopyInto(out *ServerlessV2ScalingConfiguration) {
	*out = *in
	if in.MaxCapacity != nil {
		in, out := &in.MaxCapacity, &out.MaxCapacity
		*out = new(int64)
		**out = **in
	}
	if in.MinCapacity != nil {
		in, out := &in.MinCapacity, &out.MinCapacity
		*out = new(int64)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ServerlessV2ScalingConfiguration.
func (in *ServerlessV2ScalingConfiguration) DeepCopy() *ServerlessV2ScalingConfiguration {
	if in == nil {
		return nil
	}
	out := new(ServerlessV2ScalingConfiguration)
	in.DeepCopyInto(out)
	return out
}
