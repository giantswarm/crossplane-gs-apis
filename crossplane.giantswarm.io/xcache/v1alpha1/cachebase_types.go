package v1alpha1

import (
	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=ec
// +crossbuilder:generate:xrd:claimNames:kind=CacheBaseClaim,plural=cachebaseclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=cache-base
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=cache-base
type CacheBase struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   CacheBaseSpec   `json:"spec"`
	Status CacheBaseStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type CacheBaseList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []CacheBase `json:"items"`
}

type CacheBaseSpec struct {
	xpv1.ResourceSpec `json:",inline"`

	// AvailabilityZones is a list of Availability Zones in which the
	// cluster's nodes will be created.
	//
	// +optional
	AvailabilityZones []*string `json:"availabilityZones,omitempty"`

	// CidrBlocks is a list of CIDR blocks that are allowed to access the
	// cluster.
	//
	// +optional
	CidrBlocks []*string `json:"cidrBlocks,omitempty"`

	// ClusterParameters is the set of parameters that are used to create the
	// cluster.
	ReplicationGroup `json:",inline"`

	// Region is the region in which the cluster will be created.
	//
	// +required
	Region *string `json:"region"`

	// SubnetIds is a list of subnet IDs in which the cluster's nodes will be
	// created.
	//
	// +optional
	SubnetIds []*string `json:"subnetIds,omitempty"`

	// VpcId is the ID of the VPC in which the cluster will be created.
	//
	// +required
	VpcId *string `json:"vpcId"`
}

type CacheBaseStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// ClusterName is the name of the cluster.
	//
	// +optional
	ClusterName *string `json:"clusterName,omitempty"`

	// ClusterEndpoints is a list of endpoints for the clusters.
	//
	// +optional
	ClusterEndpoints []*string `json:"clusterEndpoints,omitempty"`

	// ConnectionSecret is the name of the connection secret.
	//
	// +optional
	ConnectionSecret *string `json:"connectionSecret,omitempty"`

	// GlobalConnectionSecret is the name of the global connection secret.
	//
	// +optional
	GlobalConnectionSecret *string `json:"globalConnectionSecret,omitempty"`

	// Endpoint is the DNS name of the endpoint for the cluster.
	//
	// +optional
	Endpoint *string `json:"endpoint,omitempty"`

	// GlobalEndpoint is the DNS name of the endpoint for the cluster at global
	// scope
	//
	// +optional
	GlobalEndpoint *string `json:"globalEndpoint,omitempty"`

	// GlobalReaderEndpoint is the DNS name of the reader endpoint for the
	// cluster at global scope
	//
	// +optional
	GlobalReaderEndpoint *string `json:"globalReaderEndpoint,omitempty"`

	// GlobalReplicationGroupId is the ID of the global replication group.
	//
	// +optional
	GlobalReplicationGroupId *string `json:"globalReplicationGroupId,omitempty"`

	// kmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
	// encrypt the data in the cluster.
	//
	// +optional
	KmsKeyId *string `json:"kmsKeyId,omitempty"`

	// ParameterGroupName is the name of the parameter group associated with the
	// cluster.
	//
	// +optional
	ParameterGroupName *string `json:"parameterGroupName,omitempty"`

	// Port is the port number on which each of the cache nodes will accept
	// connections.
	//
	// +optional
	Port *int64 `json:"port,omitempty"`

	// ReaderEndpoint is the DNS name of the reader endpoint for the cluster.
	//
	// +optional
	ReaderEndpoint *string `json:"readerEndpoint,omitempty"`

	// ReplicationGroupId is the ID of the replication group.
	//
	// +optional
	ReplicationGroupId *string `json:"replicationGroupId,omitempty"`

	// SecurityGroupId is the ID of the security group for the cluster.
	//
	// +optional
	SecurityGroupId *string `json:"securityGroupId,omitempty"`

	// SubnetGroupName is the name of the subnet group for the cluster.
	//
	// +optional
	SubnetGroupName *string `json:"subnetGroupName,omitempty"`

	// UserGroupId is the ID of the user group for the cluster.
	//
	// +optional
	UserGroupId *string `json:"userGroupId,omitempty"`
}

