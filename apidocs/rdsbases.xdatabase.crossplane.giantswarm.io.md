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
<dd class="shortnames">rdb</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">rdsbases</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

#### `.spec.activityStream`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ActivityStream is the activity stream configuration.

#### `.spec.activityStream.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether activity stream is enabled.

#### `.spec.activityStream.engineNativeAuditFieldsIncluded`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EngineNativeAuditFieldsIncluded is whether engine native audit fields are
included. This option only applies to Oracle databases.

#### `.spec.activityStream.mode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- sync
- async

Mode is the mode of the activity stream. Valid values are `sync` and `async`.

#### `.spec.allocatedStorage`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

AllocatedStorage is the size of the database.

#### `.spec.allowMajorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowMajorVersionUpgrade is whether major version upgrades are allowed.

#### `.spec.applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately is whether changes should be applied immediately.

#### `.spec.autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade is whether minor version upgrades are applied
automatically. This value can be overridden on a per instance basis.

#### `.spec.autoscaling`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Autoscaling is the autoscaling configuration.

#### `.spec.autoscaling.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Autoscaling is whether autoscaling is enabled.

#### `.spec.autoscaling.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxCapacity is the maximum capacity for autoscaling.

#### `.spec.autoscaling.metricType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- RDSReaderAverageCPUUtilization
- RDSReaderAverageDatabaseConnections

MetricType is the type of metric to use for autoscaling.

#### `.spec.autoscaling.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MinCapacity is the minimum capacity for autoscaling.

#### `.spec.autoscaling.policyName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PolicyName is the name of the autoscaling policy.

#### `.spec.autoscaling.scaleInCooldown`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

ScaleInCooldown is the amount of time, in seconds, after a scaling in
activity completes before another scaling activity can start.

#### `.spec.autoscaling.scaleOutCooldown`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

ScaleOutCooldown is the amount of time, in seconds, after a scaling out
activity completes before another scaling activity can start.

#### `.spec.autoscaling.targetCPU`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

TargetCPU is CPU threshold which will initiate autoscaling.

#### `.spec.autoscaling.targetConnections`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

TargetConnections is the average number of connections threshold which
will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
default max_connections

#### `.spec.availabilityZones`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

AvailabilityZones is a list of availability zone to use.

#### `.spec.availabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.backtrackWindow`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

BacktrackWindow is the target backtrack window, in seconds.
Only available for Aurora engine. To disable backtracking, set this value to 0.

#### `.spec.backupRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

BackupRetentionPeriod is the number of days to retain backups for.

#### `.spec.cidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

CidrBlocks is a list of CIDRs that are allowed to connect to the DB.

#### `.spec.cidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cloudwatchLogGroupParameters`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

CloudwatchLogGroup defines the parameters for the log groups

#### `.spec.cloudwatchLogGroupParameters.class`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Class is the class of the log group.

#### `.spec.cloudwatchLogGroupParameters.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create is whether the log group is to be created.

#### `.spec.cloudwatchLogGroupParameters.retentionInDays`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

RetentionInDays is the number of days to retain logs for.

#### `.spec.cloudwatchLogGroupParameters.skipDestroy`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

SkipDestroy is whether the log group should be skipped during destroy.

#### `.spec.copyTagsToSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CopyTagsToSnapshot is whether tags should be copied to snapshots.

#### `.spec.createCluster`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CreateCluster is whether the cluster should be created.
By default this is true but for non-aurora clusters, the DB Cluster
resource is optional and can be omitted. In this case, the DB instances
will be created as `instance.rds` types.

#### `.spec.databaseName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DatabaseName is the name of the database to create.

#### `.spec.dbClusterInstanceClass`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DbClusterInstanceClass is the instance class to use.

#### `.spec.dbClusterParameterGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

DbClusterParameterGroup defines the parameters for the DB cluster.

#### `.spec.dbClusterParameterGroup.applyMethod`

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

