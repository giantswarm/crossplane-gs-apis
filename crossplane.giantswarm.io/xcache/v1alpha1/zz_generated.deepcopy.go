//go:build !ignore_autogenerated

// Code generated by controller-gen. DO NOT EDIT.

package v1alpha1

import (
	"github.com/crossplane/crossplane-runtime/apis/common/v1"
	"github.com/giantswarm/crossplane-gs-apis/pkg/eso"
	runtime "k8s.io/apimachinery/pkg/runtime"
)

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *CacheBase) DeepCopyInto(out *CacheBase) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ObjectMeta.DeepCopyInto(&out.ObjectMeta)
	in.Spec.DeepCopyInto(&out.Spec)
	in.Status.DeepCopyInto(&out.Status)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new CacheBase.
func (in *CacheBase) DeepCopy() *CacheBase {
	if in == nil {
		return nil
	}
	out := new(CacheBase)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *CacheBase) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *CacheBaseList) DeepCopyInto(out *CacheBaseList) {
	*out = *in
	out.TypeMeta = in.TypeMeta
	in.ListMeta.DeepCopyInto(&out.ListMeta)
	if in.Items != nil {
		in, out := &in.Items, &out.Items
		*out = make([]CacheBase, len(*in))
		for i := range *in {
			(*in)[i].DeepCopyInto(&(*out)[i])
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new CacheBaseList.
func (in *CacheBaseList) DeepCopy() *CacheBaseList {
	if in == nil {
		return nil
	}
	out := new(CacheBaseList)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyObject is an autogenerated deepcopy function, copying the receiver, creating a new runtime.Object.
func (in *CacheBaseList) DeepCopyObject() runtime.Object {
	if c := in.DeepCopy(); c != nil {
		return c
	}
	return nil
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *CacheBaseSpec) DeepCopyInto(out *CacheBaseSpec) {
	*out = *in
	in.ResourceSpec.DeepCopyInto(&out.ResourceSpec)
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
	if in.Eso != nil {
		in, out := &in.Eso, &out.Eso
		*out = new(eso.Eso)
		(*in).DeepCopyInto(*out)
	}
	in.ReplicationGroup.DeepCopyInto(&out.ReplicationGroup)
	if in.Region != nil {
		in, out := &in.Region, &out.Region
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
	if in.VpcId != nil {
		in, out := &in.VpcId, &out.VpcId
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new CacheBaseSpec.
func (in *CacheBaseSpec) DeepCopy() *CacheBaseSpec {
	if in == nil {
		return nil
	}
	out := new(CacheBaseSpec)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *CacheBaseStatus) DeepCopyInto(out *CacheBaseStatus) {
	*out = *in
	in.ConditionedStatus.DeepCopyInto(&out.ConditionedStatus)
	if in.ClusterName != nil {
		in, out := &in.ClusterName, &out.ClusterName
		*out = new(string)
		**out = **in
	}
	if in.ClusterEndpoints != nil {
		in, out := &in.ClusterEndpoints, &out.ClusterEndpoints
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.ConnectionSecret != nil {
		in, out := &in.ConnectionSecret, &out.ConnectionSecret
		*out = new(string)
		**out = **in
	}
	if in.GlobalConnectionSecret != nil {
		in, out := &in.GlobalConnectionSecret, &out.GlobalConnectionSecret
		*out = new(string)
		**out = **in
	}
	if in.Endpoint != nil {
		in, out := &in.Endpoint, &out.Endpoint
		*out = new(string)
		**out = **in
	}
	if in.GlobalEndpoint != nil {
		in, out := &in.GlobalEndpoint, &out.GlobalEndpoint
		*out = new(string)
		**out = **in
	}
	if in.GlobalReaderEndpoint != nil {
		in, out := &in.GlobalReaderEndpoint, &out.GlobalReaderEndpoint
		*out = new(string)
		**out = **in
	}
	if in.GlobalReplicationGroupId != nil {
		in, out := &in.GlobalReplicationGroupId, &out.GlobalReplicationGroupId
		*out = new(string)
		**out = **in
	}
	if in.KmsKeyId != nil {
		in, out := &in.KmsKeyId, &out.KmsKeyId
		*out = new(string)
		**out = **in
	}
	if in.ParameterGroupName != nil {
		in, out := &in.ParameterGroupName, &out.ParameterGroupName
		*out = new(string)
		**out = **in
	}
	if in.Port != nil {
		in, out := &in.Port, &out.Port
		*out = new(int64)
		**out = **in
	}
	if in.ReaderEndpoint != nil {
		in, out := &in.ReaderEndpoint, &out.ReaderEndpoint
		*out = new(string)
		**out = **in
	}
	if in.Ready != nil {
		in, out := &in.Ready, &out.Ready
		*out = new(bool)
		**out = **in
	}
	if in.ReplicationGroupId != nil {
		in, out := &in.ReplicationGroupId, &out.ReplicationGroupId
		*out = new(string)
		**out = **in
	}
	if in.SecurityGroupId != nil {
		in, out := &in.SecurityGroupId, &out.SecurityGroupId
		*out = new(string)
		**out = **in
	}
	if in.SubnetGroupName != nil {
		in, out := &in.SubnetGroupName, &out.SubnetGroupName
		*out = new(string)
		**out = **in
	}
	if in.UserGroupId != nil {
		in, out := &in.UserGroupId, &out.UserGroupId
		*out = new(string)
		**out = **in
	}
	in.UserSecrets.DeepCopyInto(&out.UserSecrets)
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new CacheBaseStatus.
func (in *CacheBaseStatus) DeepCopy() *CacheBaseStatus {
	if in == nil {
		return nil
	}
	out := new(CacheBaseStatus)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *Cluster) DeepCopyInto(out *Cluster) {
	*out = *in
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
	if in.AzMode != nil {
		in, out := &in.AzMode, &out.AzMode
		*out = new(string)
		**out = **in
	}
	if in.AvailabilityZone != nil {
		in, out := &in.AvailabilityZone, &out.AvailabilityZone
		*out = new(string)
		**out = **in
	}
	if in.Engine != nil {
		in, out := &in.Engine, &out.Engine
		*out = new(string)
		**out = **in
	}
	if in.EngineVersion != nil {
		in, out := &in.EngineVersion, &out.EngineVersion
		*out = new(string)
		**out = **in
	}
	if in.FinalSnapshotIdentifier != nil {
		in, out := &in.FinalSnapshotIdentifier, &out.FinalSnapshotIdentifier
		*out = new(string)
		**out = **in
	}
	if in.IpDiscovery != nil {
		in, out := &in.IpDiscovery, &out.IpDiscovery
		*out = new(string)
		**out = **in
	}
	if in.LogDeliveryConfiguration != nil {
		in, out := &in.LogDeliveryConfiguration, &out.LogDeliveryConfiguration
		*out = make([]*LogDeliveryConfiguration, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(LogDeliveryConfiguration)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.MaintenanceWindow != nil {
		in, out := &in.MaintenanceWindow, &out.MaintenanceWindow
		*out = new(string)
		**out = **in
	}
	if in.NetworkType != nil {
		in, out := &in.NetworkType, &out.NetworkType
		*out = new(string)
		**out = **in
	}
	if in.NodeType != nil {
		in, out := &in.NodeType, &out.NodeType
		*out = new(string)
		**out = **in
	}
	if in.NotificationTopicArn != nil {
		in, out := &in.NotificationTopicArn, &out.NotificationTopicArn
		*out = new(string)
		**out = **in
	}
	if in.NumCacheNodes != nil {
		in, out := &in.NumCacheNodes, &out.NumCacheNodes
		*out = new(int64)
		**out = **in
	}
	if in.OutpostMode != nil {
		in, out := &in.OutpostMode, &out.OutpostMode
		*out = new(string)
		**out = **in
	}
	if in.ParameterGroupName != nil {
		in, out := &in.ParameterGroupName, &out.ParameterGroupName
		*out = new(string)
		**out = **in
	}
	if in.Port != nil {
		in, out := &in.Port, &out.Port
		*out = new(int64)
		**out = **in
	}
	if in.PreferredAvailabilityZones != nil {
		in, out := &in.PreferredAvailabilityZones, &out.PreferredAvailabilityZones
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.PreferredOutpostArn != nil {
		in, out := &in.PreferredOutpostArn, &out.PreferredOutpostArn
		*out = new(string)
		**out = **in
	}
	if in.SecurityGroupIds != nil {
		in, out := &in.SecurityGroupIds, &out.SecurityGroupIds
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.SnapshotArns != nil {
		in, out := &in.SnapshotArns, &out.SnapshotArns
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.SnapshotName != nil {
		in, out := &in.SnapshotName, &out.SnapshotName
		*out = new(string)
		**out = **in
	}
	if in.SnapshotRetentionLimit != nil {
		in, out := &in.SnapshotRetentionLimit, &out.SnapshotRetentionLimit
		*out = new(int64)
		**out = **in
	}
	if in.SnapshotWindow != nil {
		in, out := &in.SnapshotWindow, &out.SnapshotWindow
		*out = new(string)
		**out = **in
	}
	if in.SubnetGroupName != nil {
		in, out := &in.SubnetGroupName, &out.SubnetGroupName
		*out = new(string)
		**out = **in
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.TransitEncryptionEnabled != nil {
		in, out := &in.TransitEncryptionEnabled, &out.TransitEncryptionEnabled
		*out = new(bool)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Cluster.
func (in *Cluster) DeepCopy() *Cluster {
	if in == nil {
		return nil
	}
	out := new(Cluster)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *GlobalReplicationGroup) DeepCopyInto(out *GlobalReplicationGroup) {
	*out = *in
	if in.AutomaticFailoverEnabled != nil {
		in, out := &in.AutomaticFailoverEnabled, &out.AutomaticFailoverEnabled
		*out = new(bool)
		**out = **in
	}
	if in.CacheNodeType != nil {
		in, out := &in.CacheNodeType, &out.CacheNodeType
		*out = new(string)
		**out = **in
	}
	if in.Enabled != nil {
		in, out := &in.Enabled, &out.Enabled
		*out = new(bool)
		**out = **in
	}
	if in.EngineVersion != nil {
		in, out := &in.EngineVersion, &out.EngineVersion
		*out = new(string)
		**out = **in
	}
	if in.Suffix != nil {
		in, out := &in.Suffix, &out.Suffix
		*out = new(string)
		**out = **in
	}
	if in.NumNodeGroups != nil {
		in, out := &in.NumNodeGroups, &out.NumNodeGroups
		*out = new(int64)
		**out = **in
	}
	if in.ParameterGroupName != nil {
		in, out := &in.ParameterGroupName, &out.ParameterGroupName
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new GlobalReplicationGroup.
func (in *GlobalReplicationGroup) DeepCopy() *GlobalReplicationGroup {
	if in == nil {
		return nil
	}
	out := new(GlobalReplicationGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *LogDeliveryConfiguration) DeepCopyInto(out *LogDeliveryConfiguration) {
	*out = *in
	if in.Destination != nil {
		in, out := &in.Destination, &out.Destination
		*out = new(string)
		**out = **in
	}
	if in.DestinationType != nil {
		in, out := &in.DestinationType, &out.DestinationType
		*out = new(string)
		**out = **in
	}
	if in.LogFormat != nil {
		in, out := &in.LogFormat, &out.LogFormat
		*out = new(string)
		**out = **in
	}
	if in.LogType != nil {
		in, out := &in.LogType, &out.LogType
		*out = new(string)
		**out = **in
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new LogDeliveryConfiguration.
func (in *LogDeliveryConfiguration) DeepCopy() *LogDeliveryConfiguration {
	if in == nil {
		return nil
	}
	out := new(LogDeliveryConfiguration)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ParameterGroup) DeepCopyInto(out *ParameterGroup) {
	*out = *in
	if in.Description != nil {
		in, out := &in.Description, &out.Description
		*out = new(string)
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
		*out = make(Parameters, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ParameterGroup.
func (in *ParameterGroup) DeepCopy() *ParameterGroup {
	if in == nil {
		return nil
	}
	out := new(ParameterGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in Parameters) DeepCopyInto(out *Parameters) {
	{
		in := &in
		*out = make(Parameters, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new Parameters.
func (in Parameters) DeepCopy() Parameters {
	if in == nil {
		return nil
	}
	out := new(Parameters)
	in.DeepCopyInto(out)
	return *out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *ReplicationGroup) DeepCopyInto(out *ReplicationGroup) {
	*out = *in
	if in.AzMode != nil {
		in, out := &in.AzMode, &out.AzMode
		*out = new(string)
		**out = **in
	}
	if in.ApplyImmediately != nil {
		in, out := &in.ApplyImmediately, &out.ApplyImmediately
		*out = new(bool)
		**out = **in
	}
	if in.AtRestEncryptionEnabled != nil {
		in, out := &in.AtRestEncryptionEnabled, &out.AtRestEncryptionEnabled
		*out = new(bool)
		**out = **in
	}
	if in.AuthTokenUpdateStrategy != nil {
		in, out := &in.AuthTokenUpdateStrategy, &out.AuthTokenUpdateStrategy
		*out = new(string)
		**out = **in
	}
	if in.AutoMinorVersionUpgrade != nil {
		in, out := &in.AutoMinorVersionUpgrade, &out.AutoMinorVersionUpgrade
		*out = new(bool)
		**out = **in
	}
	if in.AutomaticFailoverEnabled != nil {
		in, out := &in.AutomaticFailoverEnabled, &out.AutomaticFailoverEnabled
		*out = new(bool)
		**out = **in
	}
	if in.CacheClusters != nil {
		in, out := &in.CacheClusters, &out.CacheClusters
		*out = make([]*Cluster, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(Cluster)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.CreateReplicationGroup != nil {
		in, out := &in.CreateReplicationGroup, &out.CreateReplicationGroup
		*out = new(bool)
		**out = **in
	}
	if in.ClusterModeEnabled != nil {
		in, out := &in.ClusterModeEnabled, &out.ClusterModeEnabled
		*out = new(bool)
		**out = **in
	}
	if in.DataTieringEnabled != nil {
		in, out := &in.DataTieringEnabled, &out.DataTieringEnabled
		*out = new(bool)
		**out = **in
	}
	if in.Engine != nil {
		in, out := &in.Engine, &out.Engine
		*out = new(string)
		**out = **in
	}
	if in.EngineVersion != nil {
		in, out := &in.EngineVersion, &out.EngineVersion
		*out = new(string)
		**out = **in
	}
	if in.FinalSnapshotIdentifier != nil {
		in, out := &in.FinalSnapshotIdentifier, &out.FinalSnapshotIdentifier
		*out = new(string)
		**out = **in
	}
	if in.GlobalReplicationGroup != nil {
		in, out := &in.GlobalReplicationGroup, &out.GlobalReplicationGroup
		*out = new(GlobalReplicationGroup)
		(*in).DeepCopyInto(*out)
	}
	if in.GlobalReplicationGroupId != nil {
		in, out := &in.GlobalReplicationGroupId, &out.GlobalReplicationGroupId
		*out = new(string)
		**out = **in
	}
	if in.IpDiscovery != nil {
		in, out := &in.IpDiscovery, &out.IpDiscovery
		*out = new(string)
		**out = **in
	}
	if in.KmsKeyId != nil {
		in, out := &in.KmsKeyId, &out.KmsKeyId
		*out = new(string)
		**out = **in
	}
	if in.KubernetesProviderConfig != nil {
		in, out := &in.KubernetesProviderConfig, &out.KubernetesProviderConfig
		*out = new(v1.Reference)
		(*in).DeepCopyInto(*out)
	}
	if in.LogDeliveryConfiguration != nil {
		in, out := &in.LogDeliveryConfiguration, &out.LogDeliveryConfiguration
		*out = make([]*LogDeliveryConfiguration, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(LogDeliveryConfiguration)
				(*in).DeepCopyInto(*out)
			}
		}
	}
	if in.MaintenanceWindow != nil {
		in, out := &in.MaintenanceWindow, &out.MaintenanceWindow
		*out = new(string)
		**out = **in
	}
	if in.MultiAzEnabled != nil {
		in, out := &in.MultiAzEnabled, &out.MultiAzEnabled
		*out = new(bool)
		**out = **in
	}
	if in.NetworkType != nil {
		in, out := &in.NetworkType, &out.NetworkType
		*out = new(string)
		**out = **in
	}
	if in.NodeType != nil {
		in, out := &in.NodeType, &out.NodeType
		*out = new(string)
		**out = **in
	}
	if in.NotificationTopicArn != nil {
		in, out := &in.NotificationTopicArn, &out.NotificationTopicArn
		*out = new(string)
		**out = **in
	}
	if in.NumCacheClusters != nil {
		in, out := &in.NumCacheClusters, &out.NumCacheClusters
		*out = new(int64)
		**out = **in
	}
	if in.NumNodeGroups != nil {
		in, out := &in.NumNodeGroups, &out.NumNodeGroups
		*out = new(int64)
		**out = **in
	}
	if in.NumCacheNodes != nil {
		in, out := &in.NumCacheNodes, &out.NumCacheNodes
		*out = new(int64)
		**out = **in
	}
	if in.ParameterGroupName != nil {
		in, out := &in.ParameterGroupName, &out.ParameterGroupName
		*out = new(string)
		**out = **in
	}
	in.ParameterGroupConfiguration.DeepCopyInto(&out.ParameterGroupConfiguration)
	if in.Port != nil {
		in, out := &in.Port, &out.Port
		*out = new(int64)
		**out = **in
	}
	if in.PreferredCacheClusterAzs != nil {
		in, out := &in.PreferredCacheClusterAzs, &out.PreferredCacheClusterAzs
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.ReplicasPerNodeGroup != nil {
		in, out := &in.ReplicasPerNodeGroup, &out.ReplicasPerNodeGroup
		*out = new(int64)
		**out = **in
	}
	if in.SecurityGroupIds != nil {
		in, out := &in.SecurityGroupIds, &out.SecurityGroupIds
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.SnapshotArns != nil {
		in, out := &in.SnapshotArns, &out.SnapshotArns
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
	if in.SnapshotName != nil {
		in, out := &in.SnapshotName, &out.SnapshotName
		*out = new(string)
		**out = **in
	}
	if in.SnapshotRetentionLimit != nil {
		in, out := &in.SnapshotRetentionLimit, &out.SnapshotRetentionLimit
		*out = new(int64)
		**out = **in
	}
	if in.SnapshotWindow != nil {
		in, out := &in.SnapshotWindow, &out.SnapshotWindow
		*out = new(string)
		**out = **in
	}
	if in.Tags != nil {
		in, out := &in.Tags, &out.Tags
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
	if in.TransitEncryptionEnabled != nil {
		in, out := &in.TransitEncryptionEnabled, &out.TransitEncryptionEnabled
		*out = new(bool)
		**out = **in
	}
	if in.Usernames != nil {
		in, out := &in.Usernames, &out.Usernames
		*out = make([]*string, len(*in))
		for i := range *in {
			if (*in)[i] != nil {
				in, out := &(*in)[i], &(*out)[i]
				*out = new(string)
				**out = **in
			}
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new ReplicationGroup.
func (in *ReplicationGroup) DeepCopy() *ReplicationGroup {
	if in == nil {
		return nil
	}
	out := new(ReplicationGroup)
	in.DeepCopyInto(out)
	return out
}

// DeepCopyInto is an autogenerated deepcopy function, copying the receiver, writing into out. in must be non-nil.
func (in *UserConnectionSecrets) DeepCopyInto(out *UserConnectionSecrets) {
	*out = *in
	if in.Users != nil {
		in, out := &in.Users, &out.Users
		*out = make(map[string]string, len(*in))
		for key, val := range *in {
			(*out)[key] = val
		}
	}
}

// DeepCopy is an autogenerated deepcopy function, copying the receiver, creating a new UserConnectionSecrets.
func (in *UserConnectionSecrets) DeepCopy() *UserConnectionSecrets {
	if in == nil {
		return nil
	}
	out := new(UserConnectionSecrets)
	in.DeepCopyInto(out)
	return out
}