type Cluster struct {
	// ApplyImmediately specifies whether the changes should be applied
	// immediately or during the next maintenance window.
	//
	// +optional
	// +default=false
	ApplyImmediately *bool `json:"applyImmediately,omitempty"`

	// AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
	// applied automatically to the cluster during the maintenance window.
	//
	// +optional
	// +default=true
	AutoMinorVersionUpgrade *bool `json:"autoMinorVersionUpgrade,omitempty"`

	// AzMode specifies the Availability Zone mode of the cluster.
	//
	// This parameter is only valid when the Engine parameter is memcached.
	// For resiliance, we recommend setting the AzMode parameter to cross-az and
	// this is the default value. In this mode, the number of nodes must be > 1
	// If memcached is selected, the number of nodes will default to 3, one per
	// availability zone.
	//
	// +optional
	// +default=cross-az
	// +kubebuilder:validation:Enum=single-az;cross-az
	AzMode *string `json:"azMode,omitempty"`

	// AvailabilityZone is the name of the Availability Zone in which the
	// cluster will be created.
	//
	// If you want to create cache nodes in multi-az, use
	// preferred_availability_zones instead.
	// Default: System chosen Availability Zone.
	//
	// +optional
	AvailabilityZone *string `json:"availabilityZone,omitempty"`

	// Engine is the name of the cache engine to be used for the clusters in
	// this group.
	//
	// +required
	// +kubebuilder:validation:Enum=memcached;redis
	Engine *string `json:"engine"`

	// EngineVersion is the version number of the cache engine to be used for
	// the cluster. If not set this will default to the latest version.
	//
	// This value will be ignored once the cluster is created.
	//
	// +optional
	EngineVersion *string `json:"engineVersion,omitempty"`

	// FinalSnapshotIdentifier is the user-supplied name for the final snapshot
	// that is created immediately before the cluster is deleted.
	//
	// +optional
	FinalSnapshotIdentifier *string `json:"finalSnapshotIdentifier,omitempty"`

	// IpDiscovery is the method used to discover cluster nodes.
	//
	// +optional
	// +default=ipv4
	// +kubebuilder:validation:Enum=ipv4;ipv6
	IpDiscovery *string `json:"ipDiscovery,omitempty"`

	// LogDeliveryConfiguration is a list of log delivery configurations for
	// the cluster.
	//
	// This is only applicable when the Engine parameter is redis.
	//
	// +optional
	LogDeliveryConfiguration []*LogDeliveryConfiguration `json:"logDeliveryConfigurations,omitempty"`

	// MaintenanceWindow specifies the weekly time range during which system
	// maintenance can occur.
	//
	// +optional
	// +default=Sun:05:00-Mon:09:00
	MaintenanceWindow *string `json:"maintenanceWindow,omitempty"`

	// NetworkType specifies the network configuration for the cluster.
	//
	// +optional
	// +default=ipv4
	// +kubebuilder:validation:Enum=ipv4;ipv6;dual_stack
	NetworkType *string `json:"networkType,omitempty"`

	// NodeType is the instance class to use for the cache nodes.
	//
	// Requried unless replication group is specified.
	//
	// +optional
	NodeType *string `json:"nodeType,omitempty"`

	// NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
	// topic to which notifications will be sent.
	//
	// +optional
	NotificationTopicArn *string `json:"notificationTopicArn,omitempty"`

	// NumCacheNodes is the number of cache nodes in the cluster.
	//
	// Required unless replication group is specified.
	//
	// +optional
	NumCacheNodes *int64 `json:"numCacheNodes,omitempty"`

	// OutpostMode specifies the outpost mode that will apply to the cache
	// cluster creation.
	//
	// Currently only single-outpost is supported.
	//
	// +optional
	// +default=single-outpost
	// +kubebuilder:validation:Enum=single-outpost;cross-outpost
	OutpostMode *string `json:"outpostMode,omitempty"`

	// ParameterGroupName is the name of the parameter group to associate with
	// this cluster.
	//
	// Required unless replication group is specified.
	//
	// +optional
	ParameterGroupName *string `json:"parameterGroupName,omitempty"`

	// Port is the port number on which each of the cache nodes will accept
	// connections.
	//
	// +optional
	// +default=6379
	Port *int64 `json:"port,omitempty"`

	// PreferredAvailabilityZones is a list of Availability Zones in which the
	// cluster's nodes will be created.
	//
	// Memcached only. The number of availability zones must equal the number of
	// nodes specified in the NumCacheNodes parameter.
	//
	// +optional
	PreferredAvailabilityZones []*string `json:"preferredAvailabilityZones,omitempty"`

	// PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
	// which the cache cluster will be created.
	//
	// +optional
	PreferredOutpostArn *string `json:"preferredOutpostArn,omitempty"`

	// SecurityGroupIds is a list of security group IDs to associate with the
	// cluster.
	//
	// +optional
	SecurityGroupIds []*string `json:"securityGroupIds,omitempty"`

	// SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
	// from which to restore data into the cluster.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotArns []*string `json:"snapshotArns,omitempty"`

	// SnapshotName is the name of the snapshot from which to restore data into
	// the cluster.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotName *string `json:"snapshotName,omitempty"`

	// SnapshotRetentionLimit is the number of days for which ElastiCache will
	// retain automatic cache cluster snapshots before deleting them.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotRetentionLimit *int64 `json:"snapshotRetentionLimit,omitempty"`

	// SnapshotWindow is the daily time range (in UTC) during which ElastiCache
	// will begin taking a daily snapshot of the cache cluster.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotWindow *string `json:"snapshotWindow,omitempty"`

	// SubnetGroupName is the name of the subnet group to associate with this
	// cluster.
	//
	// Required unless replication group is specified in which case it will be
	// ignored.
	//
	// +optional
	SubnetGroupName *string `json:"subnetGroupName,omitempty"`

	// Tags is a list of key-value pairs to associate with the cluster.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`

	// TransitEncryptionEnabled specifies whether data in the cluster is
	// encrypted in transit.
	//
	// Optional, Memcached only
	//
	// +optional
	TransitEncryptionEnabled *bool `json:"transitEncryptionEnabled,omitempty"`
}