#### `.spec.dbClusterParameterGroup.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create is whether the parameter group is to be created.

#### `.spec.dbClusterParameterGroup.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is the description of the parameter group.

#### `.spec.dbClusterParameterGroup.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Family is the family of the parameter group.

#### `.spec.dbClusterParameterGroup.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Name is the name of the parameter group.

#### `.spec.dbClusterParameterGroup.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Parameters is a list of parameters to associate with the parameter group.
Note that parameters may differ between families

#### `.spec.dbClusterParameterGroup.parameters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|

Parameter is a parameter to associate with a parameter group.

#### `.spec.dbClusterParameterGroup.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the parameter group.

#### `.spec.dbParameterGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

DbParameterGroup defines the parameters for the DB instance.

#### `.spec.dbParameterGroup.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create is whether the parameter group is created.

#### `.spec.dbParameterGroup.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is the description of the parameter group.

#### `.spec.dbParameterGroup.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Family is the family of the parameter group.

#### `.spec.dbParameterGroup.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Name is the name of the parameter group.

#### `.spec.dbParameterGroup.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Parameters is a list of parameters to associate with the parameter group.
Note that parameters may differ between families

#### `.spec.dbParameterGroup.parameters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|

Parameter is a parameter to associate with a parameter group.

#### `.spec.dbParameterGroup.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the parameter group.

#### `.spec.deleteAutomatedBackups`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeleteAutomatedBackups is whether automated backups should be deleted.

#### `.spec.deletionPolicy`

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

#### `.spec.deletionProtection`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeletionProtection is whether deletion protection is enabled.

#### `.spec.domain`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Domain is the domain to use.

#### `.spec.domainIAMRoleName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DomainIAMRoleName is the name of the IAM role to use.

#### `.spec.enableGlobalWriteForwarding`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableGlobalWriteForwarding is whether global write forwarding is enabled.

#### `.spec.enableHttpEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableHttpEndpoint is whether the HTTP endpoint is enabled.

#### `.spec.enableLocalWriteForwarding`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableLocalWriteForwarding is whether local write forwarding is enabled.

#### `.spec.enabledCloudwatchLogsExports`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.

#### `.spec.enabledCloudwatchLogsExports[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

LogGroup is the name of a log group.

#### `.spec.endpoints`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Endpoints is a list of custom endpoints to create.

#### `.spec.endpoints[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.endpoints[*].customEndpointType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- READER
- ANY

CustomEndpointType is the type of the custom endpoint.

#### `.spec.endpoints[*].excludedMembers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ExcludedMembers is a list of DB instances that aren't part of the custom
endpoint group.

#### `.spec.endpoints[*].excludedMembers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.endpoints[*].staticMembers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

StaticMembers is a list of DB instances that are part of the custom
endpoint group.

#### `.spec.endpoints[*].staticMembers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.endpoints[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the custom endpoint.

#### `.spec.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Engine is the database engine to use.

#### `.spec.engineMode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- parallelquery
- provisioned
- serverless

EngineMode is the database engine mode to use.

#### `.spec.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version of the database engine to use.

#### `.spec.enhancedMonitoring`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

EnhancedMonitoring is the enhanced monitoring configuration.

#### `.spec.enhancedMonitoring.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is the description of the monitoring role.

#### `.spec.enhancedMonitoring.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether enhanced monitoring is enabled.

#### `.spec.enhancedMonitoring.forceDetachPolicies`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it

#### `.spec.enhancedMonitoring.managedPolicyArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.

#### `.spec.enhancedMonitoring.managedPolicyArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.enhancedMonitoring.maxSessionDuration`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.

#### `.spec.enhancedMonitoring.monitoringInterval`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.

#### `.spec.enhancedMonitoring.path`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Path is the path of the monitoring role.

#### `.spec.enhancedMonitoring.permissionsBoundary`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.

#### `.spec.eso`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Eso is the ESO configuration.

This field is used to sync secrets using `external-secrets-operator`.
External Secrets Operator must be installed if this value is set to true

