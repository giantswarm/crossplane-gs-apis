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
<details>
<summary>
  <h4>.spec.activityStream</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ActivityStream is the activity stream configuration.
</details>
<details>
<summary>
  <h4>.spec.activityStream.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether activity stream is enabled.
</details>
<details>
<summary>
  <h4>.spec.activityStream.engineNativeAuditFieldsIncluded</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EngineNativeAuditFieldsIncluded is whether engine native audit fields are
  included. This option only applies to Oracle databases.
</details>
<details>
<summary>
  <h4>.spec.activityStream.mode</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;sync&#34;
- &#34;async&#34;

Mode is the mode of the activity stream. Valid values are `sync` and `async`.
</details>
<details>
<summary>
  <h4>.spec.allocatedStorage</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
</details>
<details>
<summary>
  <h4>.spec.allowMajorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
</details>
<details>
<summary>
  <h4>.spec.applyImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
</details>
<details>
<summary>
  <h4>.spec.autoMinorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically. This value can be overridden on a per instance basis.
</details>
<details>
<summary>
  <h4>.spec.autoscaling</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Autoscaling is the autoscaling configuration.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Autoscaling is whether autoscaling is enabled.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.maxCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for autoscaling.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.metricType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;RDSReaderAverageCPUUtilization&#34;
- &#34;RDSReaderAverageDatabaseConnections&#34;

MetricType is the type of metric to use for autoscaling.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.minCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for autoscaling.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.policyName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PolicyName is the name of the autoscaling policy.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.scaleInCooldown</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleInCooldown is the amount of time, in seconds, after a scaling in
  activity completes before another scaling activity can start.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.scaleOutCooldown</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleOutCooldown is the amount of time, in seconds, after a scaling out
  activity completes before another scaling activity can start.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.targetCPU</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetCPU is CPU threshold which will initiate autoscaling.
</details>
<details>
<summary>
  <h4>.spec.autoscaling.targetConnections</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetConnections is the average number of connections threshold which
  will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
  default max_connections
</details>
<details>
<summary>
  <h4>.spec.availabilityZones</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


