package v1alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

	xpv1 "github.com/crossplane/crossplane-runtime/apis/common/v1"
)

// +kubebuilder:object:root=true
// +kubebuilder:storageversion
// +genclient
// +genclient:nonNamespaced
//
// +kubebuilder:resource:scope=Cluster,categories=crossplane
// +kubebuilder:subresource:status
// +kubebuilder:resource:shortName=mzdc
// +crossbuilder:generate:xrd:claimNames:kind=MultiAzClusterClaim,plural=multiazclusterclaims
// +crossbuilder:generate:xrd:defaultCompositionRef:name=rds-cluster
// +crossbuilder:generate:xrd:enforcedCompositionRef:name=rds-cluster
type MultiAzDbCluster struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec   MultiAzDbSpec   `json:"spec"`
	Status MultiAzDbStatus `json:"status,omitempty"`
}

// +kubebuilder:object:root=true
type MultiAzDbList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata,omitempty"`
	Items           []MultiAzDbCluster `json:"items"`
}

// Defines the spec of a RDS cluster
type MultiAzDbSpec struct {
	xpv1.ResourceSpec `json:",inline"`
	ClusterParameters `json:",inline"`
}

// Defines the status of a RDS cluster
type MultiAzDbStatus struct {
	xpv1.ConditionedStatus `json:",inline"`

	// AccountId is the account ID of the DB cluster.
	//
	// +optional
	AccountId *string `json:"accountId,omitempty"`

	// ClusterIdentifier is the identifier of the DB cluster.
	//
	// +optional
	ClusterIdentifier *string `json:"clusterIdentifier,omitempty"`

	// ClusterArn is the ARN of the DB cluster.
	//
	// +optional
	ClusterArn *string `json:"clusterArn,omitempty"`

	// DbParameterGroupName is the name of the DB parameter group to associate
	// with this DB instance.
	//
	// +optional
	DbParameterGroupName *string `json:"dbParameterGroupName,omitempty"`

	// DbSubnetGroupName is the name of the DB subnet group to associate with
	// this DB instance.
	//
	// +optional
	DbSubnetGroupName *string `json:"dbSubnetGroupName,omitempty"`

	// Endpoint is the endpoint of the DB cluster.
	//
	// +optional
	Endpoint *string `json:"endpoint,omitempty"`

	// KmsKeyID is the ID of the KMS key.
	//
	// +optional
	KmsKeyID *string `json:"kmsKeyID,omitempty"`

	// MonitoringRoleArn is the ARN of the monitoring role.
	//
	// +optional
	MonitoringRoleArn *string `json:"monitoringRoleArn,omitempty"`

	// port is the port of the database.
	//
	// +optional
	Port *int64 `json:"port,omitempty"`

	// SecurityGroupIds A list of VPC security group IDs for the cluster
	//
	// +optional
	// +listType=set
	SecurityGroupIds []*string `json:"securityGroupIds,omitempty"`
}

type MultiAzDbRole struct {
	// FeatureName is the name of the feature.
	//
	// +optional
	FeatureName *string `json:"featureName,omitempty"`

	// RoleArn is the ARN of the role.
	//
	// +optional
	RoleArn *string `json:"roleArn,omitempty"`
}

type ActivityStream struct {
	// Enabled is whether activity stream is enabled.
	//
	// +optional
	// +default=false
	Enabled *bool `json:"enabled,omitempty"`

	// EngineNativeAuditFieldsIncluded is whether engine native audit fields are
	// included. This option only applies to Oracle databases.
	//
	// +optional
	// +default=false
	EngineNativeAuditFieldsIncluded *bool `json:"engineNativeAuditFieldsIncluded,omitempty"`

	// Mode is the mode of the activity stream. Valid values are `sync` and `async`.
	//
	// +optional
	// +default="sync"
	// +kubebuilder:validation:Enum=sync;async
	Mode *string `json:"mode,omitempty"`
}