type LogDeliveryConfiguration struct {
	// Destination Name of the cloudwatch log group or for kinesis firehose resource.
	//
	// +required
	Destination *string `json:"destination"`

	// DestinationType The destination type for the logs.
	//
	// +required
	// +kubebuilder:validation:Enum=cloudwatch-logs;kinesis-firehose
	DestinationType *string `json:"destinationType"`

	// LogFormat The log format to use.
	//
	// +optional
	// +default=json
	// +kubebuilder:validation:Enum=text;json
	LogFormat *string `json:"logFormat,omitempty"`

	// LogType The type of log to deliver.
	//
	// +required
	// +kubebuilder:validation:Enum=slow-log;engine-log
	LogType *string `json:"logType"`
}

// Parameters
type Parameters map[string]string

// ParameterGroup
type ParameterGroup struct {
	// Description is a description of the parameter group.
	//
	// +optional
	Description *string `json:"description,omitempty"`

	// Family is the name of the parameter group family that this parameter
	// group is compatible with.
	//
	// +required
	Family *string `json:"family"`

	// Name is the name of the parameter group.
	//
	// +required
	Name *string `json:"name"`

	// Parameters is a list of parameters in the parameter group.
	//
	// +optional
	Parameters Parameters `json:"parameters,omitempty"`

	// Tags is a list of key-value pairs to associate with the parameter group.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`
}