#### `.spec.eso.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled Whether or not to enable `external-secrets-operator` object
deployments using `provider-kubernetes.

#### `.spec.eso.kubernetesSecretStore`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

KubernetesSecretStore is the Kubernetes secret store to use.

The kubernetes secret store is expected to be namespace scoped to prevent
secrets leaking across namespaces.

#### `.spec.eso.stores`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Stores is a list of secret stores to use for push secrets.

#### `.spec.eso.stores[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

SecretsStore is a reference to a secrets store to be passed to External
Secrets Operator for creating PushSecrets

#### `.spec.eso.stores[*].enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether the secrets store is enabled.

#### `.spec.eso.stores[*].isClusterSecretStore`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

IsClusterSecretStore is whether the secret store is a cluster secret store.

#### `.spec.eso.stores[*].secretStore`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

SecretStoreName is the name of the secret store.

#### `.spec.globalClusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.

#### `.spec.iamDatabaseAuthenticationEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.

#### `.spec.iamRoles`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

IamRoles is a list of IAM roles to associate with the DB cluster.

#### `.spec.iamRoles[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.iamRoles[*].featureName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FeatureName is the name of the feature.

#### `.spec.iamRoles[*].roleArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RoleArn is the ARN of the role.

#### `.spec.instanceCount`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

InstanceCount is the number of instances to create.

If set, this value will create the requested number of instances using
defaults from the cluster configuration. If `instances` are specified,
this value is ignored.

#### `.spec.instances`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Instances is a list of instances to create.

#### `.spec.instances[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.instances[*].allocatedStorage`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

AllocatedStorage is the size of the database.

Only applicable if not running in cluster mode. In cluster mode this value
is ignored.

Overrides `ClusterParameters.AllocatedStorage`

#### `.spec.instances[*].allowMajorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowMajorVersionUpgrade is whether major version upgrades are allowed.

Only applicable if not running in cluster mode. In cluster mode this value
is ignored.

Overrides `ClusterParameters.AllowMajorVersionUpgrade`

#### `.spec.instances[*].applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately is whether changes should be applied immediately.

Overrides `ClusterParameters.ApplyImmediately`

#### `.spec.instances[*].autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade is whether minor version upgrades are applied
automatically.

Overrides `ClusterParameters.AutoMinorVersionUpgrade`

#### `.spec.instances[*].availabilityZone`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

AvailabilityZone is the availability zone for this instance.
Ignored if `multiAz` is true

#### `.spec.instances[*].backupRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

BackupRetentionPeriod is the number of days to retain backups for.

Only applicable if not running in cluster mode

#### `.spec.instances[*].copyTagsToSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CopyTagsToSnapshot is whether tags should be copied to snapshots.

#### `.spec.instances[*].databaseName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DatabaseName is the name of the database to create.

#### `.spec.instances[*].deleteAutomatedBackups`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeleteAutomatedBackups is whether automated backups should be deleted.

Only applicable if not running in cluster mode

#### `.spec.instances[*].deletionProtection`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeletionProtection is whether deletion protection is enabled.

Only applicable if not running in cluster mode

#### `.spec.instances[*].domainIamRoleName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DomainIamRoleName is the name of the IAM role to use.

Only applicable if not running in cluster mode

#### `.spec.instances[*].enabledCloudwatchLogsExports`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.

Only applicable if not running in cluster mode

#### `.spec.instances[*].enabledCloudwatchLogsExports[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

LogGroup is the name of a log group.

#### `.spec.instances[*].finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FinalSnapshotIdentifier is the identifier of the final snapshot.

Only applicable if not running in cluster mode

#### `.spec.instances[*].iamDatabaseAuthenticationEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

IamDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.

Only applicable if not running in cluster mode

#### `.spec.instances[*].instanceClass`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

InstanceClass is the instance class to use.

#### `.spec.instances[*].iops`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Iops is the amount of provisioned IOPS.

Only applicable if not running in cluster mode

#### `.spec.instances[*].licenseModel`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

LicenseModel is the license model to use.

Only applicable if not running in cluster mode.

#### `.spec.instances[*].monitoringInterval`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MonitoringInterval is the interval, in seconds, between points when
Enhanced Monitoring metrics are collected for the DB instance.

#### `.spec.instances[*].multiAz`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

MultiAZ is whether the DB instance is a Multi-AZ deployment.

Only applicable if not running in cluster mode

#### `.spec.instances[*].networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NetworkType is the network type to use.

Only applicable if not running in cluster mode

#### `.spec.instances[*].optionGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

OptionGroupName is the name of the option group to associate with this DB
instance.

Only applicable if not running in cluster mode

#### `.spec.instances[*].parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the DB parameter group to associate
with this DB instance. Must pre-exist in the account. Mutually exclusive
with `RdsBaseDbCluster.dbParameterGroup`

#### `.spec.instances[*].performanceInsightsEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PerformanceInsightsEnabled is whether Performance Insights is enabled.

#### `.spec.instances[*].performanceInsightsKmsKeyID`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption
of Performance Insights data.

#### `.spec.instances[*].performanceInsightsRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

PerformanceInsightsRetentionPeriod is the amount of time, in days, to
retain Performance Insights data.

#### `.spec.instances[*].preferredMaintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredMaintenanceWindow is the preferred maintenance window.

#### `.spec.instances[*].promotionTier`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

PromotionTier is the order in which to promote an Aurora replica to the
primary instance.

#### `.spec.instances[*].publiclyAccessible`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PubliclyAccessible is whether the DB instance is publicly accessible.

#### `.spec.instances[*].skipFinalSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

SkipFinalSnapshot is whether to skip the final snapshot.

Only applicable if not running in cluster mode

#### `.spec.instances[*].storageEncrypted`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

StorageEncrypted is whether storage is encrypted.

Only applicable if not running in cluster mode

#### `.spec.instances[*].storageThroughput`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

StorageThroughput is the amount of storage throughput. Only applicable if
`storageType` is `gp3`

Only applicable if not running in cluster mode

#### `.spec.instances[*].storageType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

StorageType is the storage type to use.

Only applicable if not running in cluster mode

#### `.spec.instances[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the DB instance.

#### `.spec.iops`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Iops is the amount of provisioned IOPS.

#### `.spec.kubernetesProviderConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

KubernetesProviderConfig is the provider config for the Kubernetes provider.

#### `.spec.kubernetesProviderConfig.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.kubernetesProviderConfig.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.kubernetesProviderConfig.policy.resolution`

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

#### `.spec.kubernetesProviderConfig.policy.resolve`

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

#### `.spec.managementPolicies`

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

#### `.spec.managementPolicies[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

A ManagementAction represents an action that the Crossplane controllers
can take on an external resource.

#### `.spec.masterUsername`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MasterUsername is the master username to use.

#### `.spec.multiAz`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

MultiAZ is whether the DB instance is a Multi-AZ deployment.

#### `.spec.partition`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- aws
- aws-cn
- aws-us-gov

Partition is the AWS partition to use.

#### `.spec.performanceInsightsEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PerformanceInsightsEnabled is whether Performance Insights is enabled.

#### `.spec.performanceInsightsKmsKeyID`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.

#### `.spec.performanceInsightsRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.

#### `.spec.preferredBackupWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredBackupWindow is the preferred backup window.

#### `.spec.preferredMaintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredMaintenanceWindow is the preferred maintenance window.

#### `.spec.providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|

ProviderConfigReference specifies how the provider that will be used to
create, observe, update, and delete this managed resource should be
configured.

#### `.spec.providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.providerConfigRef.policy.resolution`

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

#### `.spec.providerConfigRef.policy.resolve`

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

#### `.spec.provisionSql`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProvisionSql determines whether or not to provision databases inside the
RDS cluster.

#### `.spec.provisionSql.connectionSecretName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the connection secret to use for the RDS instance

Required if `providerConfigRef` is not provided, ignored otherwise
Must exist in the same namespace as the provisioning claim

If this value is provided, the composition will attempt to create a
provider config using the engine specific providerconfig spec

#### `.spec.provisionSql.databases`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Databases is a map of databases to create.

#### `.spec.provisionSql.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Determines if the RDS provisioning should be enabled

#### `.spec.provisionSql.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The type of database engine being provisioned

#### `.spec.publiclyAccessible`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PubliclyAccessible is whether the DB instance is publicly accessible.

#### `.spec.publishConnectionDetailsTo`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

PublishConnectionDetailsTo specifies the connection secret config which
contains a name, metadata and a reference to secret store config to
which any connection details for this managed resource should be written.
Connection details frequently include the endpoint, username,
and password required to connect to the managed resource.

#### `.spec.publishConnectionDetailsTo.configRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|

SecretStoreConfigRef specifies which secret store config should be used
for this ConnectionSecret.

#### `.spec.publishConnectionDetailsTo.configRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.publishConnectionDetailsTo.configRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.publishConnectionDetailsTo.configRef.policy.resolution`

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

#### `.spec.publishConnectionDetailsTo.configRef.policy.resolve`

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

#### `.spec.publishConnectionDetailsTo.metadata`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Metadata is the metadata for connection secret.

#### `.spec.publishConnectionDetailsTo.metadata.annotations`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Annotations are the annotations to be added to connection secret.
- For Kubernetes secrets, this will be used as "metadata.annotations".
- It is up to Secret Store implementation for others store types.

#### `.spec.publishConnectionDetailsTo.metadata.labels`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Labels are the labels/tags to be added to connection secret.
- For Kubernetes secrets, this will be used as "metadata.labels".
- It is up to Secret Store implementation for others store types.

#### `.spec.publishConnectionDetailsTo.metadata.type`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Type is the SecretType for the connection secret.
- Only valid for Kubernetes Secret Stores.

#### `.spec.publishConnectionDetailsTo.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name is the name of the connection secret.

#### `.spec.region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Region is the region to use.

#### `.spec.replicationSourceIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
this DB cluster is to be created as a Read Replica

#### `.spec.restoreToPointInTime`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

RestoreToPointInTime is the point in time to restore to.

#### `.spec.restoreToPointInTime.identifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Identifier is the identifier of the source DB cluster snapshot or DB
instance snapshot to restore from. Only valid if not running in cluster
mode.

#### `.spec.restoreToPointInTime.restoreToTime`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RestoreToTime is the time to restore to.

#### `.spec.restoreToPointInTime.restoreType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- full-copy
- copy-on-write

RestoreType is the type of restore to perform. This option is ignored if
not running in cluster mode.

#### `.spec.restoreToPointInTime.sourceDbClusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceDbClusterIdentifier is the identifier of the source DB cluster.
This option is ignored if not running in cluster mode.

#### `.spec.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

sourceDbInstanceAutomatedBackupsArn is the ARN of the source DB instance
automated backup to restore from. Only valid if not running in cluster mode.

#### `.spec.restoreToPointInTime.sourceDbInstanceIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceDbInstanceIdentifier is the identifier of the source DB instance.
Only valid if not running in cluster mode. If running in cluster mode, use
`SourceDbClusterIdentifier` instead.

#### `.spec.restoreToPointInTime.sourceDbiResourceId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceDbiResourceId is the resource ID of the source DB instance. Only
valid if not running in cluster mode.

#### `.spec.restoreToPointInTime.useLatestRestorableTime`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

UseLatestRestorableTime is whether to use the latest restorable time.

#### `.spec.s3Import`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

S3Import is the S3 import configuration.

#### `.spec.s3Import.bucketName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

BucketName is the name of the S3 bucket.

#### `.spec.s3Import.bucketPrefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
within the bucket where the data is located.

#### `.spec.s3Import.ingestionRole`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

IngestionRole is the role to use for ingestion.

#### `.spec.s3Import.sourceEngine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceEngine is the source engine to use.

#### `.spec.s3Import.sourceEngineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceEngineVersion is the source engine version to use.

#### `.spec.scalingConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ScalingConfiguration is the scaling configuration.

#### `.spec.scalingConfiguration.autoPause`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoPause is whether the database should automatically pause.

#### `.spec.scalingConfiguration.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxCapacity is the maximum capacity for the database.

#### `.spec.scalingConfiguration.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MinCapacity is the minimum capacity for the database.

#### `.spec.scalingConfiguration.secondsUntilAutoPause`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

SecondsUntilAutoPause is the number of seconds until the database
automatically pauses.

#### `.spec.secretRotation`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

SecretRotation is the secret rotation configuration.

#### `.spec.secretRotation.automaticallyAfterDays`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

AutomaticallyAfterDays is the number of days after which the secret is
rotated automatically.

#### `.spec.secretRotation.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether secret rotation is enabled.

#### `.spec.secretRotation.rotateImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

RotateImmediately is whether the secret should be rotated immediately.

#### `.spec.secretRotation.scheduleExpression`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ScheduleExpression is the schedule expression for secret rotation.

#### `.spec.serverlessV2ScalingConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.

#### `.spec.serverlessV2ScalingConfiguration.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxCapacity is the maximum capacity for the database.

#### `.spec.serverlessV2ScalingConfiguration.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MinCapacity is the minimum capacity for the database.

#### `.spec.storageType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

StorageType specifies the storage type to be associated with the cluster

#### `.spec.subnetIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SubnetIds is a list of subnet IDs to use for the subnet group.

#### `.spec.subnetIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the DB cluster.

#### `.spec.vpcId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

VpcId is the VPC ID to use.

#### `.spec.writeConnectionSecretToRef`

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

#### `.spec.writeConnectionSecretToRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the secret.

#### `.spec.writeConnectionSecretToRef.namespace`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Namespace of the secret.

### Status Properties

#### `.status.accountId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

AccountId is the account ID of the DB cluster.

#### `.status.clusterArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ClusterArn is the ARN of the DB cluster.

#### `.status.clusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ClusterIdentifier is the identifier of the DB cluster.

#### `.status.clusterResourceId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ClusterResourceId is the resource ID of the DB cluster.

#### `.status.conditions`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Conditions of the resource.

#### `.status.conditions[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

A Condition that may apply to a resource.

#### `.status.conditions[*].lastTransitionTime`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

LastTransitionTime is the last time this condition transitioned from one
status to another.

#### `.status.conditions[*].message`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

A Message containing details about this condition's last transition from
one status to another, if any.

#### `.status.conditions[*].reason`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

A Reason for this condition's last transition from one status to another.

#### `.status.conditions[*].status`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Status of this condition; is it currently True, False, or Unknown?

#### `.status.conditions[*].type`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Type of this condition. At most one of each condition type may apply to
a resource at any point in time.

#### `.status.connectionSecret`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ConnectionSecret is the name of the connection secret used for the DB.

#### `.status.dbParameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DbParameterGroupName is the name of the DB parameter group to associate
with this DB instance.

#### `.status.dbSubnetGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DbSubnetGroupName is the name of the DB subnet group to associate with
this DB instance.

#### `.status.endpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Endpoint is the endpoint of the DB cluster.

#### `.status.esoConnectionSecret`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EsoConnectionSecret is the name of the connection secret created by ESO
for use with provider-sql.

#### `.status.kmsKeyId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

KmsKeyId is the ID of the KMS key.

#### `.status.monitoringRoleArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MonitoringRoleArn is the ARN of the monitoring role.

#### `.status.port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

port is the port of the database.

#### `.status.securityGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SecurityGroupId The security group ID of the DB cluster.