type Autoscaling struct {
	// Autoscaling is whether autoscaling is enabled.
	//
	// +optional
	// +default=false
	Enabled *bool `json:"enabled,omitempty"`

	// MaxCapacity is the maximum capacity for autoscaling.
	//
	// +optional
	// +default=2
	MaxCapacity *int64 `json:"maxCapacity,omitempty"`

	// MinCapacity is the minimum capacity for autoscaling.
	//
	// +optional
	// +default=0
	MinCapacity *int64 `json:"minCapacity,omitempty"`

	// MetricType is the type of metric to use for autoscaling.
	//
	// +optional
	// +default="RDSReaderAverageCPUUtilization"
	// +kubebuilder:validation:Enum=RDSReaderAverageCPUUtilization;RDSReaderAverageDatabaseConnections
	MetricType *string `json:"metricType,omitempty"`

	// PolicyName is the name of the autoscaling policy.
	//
	// +optional
	// +default="target-metric"
	PolicyName *string `json:"policyName,omitempty"`

	// ScaleInCooldown is the amount of time, in seconds, after a scaling in
	// activity completes before another scaling activity can start.
	//
	// +optional
	// +default=300
	ScaleInCooldown *int64 `json:"scaleInCooldown,omitempty"`

	// ScaleOutCooldown is the amount of time, in seconds, after a scaling out
	// activity completes before another scaling activity can start.
	//
	// +optional
	// +default=300
	ScaleOutCooldown *int64 `json:"scaleOutCooldown,omitempty"`

	// TargetCPU is CPU threshold which will initiate autoscaling.
	//
	// +optional
	// +default=70
	TargetCPU *int64 `json:"targetCPU,omitempty"`

	// TargetConnections is the average number of connections threshold which
	// will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
	// default max_connections
	//
	// +optional
	// +default=700
	TargetConnections *int64 `json:"targetConnections,omitempty"`
}

type CloudwatchLogGroup struct {

	// Class is the class of the log group.
	//
	// +optional
	// +kube:validation:Enum=STANDARD;INFREQUENT_ACCESS
	Class *string `json:"class,omitempty"`

	// Create is whether the log group is to be created.
	//
	// +optional
	// +default=false
	Create *bool `json:"create,omitempty"`

	// RetentionInDays is the number of days to retain logs for.
	//
	// +optional
	// +default=0
	RetentionInDays *int64 `json:"retentionInDays,omitempty"`

	// SkipDestroy is whether the log group should be skipped during destroy.
	//
	// +optional
	// +default=false
	SkipDestroy *bool `json:"skipDestroy,omitempty"`
}