// ReplicationGroup
type ReplicationGroup struct {
	// ApplyImmediately specifies whether the changes should be applied
	// immediately or during the next maintenance window.
	//
	// +optional
	// +default=false
	ApplyImmediately *bool `json:"applyImmediately,omitempty"`

	// AtRestEncryptionEnabled specifies whether data stored in the cluster is
	// encrypted at rest.
	//
	// +optional
	// +default=true
	AtRestEncryptionEnabled *bool `json:"atRestEncryptionEnabled,omitempty"`

	// AuthTokenUpdateStrategy specifies how the auth token should be updated.
	//
	// +optional
	// +default=ROTATE
	// +kubebuilder:validation:Enum=rotate;set
	AuthTokenUpdateStrategy *string `json:"authTokenUpdateStrategy,omitempty"`

	// AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
	// applied automatically to the cluster during the maintenance window.
	//
	// +optional
	// +default=true
	AutoMinorVersionUpgrade *bool `json:"autoMinorVersionUpgrade,omitempty"`

	// AutomaticFailoverEnabled specifies whether a read replica will be
	// automatically promoted to the primary cluster if the existing primary
	// cluster fails.
	//
	// If enabled, NumCacheNodes must be greater than 1. Must be enabled for
	// Redis (cluster mode enabled) replication groups.
	//
	// +optional
	// +default=false
	AutomaticFailoverEnabled *bool `json:"automaticFailoverEnabled,omitempty"`

	// CacheClusters is a list of cache clusters in the replication group.
	//
	// This value is overridden by NumCacheClusters.
	//
	// May be used to specify cluster specific configuration.
	//
	// +optional
	CacheClusters []*Cluster `json:"cacheClusters,omitempty"`

	// CreateReplicationGroup specifies whether a replication group should be
	// created.
	//
	// If set false, the replication group configuration will be used for
	// creating a single cluster
	//
	// +optional
	// +default=true
	CreateReplicationGroup *bool `json:"createReplicationGroup,omitempty"`

	// ClusterModeEnabled specifies whether cluster mode is enabled for the
	// replication group.
	//
	// +optional
	// +default=false
	ClusterModeEnabled *bool `json:"clusterModeEnabled,omitempty"`

	// DataTieringEnabled specifies whether data tiering is enabled for the
	// replication group.
	//
	// Must be true if the replcation group is using r6gd nodes
	//
	// +optional
	// +default=false
	DataTieringEnabled *bool `json:"dataTieringEnabled,omitempty"`

	// Engine is the name of the cache engine to be used for the clusters in
	// this group.
	//
	// +optional
	// +default=redis
	// +kubebuilder:validation:Enum=memcached;redis
	Engine *string `json:"engine"`

	// EngineVersion is the version number of the cache engine to be used for
	// the cluster. If not set this will default to the latest version.
	//
	// This value will be ignored once the cluster is created.
	//
	// +optional
	EngineVersion *string `json:"engineVersion,omitempty"`

	// FinalSnapshotIdentifier is the user-supplied name for the final snapshot
	// that is created immediately before the cluster is deleted.
	//
	// +optional
	FinalSnapshotIdentifier *string `json:"finalSnapshotIdentifier,omitempty"`

	// GlobalReplicationGroup is the global replication group configuration.
	//
	// +optional
	GlobalReplicationGroup *GlobalReplicationGroup `json:"globalReplicationGroup,omitempty"`

	// GlobalReplicationGroupId is the id of the global replication group to
	// which this replication group should belong.
	//
	// If this value is specified, the number of node groups parameter must not
	// be specified.
	//
	// +optional
	GlobalReplicationGroupId *string `json:"globalReplicationGroupId,omitempty"`

	// IpDiscovery is the method used to discover cluster nodes.
	//
	// +optional
	// +default=ipv4
	// +kubebuilder:validation:Enum=ipv4;ipv6
	IpDiscovery *string `json:"ipDiscovery,omitempty"`

	// KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
	// encrypt the data in the cluster.
	//
	// Ignored unless AtRestEncryptionEnabled is set to true.
	//
	// +optional
	KmsKeyId *string `json:"kmsKeyId,omitempty"`

	// LogDeliveryConfiguration is a list of log delivery configurations for
	// the cluster.
	//
	// This is only applicable when the Engine parameter is redis.
	//
	// +optional
	LogDeliveryConfiguration []*LogDeliveryConfiguration `json:"logDeliveryConfigurations,omitempty"`

	// MaintenanceWindow specifies the weekly time range during which system
	// maintenance can occur.
	//
	// +optional
	// +default=Sun:05:00-Mon:09:00
	MaintenanceWindow *string `json:"maintenanceWindow,omitempty"`

	// MultiAzEnabled specifies whether the cluster should be created in
	// multiple Availability Zones.
	//
	// If true, AutomaticFailoverEnabled must also be true.
	//
	// +optional
	// +default=true
	MultiAzEnabled *bool `json:"multiAzEnabled,omitempty"`

	// NetworkType specifies the network configuration for the cluster.
	//
	// +optional
	// +default=ipv4
	// +kubebuilder:validation:Enum=ipv4;ipv6;dual_stack
	NetworkType *string `json:"networkType,omitempty"`

	// NodeType is the instance class to use for the cache nodes.
	//
	// Requried unless global replication group is specified.
	//
	// +optional
	NodeType *string `json:"nodeType,omitempty"`

	// NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
	// topic to which notifications will be sent.
	//
	// +optional
	NotificationTopicArn *string `json:"notificationTopicArn,omitempty"`

	// NumCacheClusters is the number of cache clusters in the replication group.
	//
	// If MultiAzEnabled is true, this value must be at least 2 but generally
	// should be equal to the number of Availability Zones.
	//
	// Conflicts with NumNodeGroups.
	//
	// +optional
	// +default=1
	NumCacheClusters *int64 `json:"numCacheClusters,omitempty"`

	// NumNodeGroups is the number of node groups in the replication group.
	//
	// If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
	// is true, this value must not be specified.
	//
	// Conflicts with NumCacheClusters.
	//
	// +optional
	NumNodeGroups *int64 `json:"numNodeGroups,omitempty"`

	// NumCacheNodes is the number of cache nodes in the cluster.
	//
	// Ignored if replication group is specified or being created
	// This is a convenience parameter when building a single cluster.
	//
	// +optional
	// +default=3
	NumCacheNodes *int64 `json:"numCacheNodes,omitempty"`

	// ParameterGroupName is the name of the parameter group to associate with
	// this cluster. To create a new parameter group, use the
	// `ParameterGroupConfiguration` option instead.
	//
	// +optional
	ParameterGroupName *string `json:"parameterGroupName,omitempty"`

	// ParameterGroupConfiguration defines the configuration for the parameter
	// group.
	//
	// +optional
	ParameterGroupConfiguration ParameterGroup `json:"parameterGroupConfiguration,omitempty"`

	// Port is the port number on which each of the cache nodes will accept
	// connections.
	//
	// +optional
	// +default=6379
	Port *int64 `json:"port,omitempty"`

	// PreferredCacheClusterAzs is a list ec2 availability zones in which the
	// cache clusters will be created.
	//
	// +optional
	PreferredCacheClusterAzs []*string `json:"preferredCacheClusterAzs,omitempty"`

	// ReplicasPerNodeGroup is the number of read replicas per node group.
	//
	// +optional
	// +default=0
	// +kubebuilder:validation:Minimum=0
	// +kubebuilder:validation:Maximum=5
	ReplicasPerNodeGroup *int64 `json:"replicasPerNodeGroup,omitempty"`

	// SecurityGroupIds is a list of security group IDs to associate with the
	// cluster.
	//
	// +optional
	SecurityGroupIds []*string `json:"securityGroupIds,omitempty"`

	// SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
	// from which to restore data into the cluster.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotArns []*string `json:"snapshotArns,omitempty"`

	// SnapshotName is the name of the snapshot from which to restore data into
	// the cluster.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotName *string `json:"snapshotName,omitempty"`

	// SnapshotRetentionLimit is the number of days for which ElastiCache will
	// retain automatic cache cluster snapshots before deleting them.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotRetentionLimit *int64 `json:"snapshotRetentionLimit,omitempty"`

	// SnapshotWindow is the daily time range (in UTC) during which ElastiCache
	// will begin taking a daily snapshot of the cache cluster.
	//
	// Optional, Redis only
	//
	// +optional
	SnapshotWindow *string `json:"snapshotWindow,omitempty"`

	// Tags is a list of key-value pairs to associate with the cluster.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]string `json:"tags,omitempty"`

	// TransitEncryptionEnabled specifies whether data in the cluster is
	// encrypted in transit.
	//
	// Optional, Memcached only
	//
	// +optional
	TransitEncryptionEnabled *bool `json:"transitEncryptionEnabled,omitempty"`

	// Usernames is a list of users to associate with the cluster.
	//
	// +optional
	Usernames []*string `json:"usernames,omitempty"`
}

