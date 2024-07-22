---
title: RdsBase CRD schema reference (group xdatabase.crossplane.giantswarm.io)
linkTitle: RdsBase
description: |
  Custom resource definition (CRD) schema reference page for the RdsBase resource (rdsbases.xdatabase.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: RdsBaseClaim
  claim_name_plural: rdsbaseclaims
  default_composition_ref: rds-base
  enforced_composition_ref: rds-base
  name_camelcase: RdsBase
  name_plural: rdsbases
  name_singular: rdsbase
  short_names:
    - rdb
  group: xdatabase.crossplane.giantswarm.io
  technical_name: rdsbases.xdatabase.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - crossplane
    - database
    - rds
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/rdsbases.xdatabase.crossplane.giantswarm.io/
technical_name: rdsbases.xdatabase.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# RdsBase

<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">rdsbases.xdatabase.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">RdsBaseClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">rdsbaseclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">rds-base</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">rds-base</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xdatabase.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">rdsbase</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">
  <ul>
  
  <li>rdb</li>
  
</dd>

<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">rdsbases</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



## Version `v1alpha1`


### Spec Properties
<h4>.spec.activityStream</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ActivityStream is the activity stream configuration.
<h4>.spec.activityStream.enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether activity stream is enabled.
<h4>.spec.activityStream.engineNativeAuditFieldsIncluded</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EngineNativeAuditFieldsIncluded is whether engine native audit fields are
  included. This option only applies to Oracle databases.
<h4>.spec.activityStream.mode</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- sync
- async

Mode is the mode of the activity stream. Valid values are `sync` and `async`.
<h4>.spec.allocatedStorage</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
<h4>.spec.allowMajorVersionUpgrade</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
<h4>.spec.applyImmediately</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
<h4>.spec.autoMinorVersionUpgrade</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically. This value can be overridden on a per instance basis.
<h4>.spec.autoscaling</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Autoscaling is the autoscaling configuration.
<h4>.spec.autoscaling.enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Autoscaling is whether autoscaling is enabled.
<h4>.spec.autoscaling.maxCapacity</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for autoscaling.
<h4>.spec.autoscaling.metricType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- RDSReaderAverageCPUUtilization
- RDSReaderAverageDatabaseConnections

MetricType is the type of metric to use for autoscaling.
<h4>.spec.autoscaling.minCapacity</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for autoscaling.
<h4>.spec.autoscaling.policyName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PolicyName is the name of the autoscaling policy.
<h4>.spec.autoscaling.scaleInCooldown</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleInCooldown is the amount of time, in seconds, after a scaling in
  activity completes before another scaling activity can start.
<h4>.spec.autoscaling.scaleOutCooldown</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleOutCooldown is the amount of time, in seconds, after a scaling out
  activity completes before another scaling activity can start.
<h4>.spec.autoscaling.targetCPU</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetCPU is CPU threshold which will initiate autoscaling.
<h4>.spec.autoscaling.targetConnections</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetConnections is the average number of connections threshold which
  will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
  default max_connections
<h4>.spec.availabilityZones</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


AvailabilityZones is a list of availability zone to use.
<h4>.spec.availabilityZones[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.backtrackWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BacktrackWindow is the target backtrack window, in seconds.
  Only available for Aurora engine. To disable backtracking, set this value to 0.
<h4>.spec.backupRetentionPeriod</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
<h4>.spec.cidrBlocks</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CidrBlocks is a list of CIDRs that are allowed to connect to the DB.
<h4>.spec.cidrBlocks[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.cloudwatchLogGroupParameters</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


CloudwatchLogGroup defines the parameters for the log groups
<h4>.spec.cloudwatchLogGroupParameters.class</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Class is the class of the log group.
<h4>.spec.cloudwatchLogGroupParameters.create</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the log group is to be created.
<h4>.spec.cloudwatchLogGroupParameters.retentionInDays</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RetentionInDays is the number of days to retain logs for.
<h4>.spec.cloudwatchLogGroupParameters.skipDestroy</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipDestroy is whether the log group should be skipped during destroy.
<h4>.spec.copyTagsToSnapshot</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
<h4>.spec.createCluster</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateCluster is whether the cluster should be created.
  By default this is true but for non-aurora clusters, the DB Cluster
  resource is optional and can be omitted. In this case, the DB instances
  will be created as `instance.rds` types.
<h4>.spec.databaseName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
<h4>.spec.databases</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Databases is a map of databases to create.
<h4>.spec.dbClusterInstanceClass</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbClusterInstanceClass is the instance class to use.
<h4>.spec.dbClusterParameterGroup</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbClusterParameterGroup defines the parameters for the DB cluster.
<h4>.spec.dbClusterParameterGroup.applyMethod</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- immediate
- pending-reboot

ApplyMethod is the apply method for the parameter group. Some engines
  cannot apply changes immediately, and require a reboot in which case you
  must set this value to `pending-reboot`.
<h4>.spec.dbClusterParameterGroup.create</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is to be created.
<h4>.spec.dbClusterParameterGroup.description</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
<h4>.spec.dbClusterParameterGroup.family</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
<h4>.spec.dbClusterParameterGroup.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
<h4>.spec.dbClusterParameterGroup.parameters</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families
<h4>.spec.dbClusterParameterGroup.parameters[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.
<h4>.spec.dbClusterParameterGroup.tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
<h4>.spec.dbParameterGroup</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbParameterGroup defines the parameters for the DB instance.
<h4>.spec.dbParameterGroup.create</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is created.
<h4>.spec.dbParameterGroup.description</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
<h4>.spec.dbParameterGroup.family</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
<h4>.spec.dbParameterGroup.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
<h4>.spec.dbParameterGroup.parameters</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families
<h4>.spec.dbParameterGroup.parameters[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.
<h4>.spec.dbParameterGroup.tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
<h4>.spec.deleteAutomatedBackups</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
<h4>.spec.deletionPolicy</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|Delete|


Allowed Values:
- Orphan
- Delete

DeletionPolicy specifies what will happen to the underlying external
  when this managed resource is deleted - either "Delete" or "Orphan" the
  external resource.
  This field is planned to be deprecated in favor of the ManagementPolicies
  field in a future release. Currently, both could be set independently and
  non-default values would be honored if the feature flag is enabled.
  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
<h4>.spec.deletionProtection</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
<h4>.spec.domain</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Domain is the domain to use.
<h4>.spec.domainIAMRoleName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIAMRoleName is the name of the IAM role to use.
<h4>.spec.enableGlobalWriteForwarding</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableGlobalWriteForwarding is whether global write forwarding is enabled.
<h4>.spec.enableHttpEndpoint</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableHttpEndpoint is whether the HTTP endpoint is enabled.
<h4>.spec.enableLocalWriteForwarding</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableLocalWriteForwarding is whether local write forwarding is enabled.
<h4>.spec.enabledCloudwatchLogsExports</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
<h4>.spec.enabledCloudwatchLogsExports[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
<h4>.spec.endpoints</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Endpoints is a list of custom endpoints to create.
<h4>.spec.endpoints[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>.spec.endpoints[*].customEndpointType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- READER
- ANY

CustomEndpointType is the type of the custom endpoint.
<h4>.spec.endpoints[*].excludedMembers</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludedMembers is a list of DB instances that aren't part of the custom
  endpoint group.
<h4>.spec.endpoints[*].excludedMembers[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.endpoints[*].staticMembers</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


StaticMembers is a list of DB instances that are part of the custom
  endpoint group.
<h4>.spec.endpoints[*].staticMembers[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.endpoints[*].tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the custom endpoint.
<h4>.spec.engine</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Engine is the database engine to use.
<h4>.spec.engineMode</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- parallelquery
- provisioned
- serverless

EngineMode is the database engine mode to use.
<h4>.spec.engineVersion</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version of the database engine to use.
<h4>.spec.enhancedMonitoring</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


EnhancedMonitoring is the enhanced monitoring configuration.
<h4>.spec.enhancedMonitoring.description</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the monitoring role.
<h4>.spec.enhancedMonitoring.enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether enhanced monitoring is enabled.
<h4>.spec.enhancedMonitoring.forceDetachPolicies</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it
<h4>.spec.enhancedMonitoring.managedPolicyArns</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.
<h4>.spec.enhancedMonitoring.managedPolicyArns[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.enhancedMonitoring.maxSessionDuration</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.
<h4>.spec.enhancedMonitoring.monitoringInterval</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.
<h4>.spec.enhancedMonitoring.path</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Path is the path of the monitoring role.
<h4>.spec.enhancedMonitoring.permissionsBoundary</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.
<h4>.spec.eso</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Eso is the ESO configuration.
  
  
  This field is used to sync secrets using `external-secrets-operator`.
  External Secrets Operator must be installed if this value is set to true
<h4>.spec.eso.enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled Whether or not to enable `external-secrets-operator` object
  deployments using `provider-kubernetes.
<h4>.spec.eso.kubernetesSecretStore</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KubernetesSecretStore is the Kubernetes secret store to use.
  
  
  The kubernetes secret store is expected to be namespace scoped to prevent
  secrets leaking across namespaces.
<h4>.spec.eso.stores</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Stores is a list of secret stores to use for push secrets.
<h4>.spec.eso.stores[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretsStore is a reference to a secrets store to be passed to External
  Secrets Operator for creating PushSecrets
<h4>.spec.eso.stores[*].enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether the secrets store is enabled.
<h4>.spec.eso.stores[*].isClusterSecretStore</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IsClusterSecretStore is whether the secret store is a cluster secret store.
<h4>.spec.eso.stores[*].secretStore</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


SecretStoreName is the name of the secret store.
<h4>.spec.globalClusterIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.
<h4>.spec.iamDatabaseAuthenticationEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
<h4>.spec.iamRoles</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


IamRoles is a list of IAM roles to associate with the DB cluster.
<h4>.spec.iamRoles[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>.spec.iamRoles[*].featureName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FeatureName is the name of the feature.
<h4>.spec.iamRoles[*].roleArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RoleArn is the ARN of the role.
<h4>.spec.instanceCount</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


InstanceCount is the number of instances to create.
  
  
  If set, this value will create the requested number of instances using
  defaults from the cluster configuration. If `instances` are specified,
  this value is ignored.
<h4>.spec.instances</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Instances is a list of instances to create.
<h4>.spec.instances[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>.spec.instances[*].allocatedStorage</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllocatedStorage`
<h4>.spec.instances[*].allowMajorVersionUpgrade</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllowMajorVersionUpgrade`
<h4>.spec.instances[*].applyImmediately</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
  
  
  Overrides `ClusterParameters.ApplyImmediately`
<h4>.spec.instances[*].autoMinorVersionUpgrade</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically.
  
  
  Overrides `ClusterParameters.AutoMinorVersionUpgrade`
<h4>.spec.instances[*].availabilityZone</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the availability zone for this instance.
  Ignored if `multiAz` is true
<h4>.spec.instances[*].backupRetentionPeriod</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].copyTagsToSnapshot</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
<h4>.spec.instances[*].databaseName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
<h4>.spec.instances[*].deleteAutomatedBackups</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].deletionProtection</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].domainIamRoleName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIamRoleName is the name of the IAM role to use.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].enabledCloudwatchLogsExports</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].enabledCloudwatchLogsExports[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
<h4>.spec.instances[*].finalSnapshotIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the identifier of the final snapshot.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].iamDatabaseAuthenticationEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IamDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].instanceClass</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


InstanceClass is the instance class to use.
<h4>.spec.instances[*].iops</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].licenseModel</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LicenseModel is the license model to use.
  
  
  Only applicable if not running in cluster mode.
<h4>.spec.instances[*].monitoringInterval</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when
  Enhanced Monitoring metrics are collected for the DB instance.
<h4>.spec.instances[*].multiAz</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].networkType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NetworkType is the network type to use.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].optionGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


OptionGroupName is the name of the option group to associate with this DB
  instance.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].parameterGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the DB parameter group to associate
  with this DB instance. Must pre-exist in the account. Mutually exclusive
  with `RdsBaseDbCluster.dbParameterGroup`
<h4>.spec.instances[*].performanceInsightsEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
<h4>.spec.instances[*].performanceInsightsKmsKeyID</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption
  of Performance Insights data.
<h4>.spec.instances[*].performanceInsightsRetentionPeriod</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to
  retain Performance Insights data.
<h4>.spec.instances[*].preferredMaintenanceWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
<h4>.spec.instances[*].promotionTier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PromotionTier is the order in which to promote an Aurora replica to the
  primary instance.
<h4>.spec.instances[*].publiclyAccessible</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
<h4>.spec.instances[*].skipFinalSnapshot</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipFinalSnapshot is whether to skip the final snapshot.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].storageEncrypted</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


StorageEncrypted is whether storage is encrypted.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].storageThroughput</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


StorageThroughput is the amount of storage throughput. Only applicable if
  `storageType` is `gp3`
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].storageType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType is the storage type to use.
  
  
  Only applicable if not running in cluster mode
<h4>.spec.instances[*].tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB instance.
<h4>.spec.iops</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
<h4>.spec.kubernetesProviderConfig</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


KubernetesProviderConfig is the provider config for the Kubernetes provider.
<h4>.spec.kubernetesProviderConfig.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


<h4>.spec.managementPolicies</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|
|Default Value|[*]|


THIS IS A BETA FIELD. It is on by default but can be opted out
  through a Crossplane feature flag.
  ManagementPolicies specify the array of actions Crossplane is allowed to
  take on the managed and external resources.
  This field is planned to replace the DeletionPolicy field in a future
  release. Currently, both could be set independently and non-default
  values would be honored if the feature flag is enabled. If both are
  custom, the DeletionPolicy field will be ignored.
  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
  and this one: https://github.com/crossplane/crossplane/blob/444267e84783136daa93568b364a5f01228cacbe/design/one-pager-ignore-changes.md
<h4>.spec.managementPolicies[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.
<h4>.spec.masterUsername</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MasterUsername is the master username to use.
<h4>.spec.multiAz</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
<h4>.spec.partition</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- aws
- aws-cn
- aws-us-gov

Partition is the AWS partition to use.
<h4>.spec.performanceInsightsEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
<h4>.spec.performanceInsightsKmsKeyID</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.
<h4>.spec.performanceInsightsRetentionPeriod</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.
<h4>.spec.preferredBackupWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredBackupWindow is the preferred backup window.
<h4>.spec.preferredMaintenanceWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
<h4>.spec.providerConfigRef</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.
<h4>.spec.providerConfigRef.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>.spec.providerConfigRef.policy</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>.spec.providerConfigRef.policy.resolution</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|Required|


Allowed Values:
- Required
- Optional

Resolution specifies whether resolution of this reference is required.
  The default is 'Required', which means the reconcile will fail if the
  reference cannot be resolved. 'Optional' means this reference will be
  a no-op if it cannot be resolved.
<h4>.spec.providerConfigRef.policy.resolve</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- Always
- IfNotPresent

Resolve specifies when this reference should be resolved. The default
  is 'IfNotPresent', which will attempt to resolve the reference only when
  the corresponding field is not present. Use 'Always' to resolve the
  reference on every reconcile.
<h4>.spec.provisionSql</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ProvisionSql determines whether or not to provision databases inside the
  RDS cluster.
<h4>.spec.publiclyAccessible</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
<h4>.spec.publishConnectionDetailsTo</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.
<h4>.spec.publishConnectionDetailsTo.configRef</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.
<h4>.spec.publishConnectionDetailsTo.configRef.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>.spec.publishConnectionDetailsTo.configRef.policy</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>.spec.publishConnectionDetailsTo.configRef.policy.resolution</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|Required|


Allowed Values:
- Required
- Optional

Resolution specifies whether resolution of this reference is required.
  The default is 'Required', which means the reconcile will fail if the
  reference cannot be resolved. 'Optional' means this reference will be
  a no-op if it cannot be resolved.
<h4>.spec.publishConnectionDetailsTo.configRef.policy.resolve</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- Always
- IfNotPresent

Resolve specifies when this reference should be resolved. The default
  is 'IfNotPresent', which will attempt to resolve the reference only when
  the corresponding field is not present. Use 'Always' to resolve the
  reference on every reconcile.
<h4>.spec.publishConnectionDetailsTo.metadata</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.
<h4>.spec.publishConnectionDetailsTo.metadata.annotations</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.
<h4>.spec.publishConnectionDetailsTo.metadata.labels</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.
<h4>.spec.publishConnectionDetailsTo.metadata.type</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.
<h4>.spec.publishConnectionDetailsTo.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.
<h4>.spec.region</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Region is the region to use.
<h4>.spec.replicationSourceIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
  this DB cluster is to be created as a Read Replica
<h4>.spec.restoreToPointInTime</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


RestoreToPointInTime is the point in time to restore to.
<h4>.spec.restoreToPointInTime.identifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Identifier is the identifier of the source DB cluster snapshot or DB
  instance snapshot to restore from. Only valid if not running in cluster
  mode.
<h4>.spec.restoreToPointInTime.restoreToTime</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RestoreToTime is the time to restore to.
<h4>.spec.restoreToPointInTime.restoreType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- full-copy
- copy-on-write

RestoreType is the type of restore to perform. This option is ignored if
  not running in cluster mode.
<h4>.spec.restoreToPointInTime.sourceDbClusterIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbClusterIdentifier is the identifier of the source DB cluster.
  This option is ignored if not running in cluster mode.
<h4>.spec.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


sourceDbInstanceAutomatedBackupsArn is the ARN of the source DB instance
  automated backup to restore from. Only valid if not running in cluster mode.
<h4>.spec.restoreToPointInTime.sourceDbInstanceIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbInstanceIdentifier is the identifier of the source DB instance.
  Only valid if not running in cluster mode. If running in cluster mode, use
  `SourceDbClusterIdentifier` instead.
<h4>.spec.restoreToPointInTime.sourceDbiResourceId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbiResourceId is the resource ID of the source DB instance. Only
  valid if not running in cluster mode.
<h4>.spec.restoreToPointInTime.useLatestRestorableTime</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


UseLatestRestorableTime is whether to use the latest restorable time.
<h4>.spec.s3Import</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


S3Import is the S3 import configuration.
<h4>.spec.s3Import.bucketName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketName is the name of the S3 bucket.
<h4>.spec.s3Import.bucketPrefix</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
  within the bucket where the data is located.
<h4>.spec.s3Import.ingestionRole</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


IngestionRole is the role to use for ingestion.
<h4>.spec.s3Import.sourceEngine</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngine is the source engine to use.
<h4>.spec.s3Import.sourceEngineVersion</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngineVersion is the source engine version to use.
<h4>.spec.scalingConfiguration</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ScalingConfiguration is the scaling configuration.
<h4>.spec.scalingConfiguration.autoPause</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoPause is whether the database should automatically pause.
<h4>.spec.scalingConfiguration.maxCapacity</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
<h4>.spec.scalingConfiguration.minCapacity</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
<h4>.spec.scalingConfiguration.secondsUntilAutoPause</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SecondsUntilAutoPause is the number of seconds until the database
  automatically pauses.
<h4>.spec.secretRotation</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretRotation is the secret rotation configuration.
<h4>.spec.secretRotation.automaticallyAfterDays</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AutomaticallyAfterDays is the number of days after which the secret is
  rotated automatically.
<h4>.spec.secretRotation.enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether secret rotation is enabled.
<h4>.spec.secretRotation.rotateImmediately</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


RotateImmediately is whether the secret should be rotated immediately.
<h4>.spec.secretRotation.scheduleExpression</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ScheduleExpression is the schedule expression for secret rotation.
<h4>.spec.serverlessV2ScalingConfiguration</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.
<h4>.spec.serverlessV2ScalingConfiguration.maxCapacity</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
<h4>.spec.serverlessV2ScalingConfiguration.minCapacity</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
<h4>.spec.storageType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType specifies the storage type to be associated with the cluster
<h4>.spec.subnetIds</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SubnetIds is a list of subnet IDs to use for the subnet group.
<h4>.spec.subnetIds[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB cluster.
<h4>.spec.vpcId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


VpcId is the VPC ID to use.
<h4>.spec.writeConnectionSecretToRef</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


WriteConnectionSecretToReference specifies the namespace and name of a
  Secret to which any connection details for this managed resource should
  be written. Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.
  This field is planned to be replaced in a future release in favor of
  PublishConnectionDetailsTo. Currently, both could be set independently
  and connection details would be published to both without affecting
  each other.
<h4>.spec.writeConnectionSecretToRef.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.
<h4>.spec.writeConnectionSecretToRef.namespace</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace of the secret.

### Status Properties
<h4>.status.accountId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AccountId is the account ID of the DB cluster.
<h4>.status.clusterArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterArn is the ARN of the DB cluster.
<h4>.status.clusterIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterIdentifier is the identifier of the DB cluster.
<h4>.status.clusterResourceId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterResourceId is the resource ID of the DB cluster.
<h4>.status.conditions</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Conditions of the resource.
<h4>.status.conditions[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A Condition that may apply to a resource.
<h4>.status.conditions[*].lastTransitionTime</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


LastTransitionTime is the last time this condition transitioned from one
  status to another.
<h4>.status.conditions[*].message</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A Message containing details about this condition's last transition from
  one status to another, if any.
<h4>.status.conditions[*].reason</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


A Reason for this condition's last transition from one status to another.
<h4>.status.conditions[*].status</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Status of this condition; is it currently True, False, or Unknown?
<h4>.status.conditions[*].type</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Type of this condition. At most one of each condition type may apply to
  a resource at any point in time.
<h4>.status.connectionSecret</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ConnectionSecret is the name of the connection secret used for the DB.
<h4>.status.dbParameterGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbParameterGroupName is the name of the DB parameter group to associate
  with this DB instance.
<h4>.status.dbSubnetGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbSubnetGroupName is the name of the DB subnet group to associate with
  this DB instance.
<h4>.status.endpoint</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Endpoint is the endpoint of the DB cluster.
<h4>.status.esoConnectionSecret</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EsoConnectionSecret is the name of the connection secret created by ESO
  for use with provider-sql.
<h4>.status.kmsKeyId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KmsKeyId is the ID of the KMS key.
<h4>.status.monitoringRoleArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MonitoringRoleArn is the ARN of the monitoring role.
<h4>.status.port</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


port is the port of the database.
<h4>.status.securityGroupId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SecurityGroupId The security group ID of the DB cluster.