type ClusterInstance struct {
	// ApplyImmediately is whether changes should be applied immediately.
	//
	// +optional
	// +nullable
	ApplyImmediately *bool `json:"applyImmediately,omitempty"`

	// AutoMinorVersionUpgrade is whether minor version upgrades are applied
	// automatically.
	//
	// +optional
	// +nullable
	AutoMinorVersionUpgrade *bool `json:"autoMinorVersionUpgrade,omitempty"`

	// AvailabilityZone is the availability zone to use.
	//
	// +optional
	// +nullable
	AvailabilityZone *string `json:"availabilityZone,omitempty"`

	// CopyTagsToSnapshot is whether tags should be copied to snapshots.
	//
	// +optional
	// +nullable
	CopyTagsToSnapshot *bool `json:"copyTagsToSnapshot,omitempty"`

	// InstanceClass is the instance class to use.
	//
	// +optional
	// +nullable
	InstanceClass *string `json:"instanceClass,omitempty"`

	// MonitoringInterval is the interval, in seconds, between points when
	// Enhanced Monitoring metrics are collected for the DB instance.
	//
	// +optional
	// +nullable
	MonitoringInterval *int64 `json:"monitoringInterval,omitempty"`

	// MultiAZ is whether the DB instance is a Multi-AZ deployment.
	//
	// +optional
	// +nullable
	MultiAZ *bool `json:"multiAZ,omitempty"`

	// ParameterGroupName is the name of the DB parameter group to associate
	// with this DB instance. Must pre-exist in the account. Mutually exclusive
	// with `MultiAzDbCluster.dbParameterGroup`
	//
	// +optional
	// +nullable
	ParameterGroupName *string `json:"parameterGroupName,omitempty"`

	// PerformanceInsightsEnabled is whether Performance Insights is enabled.
	//
	// +optional
	// +nullable
	PerformanceInsightsEnabled *bool `json:"performanceInsightsEnabled,omitempty"`

	// PerformanceInsightsKMSKeyID is the AWS KMS key identifier for encryption
	// of Performance Insights data.
	//
	// +optional
	// +nullable
	PerformanceInsightsKMSKeyID *string `json:"performanceInsightsKMSKeyID,omitempty"`

	// PerformanceInsightsRetentionPeriod is the amount of time, in days, to
	// retain Performance Insights data.
	//
	// +optional
	// +nullable
	PerformanceInsightsRetentionPeriod *int64 `json:"performanceInsightsRetentionPeriod,omitempty"`

	// PreferredMaintenanceWindow is the preferred maintenance window.
	//
	// +optional
	// +nullable
	PreferredMaintenanceWindow *string `json:"preferredMaintenanceWindow,omitempty"`

	// PromotionTier is the order in which to promote an Aurora replica to the
	// primary instance.
	//
	// +optional
	// +nullable
	PromotionTier *int64 `json:"promotionTier,omitempty"`

	// PubliclyAccessible is whether the DB instance is publicly accessible.
	//
	// +optional
	// +nullable
	PubliclyAccessible *bool `json:"publiclyAccessible,omitempty"`

	// Tags is a set of tags to associate with the DB instance.
	//
	// +optional
	// +nullable
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]*string `json:"tags,omitempty"`
}

type ClusterParameterGroup struct {
	// ApplyMethod is the apply method for the parameter group. Some engines
	// cannot apply changes immediately, and require a reboot in which case you
	// must set this value to `pending-reboot`.
	//
	// +optional
	// +default="immediate"
	// +kubebuilder:validation:Enum=immediate;pending-reboot
	ApplyMethod *string `json:"applyMethod,omitempty"`

	// Description is the description of the parameter group.
	//
	// +optional
	Description *string `json:"description,omitempty"`

	// Create is whether the parameter group is to be created.
	//
	// +optional
	// +default=false
	Create *bool `json:"create,omitempty"`

	// Family is the family of the parameter group.
	//
	// +optional
	Family *string `json:"family,omitempty"`

	// Name is the name of the parameter group.
	//
	// +optional
	Name *string `json:"name,omitempty"`

	// Parameters is a list of parameters to associate with the parameter group.
	// Note that parameters may differ between families
	//
	// +optional
	Parameters []*Parameter `json:"parameters,omitempty"`

	// Tags is a set of tags to associate with the parameter group.
	//
	// +optional
	// +kubebuilder:mapType=granular
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]*string `json:"tags,omitempty"`
}