// GlobalReplicationGroup
type GlobalReplicationGroup struct {
	// AutomaticFailoverEnabled specifies whether a read replica will be
	// automatically promoted to the primary cluster if the existing primary
	// cluster fails.
	//
	// +optional
	// +default=false
	AutomaticFailoverEnabled *bool `json:"automaticFailoverEnabled,omitempty"`

	// CacheNodeType is the instance class to use for the cache nodes.
	//
	// +optional
	CacheNodeType *string `json:"cacheNodeType,omitempty"`

	// Enabled is a flag that enables the global replication group.
	//
	// +optional
	// +default=false
	Enabled *bool `json:"enabled,omitempty"`

	// EngineVersion is the version number of the cache engine to be used for
	// the cluster. If not set this will default to the latest version.
	//
	// +optional
	EngineVersion *string `json:"engineVersion,omitempty"`

	// GlobalReplicationGroupIdSuffix is the suffix to append to the global
	// replication group id.
	//
	// +optional
	Suffix *string `json:"suffix,omitempty"`

	// NumNodeGroups is the number of node groups in the replication group.
	//
	// +optional
	NumNodeGroups *int64 `json:"numNodeGroups,omitempty"`

	// ParameterGroupName is the name of the parameter group to associate with
	// the global replication group.
	//
	// Required when upgrading to a new major engine version but subsequently
	// ignored.
	//
	// Specifying this parameter will result in an error if a major engine version
	// is not specified.
	//
	// +optional
	ParameterGroupName *string `json:"parameterGroupName,omitempty"`
}

// Repository type metadata.
var (
	CacheBaseKind      = "CacheBase"
	CacheBaseGroupKind = schema.GroupKind{
		Group: XRDGroup,
		Kind:  CacheBaseKind,
	}.String()
	CacheBaseKindAPIVersion   = CacheBaseKind + "." + GroupVersion.String()
	CacheBaseGroupVersionKind = GroupVersion.WithKind(CacheBaseKind)
)