AvailabilityZones is a list of availability zone to use.
</details>
<details>
<summary>
  <h4>.spec.availabilityZones[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.backtrackWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BacktrackWindow is the target backtrack window, in seconds.
  Only available for Aurora engine. To disable backtracking, set this value to 0.
</details>
<details>
<summary>
  <h4>.spec.backupRetentionPeriod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
</details>
<details>
<summary>
  <h4>.spec.cidrBlocks</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CidrBlocks is a list of CIDRs that are allowed to connect to the DB.
</details>
<details>
<summary>
  <h4>.spec.cidrBlocks[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cloudwatchLogGroupParameters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


CloudwatchLogGroup defines the parameters for the log groups
</details>
<details>
<summary>
  <h4>.spec.cloudwatchLogGroupParameters.class</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Class is the class of the log group.
</details>
<details>
<summary>
  <h4>.spec.cloudwatchLogGroupParameters.create</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the log group is to be created.
</details>
<details>
<summary>
  <h4>.spec.cloudwatchLogGroupParameters.retentionInDays</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RetentionInDays is the number of days to retain logs for.
</details>
<details>
<summary>
  <h4>.spec.cloudwatchLogGroupParameters.skipDestroy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipDestroy is whether the log group should be skipped during destroy.
</details>
<details>
<summary>
  <h4>.spec.copyTagsToSnapshot</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
</details>
<details>
<summary>
  <h4>.spec.createCluster</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateCluster is whether the cluster should be created.
  By default this is true but for non-aurora clusters, the DB Cluster
  resource is optional and can be omitted. In this case, the DB instances
  will be created as `instance.rds` types.
</details>
<details>
<summary>
  <h4>.spec.databaseName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
</details>
<details>
<summary>
  <h4>.spec.databases</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Databases is a map of databases to create.
</details>
<details>
<summary>
  <h4>.spec.dbClusterInstanceClass</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbClusterInstanceClass is the instance class to use.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbClusterParameterGroup defines the parameters for the DB cluster.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.applyMethod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;immediate&#34;
- &#34;pending-reboot&#34;

ApplyMethod is the apply method for the parameter group. Some engines
  cannot apply changes immediately, and require a reboot in which case you
  must set this value to `pending-reboot`.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.create</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is to be created.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.family</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.parameters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.parameters[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbClusterParameterGroup.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbParameterGroup defines the parameters for the DB instance.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.create</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is created.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.family</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.parameters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.parameters[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.
</details>
<details>
<summary>
  <h4>.spec.dbParameterGroup.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
</details>
<details>
<summary>
  <h4>.spec.deleteAutomatedBackups</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
</details>
<details>
<summary>
  <h4>.spec.deletionPolicy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;Orphan&#34;
- &#34;Delete&#34;

DeletionPolicy specifies what will happen to the underlying external
  when this managed resource is deleted - either "Delete" or "Orphan" the
  external resource.
  This field is planned to be deprecated in favor of the ManagementPolicies
  field in a future release. Currently, both could be set independently and
  non-default values would be honored if the feature flag is enabled.
  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
</details>
<details>
<summary>
  <h4>.spec.deletionProtection</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
</details>
<details>
<summary>
  <h4>.spec.domain</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Domain is the domain to use.
</details>
<details>
<summary>
  <h4>.spec.domainIAMRoleName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIAMRoleName is the name of the IAM role to use.
</details>
<details>
<summary>
  <h4>.spec.enableGlobalWriteForwarding</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableGlobalWriteForwarding is whether global write forwarding is enabled.
</details>
<details>
<summary>
  <h4>.spec.enableHttpEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableHttpEndpoint is whether the HTTP endpoint is enabled.
</details>
<details>
<summary>
  <h4>.spec.enableLocalWriteForwarding</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableLocalWriteForwarding is whether local write forwarding is enabled.
</details>
<details>
<summary>
  <h4>.spec.enabledCloudwatchLogsExports</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
</details>
<details>
<summary>
  <h4>.spec.enabledCloudwatchLogsExports[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
</details>
<details>
<summary>
  <h4>.spec.endpoints</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Endpoints is a list of custom endpoints to create.
</details>
<details>
<summary>
  <h4>.spec.endpoints[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.endpoints[*].customEndpointType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;READER&#34;
- &#34;ANY&#34;

CustomEndpointType is the type of the custom endpoint.
</details>
<details>
<summary>
  <h4>.spec.endpoints[*].excludedMembers</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludedMembers is a list of DB instances that aren't part of the custom
  endpoint group.
</details>
<details>
<summary>
  <h4>.spec.endpoints[*].excludedMembers[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.endpoints[*].staticMembers</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


StaticMembers is a list of DB instances that are part of the custom
  endpoint group.
</details>
<details>
<summary>
  <h4>.spec.endpoints[*].staticMembers[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.endpoints[*].tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the custom endpoint.
</details>
<details>
<summary>
  <h4>.spec.engine</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Engine is the database engine to use.
</details>
<details>
<summary>
  <h4>.spec.engineMode</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;parallelquery&#34;
- &#34;provisioned&#34;
- &#34;serverless&#34;

EngineMode is the database engine mode to use.
</details>
<details>
<summary>
  <h4>.spec.engineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version of the database engine to use.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


EnhancedMonitoring is the enhanced monitoring configuration.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether enhanced monitoring is enabled.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.forceDetachPolicies</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.managedPolicyArns</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.managedPolicyArns[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.maxSessionDuration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.monitoringInterval</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.path</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Path is the path of the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.enhancedMonitoring.permissionsBoundary</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.eso</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Eso is the ESO configuration.
  
  
  This field is used to sync secrets using `external-secrets-operator`.
  External Secrets Operator must be installed if this value is set to true
</details>
<details>
<summary>
  <h4>.spec.eso.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled Whether or not to enable `external-secrets-operator` object
  deployments using `provider-kubernetes.
</details>
<details>
<summary>
  <h4>.spec.eso.kubernetesSecretStore</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KubernetesSecretStore is the Kubernetes secret store to use.
  
  
  The kubernetes secret store is expected to be namespace scoped to prevent
  secrets leaking across namespaces.
</details>
<details>
<summary>
  <h4>.spec.eso.stores</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Stores is a list of secret stores to use for push secrets.
</details>
<details>
<summary>
  <h4>.spec.eso.stores[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretsStore is a reference to a secrets store to be passed to External
  Secrets Operator for creating PushSecrets
</details>
<details>
<summary>
  <h4>.spec.eso.stores[*].enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether the secrets store is enabled.
</details>
<details>
<summary>
  <h4>.spec.eso.stores[*].isClusterSecretStore</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IsClusterSecretStore is whether the secret store is a cluster secret store.
</details>
<details>
<summary>
  <h4>.spec.eso.stores[*].secretStore</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


SecretStoreName is the name of the secret store.
</details>
<details>
<summary>
  <h4>.spec.globalClusterIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.
</details>
<details>
<summary>
  <h4>.spec.iamDatabaseAuthenticationEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
</details>
<details>
<summary>
  <h4>.spec.iamRoles</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


IamRoles is a list of IAM roles to associate with the DB cluster.
</details>
<details>
<summary>
  <h4>.spec.iamRoles[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.iamRoles[*].featureName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FeatureName is the name of the feature.
</details>
<details>
<summary>
  <h4>.spec.iamRoles[*].roleArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RoleArn is the ARN of the role.
</details>
<details>
<summary>
  <h4>.spec.instanceCount</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


InstanceCount is the number of instances to create.
  
  
  If set, this value will create the requested number of instances using
  defaults from the cluster configuration. If `instances` are specified,
  this value is ignored.
</details>
<details>
<summary>
  <h4>.spec.instances</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Instances is a list of instances to create.
</details>
<details>
<summary>
  <h4>.spec.instances[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.instances[*].allocatedStorage</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllocatedStorage`
</details>
<details>
<summary>
  <h4>.spec.instances[*].allowMajorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllowMajorVersionUpgrade`
</details>
<details>
<summary>
  <h4>.spec.instances[*].applyImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
  
  
  Overrides `ClusterParameters.ApplyImmediately`
</details>
<details>
<summary>
  <h4>.spec.instances[*].autoMinorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically.
  
  
  Overrides `ClusterParameters.AutoMinorVersionUpgrade`
</details>
<details>
<summary>
  <h4>.spec.instances[*].availabilityZone</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the availability zone for this instance.
  Ignored if `multiAz` is true
</details>
<details>
<summary>
  <h4>.spec.instances[*].backupRetentionPeriod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].copyTagsToSnapshot</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
</details>
<details>
<summary>
  <h4>.spec.instances[*].databaseName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
</details>
<details>
<summary>
  <h4>.spec.instances[*].deleteAutomatedBackups</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].deletionProtection</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].domainIamRoleName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIamRoleName is the name of the IAM role to use.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].enabledCloudwatchLogsExports</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].enabledCloudwatchLogsExports[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
</details>
<details>
<summary>
  <h4>.spec.instances[*].finalSnapshotIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the identifier of the final snapshot.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].iamDatabaseAuthenticationEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IamDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].instanceClass</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


InstanceClass is the instance class to use.
</details>
<details>
<summary>
  <h4>.spec.instances[*].iops</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].licenseModel</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LicenseModel is the license model to use.
  
  
  Only applicable if not running in cluster mode.
</details>
<details>
<summary>
  <h4>.spec.instances[*].monitoringInterval</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when
  Enhanced Monitoring metrics are collected for the DB instance.
</details>
<details>
<summary>
  <h4>.spec.instances[*].multiAz</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].networkType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NetworkType is the network type to use.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].optionGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


OptionGroupName is the name of the option group to associate with this DB
  instance.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].parameterGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the DB parameter group to associate
  with this DB instance. Must pre-exist in the account. Mutually exclusive
  with `RdsBaseDbCluster.dbParameterGroup`
</details>
<details>
<summary>
  <h4>.spec.instances[*].performanceInsightsEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
</details>
<details>
<summary>
  <h4>.spec.instances[*].performanceInsightsKmsKeyID</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption
  of Performance Insights data.
</details>
<details>
<summary>
  <h4>.spec.instances[*].performanceInsightsRetentionPeriod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to
  retain Performance Insights data.
</details>
<details>
<summary>
  <h4>.spec.instances[*].preferredMaintenanceWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
</details>
<details>
<summary>
  <h4>.spec.instances[*].promotionTier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PromotionTier is the order in which to promote an Aurora replica to the
  primary instance.
</details>
<details>
<summary>
  <h4>.spec.instances[*].publiclyAccessible</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
</details>
<details>
<summary>
  <h4>.spec.instances[*].skipFinalSnapshot</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipFinalSnapshot is whether to skip the final snapshot.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].storageEncrypted</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


StorageEncrypted is whether storage is encrypted.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].storageThroughput</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


StorageThroughput is the amount of storage throughput. Only applicable if
  `storageType` is `gp3`
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].storageType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType is the storage type to use.
  
  
  Only applicable if not running in cluster mode
</details>
<details>
<summary>
  <h4>.spec.instances[*].tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB instance.
</details>
<details>
<summary>
  <h4>.spec.iops</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
</details>
<details>
<summary>
  <h4>.spec.kubernetesProviderConfig</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


KubernetesProviderConfig is the provider config for the Kubernetes provider.
</details>
<details>
<summary>
  <h4>.spec.kubernetesProviderConfig.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


</details>
<details>
<summary>
  <h4>.spec.managementPolicies</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


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
</details>
<details>
<summary>
  <h4>.spec.managementPolicies[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.
</details>
<details>
<summary>
  <h4>.spec.masterUsername</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MasterUsername is the master username to use.
</details>
<details>
<summary>
  <h4>.spec.multiAz</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
</details>
<details>
<summary>
  <h4>.spec.partition</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;aws&#34;
- &#34;aws-cn&#34;
- &#34;aws-us-gov&#34;

Partition is the AWS partition to use.
</details>
<details>
<summary>
  <h4>.spec.performanceInsightsEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
</details>
<details>
<summary>
  <h4>.spec.performanceInsightsKmsKeyID</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.
</details>
<details>
<summary>
  <h4>.spec.performanceInsightsRetentionPeriod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.
</details>
<details>
<summary>
  <h4>.spec.preferredBackupWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredBackupWindow is the preferred backup window.
</details>
<details>
<summary>
  <h4>.spec.preferredMaintenanceWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
</details>
<details>
<summary>
  <h4>.spec.providerConfigRef</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.
</details>
<details>
<summary>
  <h4>.spec.providerConfigRef.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
</details>
<details>
<summary>
  <h4>.spec.providerConfigRef.policy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
</details>
<details>
<summary>
  <h4>.spec.providerConfigRef.policy.resolution</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;Required&#34;
- &#34;Optional&#34;

Resolution specifies whether resolution of this reference is required.
  The default is 'Required', which means the reconcile will fail if the
  reference cannot be resolved. 'Optional' means this reference will be
  a no-op if it cannot be resolved.
</details>
<details>
<summary>
  <h4>.spec.providerConfigRef.policy.resolve</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;Always&#34;
- &#34;IfNotPresent&#34;

Resolve specifies when this reference should be resolved. The default
  is 'IfNotPresent', which will attempt to resolve the reference only when
  the corresponding field is not present. Use 'Always' to resolve the
  reference on every reconcile.
</details>
<details>
<summary>
  <h4>.spec.provisionSql</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ProvisionSql determines whether or not to provision databases inside the
  RDS cluster.
</details>
<details>
<summary>
  <h4>.spec.publiclyAccessible</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.configRef</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.configRef.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.configRef.policy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.configRef.policy.resolution</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;Required&#34;
- &#34;Optional&#34;

Resolution specifies whether resolution of this reference is required.
  The default is 'Required', which means the reconcile will fail if the
  reference cannot be resolved. 'Optional' means this reference will be
  a no-op if it cannot be resolved.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.configRef.policy.resolve</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;Always&#34;
- &#34;IfNotPresent&#34;

Resolve specifies when this reference should be resolved. The default
  is 'IfNotPresent', which will attempt to resolve the reference only when
  the corresponding field is not present. Use 'Always' to resolve the
  reference on every reconcile.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.metadata</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.metadata.annotations</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.metadata.labels</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.metadata.type</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.
</details>
<details>
<summary>
  <h4>.spec.publishConnectionDetailsTo.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.
</details>
<details>
<summary>
  <h4>.spec.region</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Region is the region to use.
</details>
<details>
<summary>
  <h4>.spec.replicationSourceIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
  this DB cluster is to be created as a Read Replica
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


RestoreToPointInTime is the point in time to restore to.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.identifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Identifier is the identifier of the source DB cluster snapshot or DB
  instance snapshot to restore from. Only valid if not running in cluster
  mode.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.restoreToTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RestoreToTime is the time to restore to.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.restoreType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- &#34;full-copy&#34;
- &#34;copy-on-write&#34;

RestoreType is the type of restore to perform. This option is ignored if
  not running in cluster mode.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.sourceDbClusterIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbClusterIdentifier is the identifier of the source DB cluster.
  This option is ignored if not running in cluster mode.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


sourceDbInstanceAutomatedBackupsArn is the ARN of the source DB instance
  automated backup to restore from. Only valid if not running in cluster mode.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.sourceDbInstanceIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbInstanceIdentifier is the identifier of the source DB instance.
  Only valid if not running in cluster mode. If running in cluster mode, use
  `SourceDbClusterIdentifier` instead.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.sourceDbiResourceId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbiResourceId is the resource ID of the source DB instance. Only
  valid if not running in cluster mode.
</details>
<details>
<summary>
  <h4>.spec.restoreToPointInTime.useLatestRestorableTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


UseLatestRestorableTime is whether to use the latest restorable time.
</details>
<details>
<summary>
  <h4>.spec.s3Import</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


S3Import is the S3 import configuration.
</details>
<details>
<summary>
  <h4>.spec.s3Import.bucketName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketName is the name of the S3 bucket.
</details>
<details>
<summary>
  <h4>.spec.s3Import.bucketPrefix</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
  within the bucket where the data is located.
</details>
<details>
<summary>
  <h4>.spec.s3Import.ingestionRole</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


IngestionRole is the role to use for ingestion.
</details>
<details>
<summary>
  <h4>.spec.s3Import.sourceEngine</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngine is the source engine to use.
</details>
<details>
<summary>
  <h4>.spec.s3Import.sourceEngineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngineVersion is the source engine version to use.
</details>
<details>
<summary>
  <h4>.spec.scalingConfiguration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ScalingConfiguration is the scaling configuration.
</details>
<details>
<summary>
  <h4>.spec.scalingConfiguration.autoPause</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoPause is whether the database should automatically pause.
</details>
<details>
<summary>
  <h4>.spec.scalingConfiguration.maxCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.scalingConfiguration.minCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.scalingConfiguration.secondsUntilAutoPause</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SecondsUntilAutoPause is the number of seconds until the database
  automatically pauses.
</details>
<details>
<summary>
  <h4>.spec.secretRotation</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretRotation is the secret rotation configuration.
</details>
<details>
<summary>
  <h4>.spec.secretRotation.automaticallyAfterDays</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AutomaticallyAfterDays is the number of days after which the secret is
  rotated automatically.
</details>
<details>
<summary>
  <h4>.spec.secretRotation.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether secret rotation is enabled.
</details>
<details>
<summary>
  <h4>.spec.secretRotation.rotateImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


RotateImmediately is whether the secret should be rotated immediately.
</details>
<details>
<summary>
  <h4>.spec.secretRotation.scheduleExpression</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ScheduleExpression is the schedule expression for secret rotation.
</details>
<details>
<summary>
  <h4>.spec.serverlessV2ScalingConfiguration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.
</details>
<details>
<summary>
  <h4>.spec.serverlessV2ScalingConfiguration.maxCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.serverlessV2ScalingConfiguration.minCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.storageType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType specifies the storage type to be associated with the cluster
</details>
<details>
<summary>
  <h4>.spec.subnetIds</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SubnetIds is a list of subnet IDs to use for the subnet group.
</details>
<details>
<summary>
  <h4>.spec.subnetIds[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB cluster.
</details>
<details>
<summary>
  <h4>.spec.vpcId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


VpcId is the VPC ID to use.
</details>
<details>
<summary>
  <h4>.spec.writeConnectionSecretToRef</h4>
</summary>

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
</details>
<details>
<summary>
  <h4>.spec.writeConnectionSecretToRef.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.
</details>
<details>
<summary>
  <h4>.spec.writeConnectionSecretToRef.namespace</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace of the secret.
</details>
### Status Properties
<details>
<summary>
  <h4>.status.accountId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AccountId is the account ID of the DB cluster.
</details>
<details>
<summary>
  <h4>.status.clusterArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterArn is the ARN of the DB cluster.
</details>
<details>
<summary>
  <h4>.status.clusterIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterIdentifier is the identifier of the DB cluster.
</details>
<details>
<summary>
  <h4>.status.clusterResourceId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterResourceId is the resource ID of the DB cluster.
</details>
<details>
<summary>
  <h4>.status.conditions</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Conditions of the resource.
</details>
<details>
<summary>
  <h4>.status.conditions[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A Condition that may apply to a resource.
</details>
<details>
<summary>
  <h4>.status.conditions[*].lastTransitionTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


LastTransitionTime is the last time this condition transitioned from one
  status to another.
</details>
<details>
<summary>
  <h4>.status.conditions[*].message</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A Message containing details about this condition's last transition from
  one status to another, if any.
</details>
<details>
<summary>
  <h4>.status.conditions[*].reason</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


A Reason for this condition's last transition from one status to another.
</details>
<details>
<summary>
  <h4>.status.conditions[*].status</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Status of this condition; is it currently True, False, or Unknown?
</details>
<details>
<summary>
  <h4>.status.conditions[*].type</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Type of this condition. At most one of each condition type may apply to
  a resource at any point in time.
</details>
<details>
<summary>
  <h4>.status.connectionSecret</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ConnectionSecret is the name of the connection secret used for the DB.
</details>
<details>
<summary>
  <h4>.status.dbParameterGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbParameterGroupName is the name of the DB parameter group to associate
  with this DB instance.
</details>
<details>
<summary>
  <h4>.status.dbSubnetGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbSubnetGroupName is the name of the DB subnet group to associate with
  this DB instance.
</details>
<details>
<summary>
  <h4>.status.endpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Endpoint is the endpoint of the DB cluster.
</details>
<details>
<summary>
  <h4>.status.esoConnectionSecret</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EsoConnectionSecret is the name of the connection secret created by ESO
  for use with provider-sql.
</details>
<details>
<summary>
  <h4>.status.kmsKeyId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KmsKeyId is the ID of the KMS key.
</details>
<details>
<summary>
  <h4>.status.monitoringRoleArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MonitoringRoleArn is the ARN of the monitoring role.
</details>
<details>
<summary>
  <h4>.status.port</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


port is the port of the database.
</details>
<details>
<summary>
  <h4>.status.securityGroupId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SecurityGroupId The security group ID of the DB cluster.
</details>