type ClusterParameters struct {
	// ActivityStream is the activity stream configuration.
	//
	// +optional
	ActivityStream *ActivityStream `json:"activityStream,omitempty"`

	// AllocatedStorage is the size of the database.
	//
	// +optional
	// +default=10
	AllocatedStorage *int64 `json:"allocatedStorage,omitempty"`

	// AllowMajorVersionUpgrade is whether major version upgrades are allowed.
	//
	// +optional
	// +default=false
	AllowMajorVersionUpgrade *bool `json:"allowMajorVersionUpgrade,omitempty"`

	// ApplyImmediately is whether changes should be applied immediately.
	//
	// +optional
	// +default=false
	ApplyImmediately *bool `json:"applyImmediately,omitempty"`

	// AutoMinorVersionUpgrade is whether minor version upgrades are applied
	// automatically. This value can be overridden on a per instance basis.
	//
	// +optional
	// +default=true
	AutoMinorVersionUpgrade *bool `json:"autoMinorVersionUpgrade,omitempty"`

	// Autoscaling is the autoscaling configuration.
	//
	// +optional
	Autoscaling *Autoscaling `json:"autoscaling,omitempty"`

	// AvailabilityZones is a list of availability zone to use.
	//
	// +optional
	AvailabilityZones []*string `json:"availabilityZones,omitempty"`

	// BackupRetentionPeriod is the number of days to retain backups for.
	//
	// +optional
	// +default=0
	BackupRetentionPeriod *int64 `json:"backupRetentionPeriod,omitempty"`

	// BacktrackWindow is the target backtrack window, in seconds.
	// Only available for Aurora engine. To disable backtracking, set this value to 0.
	//
	// +optional
	// +default=0
	// +kubebuilder:validation:Minimum=0
	// +kubebuilder:validation:Maximum=259200
	BacktrackWindow *int64 `json:"backtrackWindow,omitempty"`

	// CidrBlocks is a list of CIDRs that are allowed to connect to the DB.
	//
	// +required
	CidrBlocks []*string `json:"cidrBlocks"`

	// CopyTagsToSnapshot is whether tags should be copied to snapshots.
	//
	// +optional
	// +default=false
	CopyTagsToSnapshot *bool `json:"copyTagsToSnapshot,omitempty"`

	// DbClusterInstanceClass is the instance class to use.
	//
	// +optional
	// +default="db.t4g.medium"
	DbClusterInstanceClass *string `json:"dbClusterInstanceClass,omitempty"`

	// DbClusterParameterGroup defines the parameters for the DB cluster.
	//
	// +required
	DbClusterParameterGroup *ClusterParameterGroup `json:"dbClusterParameterGroup"`

	// DbParameterGroup defines the parameters for the DB instance.
	//
	// +optional
	DbParameterGroup *DbParameterGroup `json:"dbParameterGroup,omitempty"`

	// DbSubnetGroupName is the name of the DB subnet group to associate with this DB cluster.
	//
	// +optional
	DbSubnetGroupName *string `json:"dbSubnetGroupName,omitempty"`

	// DeleteAutomatedBackups is whether automated backups should be deleted.
	//
	// +optional
	// +default=false
	DeleteAutomatedBackups *bool `json:"deleteAutomatedBackups,omitempty"`

	// DeletionProtection is whether deletion protection is enabled.
	//
	// +optional
	// +default=false
	DeletionProtection *bool `json:"deletionProtection,omitempty"`

	// Domain is the domain to use.
	//
	// +optional
	Domain *string `json:"domain,omitempty"`

	// DomainIAMRoleName is the name of the IAM role to use.
	//
	// +optional
	DomainIAMRoleName *string `json:"domainIAMRoleName,omitempty"`

	// EnableGlobalWriteForwarding is whether global write forwarding is enabled.
	//
	// +optional
	// +default=false
	EnableGlobalWriteForwarding *bool `json:"enableGlobalWriteForwarding,omitempty"`

	// EnableHttpEndpoint is whether the HTTP endpoint is enabled.
	//
	// +optional
	// +default=false
	EnableHttpEndpoint *bool `json:"enableHttpEndpoint,omitempty"`

	// EnableLocalWriteForwarding is whether local write forwarding is enabled.
	//
	// +optional
	// +default=false
	EnableLocalWriteForwarding *bool `json:"enableLocalWriteForwarding,omitempty"`

	// EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
	//
	// +optional
	EnabledCloudwatchLogsExports []*LogGroup `json:"enabledCloudwatchLogsExports,omitempty"`

	// EnhancedMonitoring is the enhanced monitoring configuration.
	//
	// +optional
	EnhancedMonitoring *EnhancedMonitoring `json:"enhancedMonitoring,omitempty"`

	// Endpoints is a list of custom endpoints to create.
	//
	// +optional
	Endpoints []*Endpoint `json:"endpoints,omitempty"`

	// Engine is the database engine to use.
	//
	// +required
	Engine *string `json:"engine,omitempty"`

	// EngineMode is the database engine mode to use.
	//
	// +optional
	// +default="provisioned"
	// +kubebuilder:validation:Enum=parallelquery;provisioned;serverless
	EngineMode *string `json:"engineMode,omitempty"`

	// EngineVersion is the version of the database engine to use.
	//
	// +required
	EngineVersion *string `json:"version,omitempty"`

	// GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.
	//
	// +optional
	GlobalClusterIdentifier *string `json:"globalClusterIdentifier,omitempty"`

	// IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
	//
	// +optional
	// +default=false
	IAMDatabaseAuthenticationEnabled *bool `json:"iamDatabaseAuthenticationEnabled,omitempty"`

	// IamRoles is a list of IAM roles to associate with the DB cluster.
	//
	// +optional
	IamRoles []*MultiAzDbRole `json:"iamRoles,omitempty"`

	// Iops is the amount of provisioned IOPS.
	//
	// +optional
	// +default=0
	Iops *int64 `json:"iops,omitempty"`

	// Instances is a list of instances to create.
	//
	// +required
	// +kubebuilder:validation:MinItems=1
	Instances []*ClusterInstance `json:"instances,omitempty"`

	// InstanceClass is the instance class to use.
	//
	// +optional
	InstanceClass *string `json:"instanceClass,omitempty"`

	// CloudwatchLogGroup defines the parameters for the log groups
	//
	// +optional
	CloudwatchLogGroupParameters *CloudwatchLogGroup `json:"cloudwatchLogGroupParameters,omitempty"`

	// MasterUsername is the master username to use.
	//
	// +required
	MasterUsername *string `json:"masterUsername,omitempty"`

	// MultiAZ is whether the DB instance is a Multi-AZ deployment.
	//
	// +optional
	// +default=false
	MultiAZ *bool `json:"multiAZ,omitempty"`

	// Partition is the AWS partition to use.
	//
	// +optional
	// +default="aws"
	// +kubebuilder:validation:Enum=aws;aws-cn;aws-us-gov
	Partition *string `json:"partition,omitempty"`

	// PerformanceInsightsEnabled is whether Performance Insights is enabled.
	//
	// +optional
	PerformanceInsightsEnabled *bool `json:"performanceInsightsEnabled,omitempty"`

	// PerformanceInsightsKMSKeyID is the AWS KMS key identifier for encryption of Performance Insights data.
	//
	// +optional
	PerformanceInsightsKMSKeyID *string `json:"performanceInsightsKMSKeyID,omitempty"`

	// PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.
	//
	// +optional
	PerformanceInsightsRetentionPeriod *int64 `json:"performanceInsightsRetentionPeriod,omitempty"`

	// PreferredBackupWindow is the preferred backup window.
	//
	// +optional
	PreferredBackupWindow *string `json:"preferredBackupWindow,omitempty"`

	// PreferredMaintenanceWindow is the preferred maintenance window.
	//
	// +optional
	PreferredMaintenanceWindow *string `json:"preferredMaintenanceWindow,omitempty"`

	// PubliclyAccessible is whether the DB instance is publicly accessible.
	//
	// +optional
	// +default=false
	PubliclyAccessible *bool `json:"publiclyAccessible,omitempty"`

	// Region is the region to use.
	//
	// +required
	Region *string `json:"region,omitempty"`

	// ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
	// this DB cluster is to be created as a Read Replica
	//
	// +optional
	ReplicationSourceIdentifier *string `json:"replicationSourceIdentifier,omitempty"`

	// RestoreToPointInTime is the point in time to restore to.
	//
	// +optional
	RestoreToPointInTime *RestoreToPointInTime `json:"restoreToPointInTime,omitempty"`

	// S3Import is the S3 import configuration.
	//
	// +optional
	S3Import *S3Import `json:"s3Import,omitempty"`

	// ScalingConfiguration is the scaling configuration.
	//
	// +optional
	ScalingConfiguration *ScalingConfiguration `json:"scalingConfiguration,omitempty"`

	// SecretRotation is the secret rotation configuration.
	//
	// +optional
	SecretRotation *SecretRotation `json:"secretRotation,omitempty"`

	// ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.
	//
	// +optional
	ServerlessV2ScalingConfiguration *ServerlessV2ScalingConfiguration `json:"serverlessV2ScalingConfiguration,omitempty"`

	// StorageType specifies the storage type to be associated with the cluster
	//
	// +optional
	StorageType *string `json:"storageType,omitempty"`

	// SubnetIds is a list of subnet IDs to use for the subnet group.
	//
	// +required
	SubnetIds []*string `json:"subnetIds"`

	// Tags is a set of tags to associate with the DB cluster.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]*string `json:"tags,omitempty"`

	// VpcId is the VPC ID to use.
	//
	// +required
	VpcId *string `json:"vpcId"`
}

type Endpoint struct {
	// CustomEndpointType is the type of the custom endpoint.
	//
	// +optional
	// +kubebuilder:validation:Enum=READER;ANY
	// +default=ANY
	CustomEndpointType *string `json:"customEndpointType,omitempty"`

	// ExcludedMembers is a list of DB instances that aren't part of the custom
	// endpoint group.
	//
	// +optional
	ExcludedMembers []*string `json:"excludedMembers,omitempty"`

	// StaticMembers is a list of DB instances that are part of the custom
	// endpoint group.
	//
	// +optional
	StaticMembers []*string `json:"staticMembers,omitempty"`

	// Tags is a set of tags to associate with the custom endpoint.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]*string `json:"tags,omitempty"`
}

type EnhancedMonitoring struct {

	// Description is the description of the monitoring role.
	//
	// +optional
	Description *string `json:"description,omitempty"`

	// Enabled is whether enhanced monitoring is enabled.
	//
	// +optional
	// +default=false
	Enabled *bool `json:"enabled,omitempty"`

	// ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it
	//
	// +optional
	// +default=false
	ForceDetachPolicies *bool `json:"forceDetachPolicies,omitempty"`

	// ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.
	//
	// +optional
	ManagedPolicyArns []*string `json:"managedPolicyArns,omitempty"`

	// PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.
	//
	// +optional
	PermissionsBoundary *string `json:"permissionsBoundary,omitempty"`

	// MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.
	//
	// +optional
	MaxSessionDuration *int64 `json:"maxSessionDuration,omitempty"`

	// MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.
	//
	// +optional
	MonitoringInterval *int64 `json:"monitoringInterval,omitempty"`

	// Path is the path of the monitoring role.
	//
	// +optional
	Path *string `json:"path,omitempty"`
}

type DbParameterGroup struct {
	// Description is the description of the parameter group.
	//
	// +optional
	Description *string `json:"description,omitempty"`

	// Create is whether the parameter group is created.
	//
	// +optional
	// +default=false
	Create *bool `json:"create,omitempty"`

	// Family is the family of the parameter group.
	//
	// +optional
	Family *string `json:"family,omitempty"`

	// Name is the name of the parameter group.
	//
	// +required
	Name *string `json:"name,omitempty"`

	// Parameters is a list of parameters to associate with the parameter group.
	// Note that parameters may differ between families
	//
	// +optional
	Parameters []*Parameter `json:"parameters,omitempty"`

	// Tags is a set of tags to associate with the parameter group.
	//
	// +optional
	// +kubebuilder:validation:MaxProperties=50
	Tags map[string]*string `json:"tags,omitempty"`
}

// LogGroup is the name of a log group.
//
// +kubebuilder:validation:Pattern=^[a-zA-Z0-9_]*$
// +kubebuilder:validation:Enum=audit;error;general;slowquery;postgresql
type LogGroup string

// Parameter is a parameter to associate with a parameter group.
//
// +kubebuilder:validation:Pattern=^[a-zA-Z0-9_]*$
type Parameter string

// RestoreToPointInTime is the point in time to restore to.
type RestoreToPointInTime struct {
	// RestoreToTime is the time to restore to.
	//
	// +optional
	RestoreToTime *metav1.Time `json:"restoreToTime,omitempty"`

	// UseLatestRestorableTime is whether to use the latest restorable time.
	//
	// +optional
	// +default=false
	UseLatestRestorableTime *bool `json:"useLatestRestorableTime,omitempty"`

	// RestoreType is the type of restore to perform.
	//
	// +optional
	// +default="full-copy"
	// +kubebuilder:validation:Enum=full-copy;copy-on-write
	RestoreType *string `json:"restoreType,omitempty"`

	// SourceDbClusterIdentifier is the identifier of the source DB cluster.
	//
	// +optional
	SourceDbClusterIdentifier *string `json:"sourceDbClusterIdentifier,omitempty"`
}

// S3Import is the S3 import configuration.
type S3Import struct {
	// BucketName is the name of the S3 bucket.
	//
	// +optional
	BucketName *string `json:"bucketName,omitempty"`

	// BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
	// within the bucket where the data is located.
	//
	// +optional
	BucketPrefix *string `json:"bucketPrefix,omitempty"`

	// IngestionRole is the role to use for ingestion.
	//
	// +optional
	IngestionRole *string `json:"ingestionRole,omitempty"`

	// SourceEngine is the source engine to use.
	//
	// +optional
	SourceEngine *string `json:"sourceEngine,omitempty"`

	// SourceEngineVersion is the source engine version to use.
	//
	// +optional
	SourceEngineVersion *string `json:"sourceEngineVersion,omitempty"`
}

// SecretRotation is the secret rotation configuration.
type SecretRotation struct {
	// Enabled is whether secret rotation is enabled.
	//
	// +optional
	// +default=false
	Enabled *bool `json:"enabled,omitempty"`

	// AutomaticallyAfterDays is the number of days after which the secret is
	// rotated automatically.
	//
	// +optional
	AutomaticallyAfterDays *int64 `json:"automaticallyAfterDays,omitempty"`

	// RotateImmediately is whether the secret should be rotated immediately.
	//
	// +optional
	// +default=true
	RotateImmediately *bool `json:"rotateImmediately,omitempty"`

	// ScheduleExpression is the schedule expression for secret rotation.
	//
	// +optional
	ScheduleExpression *string `json:"scheduleExpression,omitempty"`
}

// ScalingConfiguration is the scaling configuration for serverless databases.
type ScalingConfiguration struct {
	// AutoPause is whether the database should automatically pause.
	//
	// +optional
	AutoPause *bool `json:"autoPause,omitempty"`

	// MaxCapacity is the maximum capacity for the database.
	//
	// +optional
	MaxCapacity *int64 `json:"maxCapacity,omitempty"`

	// MinCapacity is the minimum capacity for the database.
	//
	// +optional
	MinCapacity *int64 `json:"minCapacity,omitempty"`

	// SecondsUntilAutoPause is the number of seconds until the database
	// automatically pauses.
	//
	// +optional
	SecondsUntilAutoPause *int64 `json:"secondsUntilAutoPause,omitempty"`
}

// ServerlessV2ScalingConfiguration is the scaling configuration for serverless databases.
type ServerlessV2ScalingConfiguration struct {
	// MaxCapacity is the maximum capacity for the database.
	//
	// +optional
	MaxCapacity *int64 `json:"maxCapacity,omitempty"`

	// MinCapacity is the minimum capacity for the database.
	//
	// +optional
	MinCapacity *int64 `json:"minCapacity,omitempty"`
}
