---
title: RdsCacheCluster CRD schema reference (group xcomposite.crossplane.giantswarm.io)
linkTitle: RdsCacheCluster
description: |
  Custom resource definition (CRD) schema reference page for the RdsCacheCluster resource (rdscacheclusters.xcomposite.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: RdsCacheClusterClaim
  claim_name_plural: rdscacheclusterclaims
  default_composition_ref: rds-cache-cluster
  enforced_composition_ref: rds-cache-cluster
  name_camelcase: RdsCacheCluster
  name_plural: rdscacheclusters
  name_singular: rdscachecluster
  short_names:
    - rdscc
  group: xcomposite.crossplane.giantswarm.io
  technical_name: rdscacheclusters.xcomposite.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - cache
    - crossplane
    - database
    - elasticache
    - rds
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/rdscacheclusters.xcomposite.crossplane.giantswarm.io/
technical_name: rdscacheclusters.xcomposite.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# RdsCacheCluster


<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">rdscacheclusters.xcomposite.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">RdsCacheClusterClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">rdscacheclusterclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">rds-cache-cluster</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">rds-cache-cluster</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xcomposite.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">rdscachecluster</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">rdscc</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">rdscacheclusters</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

#### `.spec.availabilityZones`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|3|
|Max Items|3|

AvailabilityZones is the list of availability zones to be used by the cluster

#### `.spec.availabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

Cache defines the cache settings

#### `.spec.cache.applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately specifies whether the changes should be applied
immediately or during the next maintenance window.

#### `.spec.cache.atRestEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AtRestEncryptionEnabled specifies whether data stored in the cluster is
encrypted at rest.

#### `.spec.cache.authTokenUpdateStrategy`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- rotate
- set

AuthTokenUpdateStrategy specifies how the auth token should be updated.

#### `.spec.cache.autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
applied automatically to the cluster during the maintenance window.

#### `.spec.cache.automaticFailoverEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutomaticFailoverEnabled specifies whether a read replica will be
automatically promoted to the primary cluster if the existing primary
cluster fails.

If enabled, NumCacheNodes must be greater than 1. Must be enabled for
Redis (cluster mode enabled) replication groups.

#### `.spec.cache.azMode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- single-az
- cross-az

AzMode specifies the Availability Zone mode of the cluster.

This parameter is only valid when the Engine parameter is memcached.
For resiliance, we recommend setting the AzMode parameter to cross-az and
this is the default value. In this mode, the number of nodes must be > 1
If memcached is selected, the number of nodes will default to 3, one per
availability zone.

#### `.spec.cache.cacheClusters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

CacheClusters is a list of cache clusters in the replication group.

This value is overridden by NumCacheClusters.

May be used to specify cluster specific configuration.

#### `.spec.cache.cacheClusters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.cache.cacheClusters[*].applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately specifies whether the changes should be applied
immediately or during the next maintenance window.

#### `.spec.cache.cacheClusters[*].autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
applied automatically to the cluster during the maintenance window.

#### `.spec.cache.cacheClusters[*].availabilityZone`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

AvailabilityZone is the name of the Availability Zone in which the
cluster will be created.

If you want to create cache nodes in multi-az, use
preferred_availability_zones instead.
Default: System chosen Availability Zone.

#### `.spec.cache.cacheClusters[*].azMode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- single-az
- cross-az

AzMode specifies the Availability Zone mode of the cluster.

This parameter is only valid when the Engine parameter is memcached.
For resiliance, we recommend setting the AzMode parameter to cross-az and
this is the default value. In this mode, the number of nodes must be > 1
If memcached is selected, the number of nodes will default to 3, one per
availability zone.

#### `.spec.cache.cacheClusters[*].engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- memcached
- redis

Engine is the name of the cache engine to be used for the clusters in
this group.

#### `.spec.cache.cacheClusters[*].engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version number of the cache engine to be used for
the cluster. If not set this will default to the latest version.

This value will be ignored once the cluster is created.

#### `.spec.cache.cacheClusters[*].finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FinalSnapshotIdentifier is the user-supplied name for the final snapshot
that is created immediately before the cluster is deleted.

#### `.spec.cache.cacheClusters[*].ipDiscovery`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6

IpDiscovery is the method used to discover cluster nodes.

#### `.spec.cache.cacheClusters[*].logDeliveryConfigurations`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

LogDeliveryConfiguration is a list of log delivery configurations for
the cluster.

This is only applicable when the Engine parameter is redis.

#### `.spec.cache.cacheClusters[*].logDeliveryConfigurations[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].destination`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Destination Name of the cloudwatch log group or for kinesis firehose resource.

#### `.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].destinationType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- cloudwatch-logs
- kinesis-firehose

DestinationType The destination type for the logs.

#### `.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].logFormat`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- text
- json

LogFormat The log format to use.

#### `.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].logType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- slow-log
- engine-log

LogType The type of log to deliver.

#### `.spec.cache.cacheClusters[*].maintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MaintenanceWindow specifies the weekly time range during which system
maintenance can occur.

#### `.spec.cache.cacheClusters[*].networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6
- dual_stack

NetworkType specifies the network configuration for the cluster.

#### `.spec.cache.cacheClusters[*].nodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NodeType is the instance class to use for the cache nodes.

Requried unless replication group is specified.

#### `.spec.cache.cacheClusters[*].notificationTopicArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
topic to which notifications will be sent.

#### `.spec.cache.cacheClusters[*].numCacheNodes`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumCacheNodes is the number of cache nodes in the cluster.

Required unless replication group is specified.

#### `.spec.cache.cacheClusters[*].outpostMode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- single-outpost
- cross-outpost

OutpostMode specifies the outpost mode that will apply to the cache
cluster creation.

Currently only single-outpost is supported.

#### `.spec.cache.cacheClusters[*].parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the parameter group to associate with
this cluster.

Required unless replication group is specified.

#### `.spec.cache.cacheClusters[*].port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Port is the port number on which each of the cache nodes will accept
connections.

#### `.spec.cache.cacheClusters[*].preferredAvailabilityZones`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

PreferredAvailabilityZones is a list of Availability Zones in which the
cluster's nodes will be created.

Memcached only. The number of availability zones must equal the number of
nodes specified in the NumCacheNodes parameter.

#### `.spec.cache.cacheClusters[*].preferredAvailabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache.cacheClusters[*].preferredOutpostArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
which the cache cluster will be created.

#### `.spec.cache.cacheClusters[*].securityGroupIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SecurityGroupIds is a list of security group IDs to associate with the
cluster.

#### `.spec.cache.cacheClusters[*].securityGroupIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache.cacheClusters[*].snapshotArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
from which to restore data into the cluster.

Optional, Redis only

#### `.spec.cache.cacheClusters[*].snapshotArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache.cacheClusters[*].snapshotName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotName is the name of the snapshot from which to restore data into
the cluster.

Optional, Redis only

#### `.spec.cache.cacheClusters[*].snapshotRetentionLimit`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

SnapshotRetentionLimit is the number of days for which ElastiCache will
retain automatic cache cluster snapshots before deleting them.

Optional, Redis only

#### `.spec.cache.cacheClusters[*].snapshotWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotWindow is the daily time range (in UTC) during which ElastiCache
will begin taking a daily snapshot of the cache cluster.

Optional, Redis only

#### `.spec.cache.cacheClusters[*].subnetGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SubnetGroupName is the name of the subnet group to associate with this
cluster.

Required unless replication group is specified in which case it will be
ignored.

#### `.spec.cache.cacheClusters[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a list of key-value pairs to associate with the cluster.

#### `.spec.cache.cacheClusters[*].transitEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

TransitEncryptionEnabled specifies whether data in the cluster is
encrypted in transit.

Optional, Memcached only

#### `.spec.cache.clusterModeEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ClusterModeEnabled specifies whether cluster mode is enabled for the
replication group.

#### `.spec.cache.createReplicationGroup`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CreateReplicationGroup specifies whether a replication group should be
created.

If set false, the replication group configuration will be used for
creating a single cluster

#### `.spec.cache.dataTieringEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DataTieringEnabled specifies whether data tiering is enabled for the
replication group.

Must be true if the replcation group is using r6gd nodes

#### `.spec.cache.enableAuthToken`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableAuthToken specifies whether an auth token should be enabled for the
replication group.

#### `.spec.cache.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- memcached
- redis

Engine is the name of the cache engine to be used for the clusters in
this group.

#### `.spec.cache.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version number of the cache engine to be used for
the cluster. If not set this will default to the latest version.

This value will be ignored once the cluster is created.

#### `.spec.cache.finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FinalSnapshotIdentifier is the user-supplied name for the final snapshot
that is created immediately before the cluster is deleted.

#### `.spec.cache.globalReplicationGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

GlobalReplicationGroup is the global replication group configuration.

#### `.spec.cache.globalReplicationGroup.automaticFailoverEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutomaticFailoverEnabled specifies whether a read replica will be
automatically promoted to the primary cluster if the existing primary
cluster fails.

#### `.spec.cache.globalReplicationGroup.cacheNodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheNodeType is the instance class to use for the cache nodes.

#### `.spec.cache.globalReplicationGroup.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is a flag that enables the global replication group.

#### `.spec.cache.globalReplicationGroup.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version number of the cache engine to be used for
the cluster. If not set this will default to the latest version.

#### `.spec.cache.globalReplicationGroup.numNodeGroups`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumNodeGroups is the number of node groups in the replication group.

#### `.spec.cache.globalReplicationGroup.parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the parameter group to associate with
the global replication group.

Required when upgrading to a new major engine version but subsequently
ignored.

Specifying this parameter will result in an error if a major engine version
is not specified.

#### `.spec.cache.globalReplicationGroup.suffix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalReplicationGroupIdSuffix is the suffix to append to the global
replication group id.

#### `.spec.cache.globalReplicationGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalReplicationGroupId is the id of the global replication group to
which this replication group should belong.

If this value is specified, the number of node groups parameter must not
be specified.

#### `.spec.cache.ipDiscovery`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6

IpDiscovery is the method used to discover cluster nodes.

#### `.spec.cache.kmsKeyId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
encrypt the data in the cluster.

Ignored unless AtRestEncryptionEnabled is set to true.

#### `.spec.cache.kubernetesProviderConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Provider configuration for the kubernetes provider

This is required for creating users for redis clusters.
If Redis is the engine type, this must be provided and
external-secrets-operator must be installed.

#### `.spec.cache.kubernetesProviderConfig.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.cache.kubernetesProviderConfig.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.cache.kubernetesProviderConfig.policy.resolution`

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

#### `.spec.cache.kubernetesProviderConfig.policy.resolve`

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

#### `.spec.cache.logDeliveryConfigurations`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

LogDeliveryConfiguration is a list of log delivery configurations for
the cluster.

This is only applicable when the Engine parameter is redis.

#### `.spec.cache.logDeliveryConfigurations[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.cache.logDeliveryConfigurations[*].destination`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Destination Name of the cloudwatch log group or for kinesis firehose resource.

#### `.spec.cache.logDeliveryConfigurations[*].destinationType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- cloudwatch-logs
- kinesis-firehose

DestinationType The destination type for the logs.

#### `.spec.cache.logDeliveryConfigurations[*].logFormat`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- text
- json

LogFormat The log format to use.

#### `.spec.cache.logDeliveryConfigurations[*].logType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- slow-log
- engine-log

LogType The type of log to deliver.

#### `.spec.cache.maintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MaintenanceWindow specifies the weekly time range during which system
maintenance can occur.

#### `.spec.cache.multiAzEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

MultiAzEnabled specifies whether the cluster should be created in
multiple Availability Zones.

If true, AutomaticFailoverEnabled must also be true.

#### `.spec.cache.networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6
- dual_stack

NetworkType specifies the network configuration for the cluster.

#### `.spec.cache.nodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NodeType is the instance class to use for the cache nodes.

Requried unless global replication group is specified.

#### `.spec.cache.notificationTopicArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
topic to which notifications will be sent.

#### `.spec.cache.numCacheClusters`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumCacheClusters is the number of cache clusters in the replication group.

If MultiAzEnabled is true, this value must be at least 2 but generally
should be equal to the number of Availability Zones.

Conflicts with NumNodeGroups.

#### `.spec.cache.numCacheNodes`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumCacheNodes is the number of cache nodes in the cluster.

Ignored if replication group is specified or being created
This is a convenience parameter when building a single cluster.

#### `.spec.cache.numNodeGroups`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumNodeGroups is the number of node groups in the replication group.

If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
is true, this value must not be specified.

Conflicts with NumCacheClusters.

#### `.spec.cache.parameterGroupConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ParameterGroupConfiguration defines the configuration for the parameter
group.

#### `.spec.cache.parameterGroupConfiguration.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is a description of the parameter group.

#### `.spec.cache.parameterGroupConfiguration.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Family is the name of the parameter group family that this parameter
group is compatible with.

#### `.spec.cache.parameterGroupConfiguration.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name is the name of the parameter group.

#### `.spec.cache.parameterGroupConfiguration.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Parameters is a list of parameters in the parameter group.

#### `.spec.cache.parameterGroupConfiguration.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a list of key-value pairs to associate with the parameter group.

#### `.spec.cache.parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the parameter group to associate with
this cluster. To create a new parameter group, use the
`ParameterGroupConfiguration` option instead.

#### `.spec.cache.port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Port is the port number on which each of the cache nodes will accept
connections.

#### `.spec.cache.preferredCacheClusterAzs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

PreferredCacheClusterAzs is a list ec2 availability zones in which the
cache clusters will be created.

#### `.spec.cache.preferredCacheClusterAzs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache.replicasPerNodeGroup`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

ReplicasPerNodeGroup is the number of read replicas per node group.

#### `.spec.cache.securityGroupIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SecurityGroupIds is a list of security group IDs to associate with the
cluster.

#### `.spec.cache.securityGroupIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache.snapshotArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
from which to restore data into the cluster.

Optional, Redis only

#### `.spec.cache.snapshotArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cache.snapshotName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotName is the name of the snapshot from which to restore data into
the cluster.

Optional, Redis only

#### `.spec.cache.snapshotRetentionLimit`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

SnapshotRetentionLimit is the number of days for which ElastiCache will
retain automatic cache cluster snapshots before deleting them.

Optional, Redis only

#### `.spec.cache.snapshotWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotWindow is the daily time range (in UTC) during which ElastiCache
will begin taking a daily snapshot of the cache cluster.

Optional, Redis only

#### `.spec.cache.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a list of key-value pairs to associate with the cluster.

#### `.spec.cache.transitEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

TransitEncryptionEnabled specifies whether data in the cluster is
encrypted in transit.

Optional, Memcached only

#### `.spec.cache.usernames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Usernames is a list of users to associate with the cluster.

#### `.spec.cache.usernames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.database`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

Database defines the database settings

#### `.spec.database.activityStream`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ActivityStream is the activity stream configuration.

#### `.spec.database.activityStream.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether activity stream is enabled.

#### `.spec.database.activityStream.engineNativeAuditFieldsIncluded`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EngineNativeAuditFieldsIncluded is whether engine native audit fields are
included. This option only applies to Oracle databases.

#### `.spec.database.activityStream.mode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- sync
- async

Mode is the mode of the activity stream. Valid values are `sync` and `async`.

#### `.spec.database.allocatedStorage`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

AllocatedStorage is the size of the database.

#### `.spec.database.allowMajorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowMajorVersionUpgrade is whether major version upgrades are allowed.

#### `.spec.database.applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately is whether changes should be applied immediately.

#### `.spec.database.autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade is whether minor version upgrades are applied
automatically. This value can be overridden on a per instance basis.

#### `.spec.database.autoscaling`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Autoscaling is the autoscaling configuration.

#### `.spec.database.autoscaling.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Autoscaling is whether autoscaling is enabled.

#### `.spec.database.autoscaling.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxCapacity is the maximum capacity for autoscaling.

#### `.spec.database.autoscaling.metricType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- RDSReaderAverageCPUUtilization
- RDSReaderAverageDatabaseConnections

MetricType is the type of metric to use for autoscaling.

#### `.spec.database.autoscaling.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MinCapacity is the minimum capacity for autoscaling.

#### `.spec.database.autoscaling.policyName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PolicyName is the name of the autoscaling policy.

#### `.spec.database.autoscaling.scaleInCooldown`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

ScaleInCooldown is the amount of time, in seconds, after a scaling in
activity completes before another scaling activity can start.

#### `.spec.database.autoscaling.scaleOutCooldown`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

ScaleOutCooldown is the amount of time, in seconds, after a scaling out
activity completes before another scaling activity can start.

#### `.spec.database.autoscaling.targetCPU`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

TargetCPU is CPU threshold which will initiate autoscaling.

#### `.spec.database.autoscaling.targetConnections`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

TargetConnections is the average number of connections threshold which
will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
default max_connections

#### `.spec.database.backtrackWindow`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

BacktrackWindow is the target backtrack window, in seconds.
Only available for Aurora engine. To disable backtracking, set this value to 0.

#### `.spec.database.backupRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

BackupRetentionPeriod is the number of days to retain backups for.

#### `.spec.database.cloudwatchLogGroupParameters`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

CloudwatchLogGroup defines the parameters for the log groups

#### `.spec.database.cloudwatchLogGroupParameters.class`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Class is the class of the log group.

#### `.spec.database.cloudwatchLogGroupParameters.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create is whether the log group is to be created.

#### `.spec.database.cloudwatchLogGroupParameters.retentionInDays`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

RetentionInDays is the number of days to retain logs for.

#### `.spec.database.cloudwatchLogGroupParameters.skipDestroy`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

SkipDestroy is whether the log group should be skipped during destroy.

#### `.spec.database.copyTagsToSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CopyTagsToSnapshot is whether tags should be copied to snapshots.

#### `.spec.database.createCluster`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CreateCluster is whether the cluster should be created.
By default this is true but for non-aurora clusters, the DB Cluster
resource is optional and can be omitted. In this case, the DB instances
will be created as `instance.rds` types.

#### `.spec.database.databaseName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DatabaseName is the name of the database to create.

#### `.spec.database.dbClusterInstanceClass`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DbClusterInstanceClass is the instance class to use.

#### `.spec.database.dbClusterParameterGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

DbClusterParameterGroup defines the parameters for the DB cluster.

#### `.spec.database.dbClusterParameterGroup.applyMethod`

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

#### `.spec.database.dbClusterParameterGroup.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create is whether the parameter group is to be created.

#### `.spec.database.dbClusterParameterGroup.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is the description of the parameter group.

#### `.spec.database.dbClusterParameterGroup.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Family is the family of the parameter group.

#### `.spec.database.dbClusterParameterGroup.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Name is the name of the parameter group.

#### `.spec.database.dbClusterParameterGroup.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Parameters is a list of parameters to associate with the parameter group.
Note that parameters may differ between families

#### `.spec.database.dbClusterParameterGroup.parameters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|

Parameter is a parameter to associate with a parameter group.

#### `.spec.database.dbClusterParameterGroup.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the parameter group.

#### `.spec.database.dbParameterGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

DbParameterGroup defines the parameters for the DB instance.

#### `.spec.database.dbParameterGroup.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create is whether the parameter group is created.

#### `.spec.database.dbParameterGroup.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is the description of the parameter group.

#### `.spec.database.dbParameterGroup.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Family is the family of the parameter group.

#### `.spec.database.dbParameterGroup.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Name is the name of the parameter group.

#### `.spec.database.dbParameterGroup.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Parameters is a list of parameters to associate with the parameter group.
Note that parameters may differ between families

#### `.spec.database.dbParameterGroup.parameters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|

Parameter is a parameter to associate with a parameter group.

#### `.spec.database.dbParameterGroup.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the parameter group.

#### `.spec.database.deleteAutomatedBackups`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeleteAutomatedBackups is whether automated backups should be deleted.

#### `.spec.database.deletionProtection`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeletionProtection is whether deletion protection is enabled.

#### `.spec.database.domain`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Domain is the domain to use.

#### `.spec.database.domainIAMRoleName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DomainIAMRoleName is the name of the IAM role to use.

#### `.spec.database.enableGlobalWriteForwarding`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableGlobalWriteForwarding is whether global write forwarding is enabled.

#### `.spec.database.enableHttpEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableHttpEndpoint is whether the HTTP endpoint is enabled.

#### `.spec.database.enableLocalWriteForwarding`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

EnableLocalWriteForwarding is whether local write forwarding is enabled.

#### `.spec.database.enabledCloudwatchLogsExports`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.

#### `.spec.database.enabledCloudwatchLogsExports[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

LogGroup is the name of a log group.

#### `.spec.database.endpoints`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Endpoints is a list of custom endpoints to create.

#### `.spec.database.endpoints[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.database.endpoints[*].customEndpointType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- READER
- ANY

CustomEndpointType is the type of the custom endpoint.

#### `.spec.database.endpoints[*].excludedMembers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ExcludedMembers is a list of DB instances that aren't part of the custom
endpoint group.

#### `.spec.database.endpoints[*].excludedMembers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.database.endpoints[*].staticMembers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

StaticMembers is a list of DB instances that are part of the custom
endpoint group.

#### `.spec.database.endpoints[*].staticMembers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.database.endpoints[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the custom endpoint.

#### `.spec.database.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Engine is the database engine to use.

#### `.spec.database.engineMode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- parallelquery
- provisioned
- serverless

EngineMode is the database engine mode to use.

#### `.spec.database.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version of the database engine to use.

#### `.spec.database.enhancedMonitoring`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

EnhancedMonitoring is the enhanced monitoring configuration.

#### `.spec.database.enhancedMonitoring.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is the description of the monitoring role.

#### `.spec.database.enhancedMonitoring.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether enhanced monitoring is enabled.

#### `.spec.database.enhancedMonitoring.forceDetachPolicies`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it

#### `.spec.database.enhancedMonitoring.managedPolicyArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.

#### `.spec.database.enhancedMonitoring.managedPolicyArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.database.enhancedMonitoring.maxSessionDuration`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.

#### `.spec.database.enhancedMonitoring.monitoringInterval`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.

#### `.spec.database.enhancedMonitoring.path`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Path is the path of the monitoring role.

#### `.spec.database.enhancedMonitoring.permissionsBoundary`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.

#### `.spec.database.globalClusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.

#### `.spec.database.iamDatabaseAuthenticationEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.

#### `.spec.database.iamRoles`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

IamRoles is a list of IAM roles to associate with the DB cluster.

#### `.spec.database.iamRoles[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.database.iamRoles[*].featureName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FeatureName is the name of the feature.

#### `.spec.database.iamRoles[*].roleArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RoleArn is the ARN of the role.

#### `.spec.database.instanceCount`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

InstanceCount is the number of instances to create.

If set, this value will create the requested number of instances using
defaults from the cluster configuration. If `instances` are specified,
this value is ignored.

#### `.spec.database.instances`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Instances is a list of instances to create.

#### `.spec.database.instances[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.database.instances[*].allocatedStorage`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

AllocatedStorage is the size of the database.

Only applicable if not running in cluster mode. In cluster mode this value
is ignored.

Overrides `ClusterParameters.AllocatedStorage`

#### `.spec.database.instances[*].allowMajorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowMajorVersionUpgrade is whether major version upgrades are allowed.

Only applicable if not running in cluster mode. In cluster mode this value
is ignored.

Overrides `ClusterParameters.AllowMajorVersionUpgrade`

#### `.spec.database.instances[*].applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately is whether changes should be applied immediately.

Overrides `ClusterParameters.ApplyImmediately`

#### `.spec.database.instances[*].autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade is whether minor version upgrades are applied
automatically.

Overrides `ClusterParameters.AutoMinorVersionUpgrade`

#### `.spec.database.instances[*].availabilityZone`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

AvailabilityZone is the availability zone for this instance.
Ignored if `multiAz` is true

#### `.spec.database.instances[*].backupRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

BackupRetentionPeriod is the number of days to retain backups for.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].copyTagsToSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CopyTagsToSnapshot is whether tags should be copied to snapshots.

#### `.spec.database.instances[*].databaseName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DatabaseName is the name of the database to create.

#### `.spec.database.instances[*].deleteAutomatedBackups`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeleteAutomatedBackups is whether automated backups should be deleted.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].deletionProtection`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DeletionProtection is whether deletion protection is enabled.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].domainIamRoleName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

DomainIamRoleName is the name of the IAM role to use.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].enabledCloudwatchLogsExports`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].enabledCloudwatchLogsExports[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

LogGroup is the name of a log group.

#### `.spec.database.instances[*].finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FinalSnapshotIdentifier is the identifier of the final snapshot.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].iamDatabaseAuthenticationEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

IamDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].instanceClass`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

InstanceClass is the instance class to use.

#### `.spec.database.instances[*].iops`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Iops is the amount of provisioned IOPS.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].licenseModel`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

LicenseModel is the license model to use.

Only applicable if not running in cluster mode.

#### `.spec.database.instances[*].monitoringInterval`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MonitoringInterval is the interval, in seconds, between points when
Enhanced Monitoring metrics are collected for the DB instance.

#### `.spec.database.instances[*].multiAz`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

MultiAZ is whether the DB instance is a Multi-AZ deployment.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NetworkType is the network type to use.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].optionGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

OptionGroupName is the name of the option group to associate with this DB
instance.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the DB parameter group to associate
with this DB instance. Must pre-exist in the account. Mutually exclusive
with `RdsBaseDbCluster.dbParameterGroup`

#### `.spec.database.instances[*].performanceInsightsEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PerformanceInsightsEnabled is whether Performance Insights is enabled.

#### `.spec.database.instances[*].performanceInsightsKmsKeyID`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption
of Performance Insights data.

#### `.spec.database.instances[*].performanceInsightsRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

PerformanceInsightsRetentionPeriod is the amount of time, in days, to
retain Performance Insights data.

#### `.spec.database.instances[*].preferredMaintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredMaintenanceWindow is the preferred maintenance window.

#### `.spec.database.instances[*].promotionTier`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

PromotionTier is the order in which to promote an Aurora replica to the
primary instance.

#### `.spec.database.instances[*].publiclyAccessible`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PubliclyAccessible is whether the DB instance is publicly accessible.

#### `.spec.database.instances[*].skipFinalSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

SkipFinalSnapshot is whether to skip the final snapshot.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].storageEncrypted`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

StorageEncrypted is whether storage is encrypted.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].storageThroughput`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

StorageThroughput is the amount of storage throughput. Only applicable if
`storageType` is `gp3`

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].storageType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

StorageType is the storage type to use.

Only applicable if not running in cluster mode

#### `.spec.database.instances[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the DB instance.

#### `.spec.database.iops`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Iops is the amount of provisioned IOPS.

#### `.spec.database.masterUsername`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MasterUsername is the master username to use.

#### `.spec.database.multiAz`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

MultiAZ is whether the DB instance is a Multi-AZ deployment.

#### `.spec.database.partition`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- aws
- aws-cn
- aws-us-gov

Partition is the AWS partition to use.

#### `.spec.database.performanceInsightsEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PerformanceInsightsEnabled is whether Performance Insights is enabled.

#### `.spec.database.performanceInsightsKmsKeyID`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.

#### `.spec.database.performanceInsightsRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.

#### `.spec.database.preferredBackupWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredBackupWindow is the preferred backup window.

#### `.spec.database.preferredMaintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredMaintenanceWindow is the preferred maintenance window.

#### `.spec.database.provisionSql`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProvisionSql determines whether or not to provision databases inside the
RDS cluster.

#### `.spec.database.provisionSql.connectionSecretName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the connection secret to use for the RDS instance

Required if `providerConfigRef` is not provided, ignored otherwise
Must exist in the same namespace as the provisioning claim

If this value is provided, the composition will attempt to create a
provider config using the engine specific providerconfig spec

#### `.spec.database.provisionSql.databases`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Databases is a map of databases to create.

#### `.spec.database.provisionSql.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Determines if the RDS provisioning should be enabled

#### `.spec.database.provisionSql.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- postgres
- mysql
- aurora-mysql
- aurora-postgresql
- mariadb

The type of database engine being provisioned

#### `.spec.database.provisionSql.readerEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Reader Endpoint is the endpoint to use for read operations

#### `.spec.database.publiclyAccessible`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

PubliclyAccessible is whether the DB instance is publicly accessible.

#### `.spec.database.replicationSourceIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
this DB cluster is to be created as a Read Replica

#### `.spec.database.restoreToPointInTime`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

RestoreToPointInTime is the point in time to restore to.

#### `.spec.database.restoreToPointInTime.identifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Identifier is the identifier of the source DB cluster snapshot or DB
instance snapshot to restore from. Only valid if not running in cluster
mode.

#### `.spec.database.restoreToPointInTime.restoreToTime`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RestoreToTime is the time to restore to.

#### `.spec.database.restoreToPointInTime.restoreType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- full-copy
- copy-on-write

RestoreType is the type of restore to perform. This option is ignored if
not running in cluster mode.

#### `.spec.database.restoreToPointInTime.sourceDbClusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceDbClusterIdentifier is the identifier of the source DB cluster.
This option is ignored if not running in cluster mode.

#### `.spec.database.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

sourceDbInstanceAutomatedBackupsArn is the ARN of the source DB instance
automated backup to restore from. Only valid if not running in cluster mode.

#### `.spec.database.restoreToPointInTime.sourceDbInstanceIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceDbInstanceIdentifier is the identifier of the source DB instance.
Only valid if not running in cluster mode. If running in cluster mode, use
`SourceDbClusterIdentifier` instead.

#### `.spec.database.restoreToPointInTime.sourceDbiResourceId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceDbiResourceId is the resource ID of the source DB instance. Only
valid if not running in cluster mode.

#### `.spec.database.restoreToPointInTime.useLatestRestorableTime`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

UseLatestRestorableTime is whether to use the latest restorable time.

#### `.spec.database.s3Import`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

S3Import is the S3 import configuration.

#### `.spec.database.s3Import.bucketName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

BucketName is the name of the S3 bucket.

#### `.spec.database.s3Import.bucketPrefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
within the bucket where the data is located.

#### `.spec.database.s3Import.ingestionRole`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

IngestionRole is the role to use for ingestion.

#### `.spec.database.s3Import.sourceEngine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceEngine is the source engine to use.

#### `.spec.database.s3Import.sourceEngineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SourceEngineVersion is the source engine version to use.

#### `.spec.database.scalingConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ScalingConfiguration is the scaling configuration.

#### `.spec.database.scalingConfiguration.autoPause`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoPause is whether the database should automatically pause.

#### `.spec.database.scalingConfiguration.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxCapacity is the maximum capacity for the database.

#### `.spec.database.scalingConfiguration.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MinCapacity is the minimum capacity for the database.

#### `.spec.database.scalingConfiguration.secondsUntilAutoPause`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

SecondsUntilAutoPause is the number of seconds until the database
automatically pauses.

#### `.spec.database.secretRotation`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

SecretRotation is the secret rotation configuration.

#### `.spec.database.secretRotation.automaticallyAfterDays`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

AutomaticallyAfterDays is the number of days after which the secret is
rotated automatically.

#### `.spec.database.secretRotation.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is whether secret rotation is enabled.

#### `.spec.database.secretRotation.rotateImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

RotateImmediately is whether the secret should be rotated immediately.

#### `.spec.database.secretRotation.scheduleExpression`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ScheduleExpression is the schedule expression for secret rotation.

#### `.spec.database.serverlessV2ScalingConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.

#### `.spec.database.serverlessV2ScalingConfiguration.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MaxCapacity is the maximum capacity for the database.

#### `.spec.database.serverlessV2ScalingConfiguration.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

MinCapacity is the minimum capacity for the database.

#### `.spec.database.storageThroughput`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

StorageThroughput is the amount of storage throughput. Only applicable if
`storageType` is `gp3`

Only applicable if not running in cluster mode

#### `.spec.database.storageType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

StorageType specifies the storage type to be associated with the cluster

#### `.spec.database.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a set of tags to associate with the DB cluster.

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

#### `.spec.eso`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Eso is the configuration for the external secrets operator

#### `.spec.eso.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled Whether or not to enable `external-secrets-operator` object
deployments using `provider-kubernetes.

#### `.spec.eso.fluxSSASecretName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FluxSSASecretName is the name of the secret that contains SSA details
for each project built with infrastructure components.

This secret will be updated with the name of the current project with
all hyphens, underscores and dots replaced with an empty string.

This secret must exist in the same namespace as the current project.

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

#### `.spec.eso.stores[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name is the name of the secret store.

#### `.spec.eso.tenantCluster`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tenant Cluster details

#### `.spec.eso.tenantCluster.apiServerEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The API endpoint for the tenant cluster.

#### `.spec.eso.tenantCluster.clusterName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the tenant cluster.

#### `.spec.eso.tenantCluster.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled Whether or not to enable `external-secrets-operator` object
deployments using `provider-kubernetes.

#### `.spec.eso.tenantCluster.namespace`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The namespace on the tenant cluster to deploy secrets to. If not set
will default to the `default` namespace.

#### `.spec.kubernetesProviderConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

KubernetesProviderConfig

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

Region is the region in which this collection will be created

#### `.spec.subnetGroupIndexes`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

SubnetGroupIndexes is a map of service name to subnet set indexes

#### `.spec.subnetGroupIndexes.cache`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|

Cache is the subnet group index to use for the cache

#### `.spec.subnetGroupIndexes.database`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|

Database is the subnet group index to use for the database

#### `.spec.vpc`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

Vpc defines the VPC settings

#### `.spec.vpc.peering`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

Peering is the VPC to peer with.

#### `.spec.vpc.peering.allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowPublic specifies if the VPC peering connections should be allowed to

be linked to the public subnets
Defaults to false

#### `.spec.vpc.peering.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled specifies if VPC peering is enabled.

#### `.spec.vpc.peering.groupBy`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GroupBy specifies the key to group the remote subnets by

#### `.spec.vpc.peering.remoteVpcs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|125|

RemoteVpcs is a list of VPCs to peer with.

#### `.spec.vpc.peering.remoteVpcs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.peering.remoteVpcs[*].allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowPublic specifies if the VPC peering connections should be allowed to
be linked to the public subnets

#### `.spec.vpc.peering.remoteVpcs[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name specifies the name of the VPC to peer with.

#### `.spec.vpc.peering.remoteVpcs[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProviderConfigRef specifies the provider config to use for the peering
connection.

#### `.spec.vpc.peering.remoteVpcs[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.vpc.peering.remoteVpcs[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.vpc.peering.remoteVpcs[*].providerConfigRef.policy.resolution`

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

#### `.spec.vpc.peering.remoteVpcs[*].providerConfigRef.policy.resolve`

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

#### `.spec.vpc.peering.remoteVpcs[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region specifies the region the VPC is found in.

If not defined, the region of the VPC will be assumed to be the same as
the region of the peered VPC.

#### `.spec.vpc.ram`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Resource Access Management (RAM)

#### `.spec.vpc.ram.allowExternalPrincipals`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If external principals are allowed to access the resource access manager.

#### `.spec.vpc.ram.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is RAM enabled

#### `.spec.vpc.ram.permissions`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The permissions to associate with the resource access manager.

#### `.spec.vpc.ram.permissions[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.vpc.ram.principals`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of principals to associate with the resource access manager.

#### `.spec.vpc.ram.principals[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.ram.principals[*].crossOrg`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a cross-org principal.

#### `.spec.vpc.ram.principals[*].principal`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The principal to associate with the resource access manager.

Possible values are AWS Account ID, AWS Organization ID, or AWS organizations.

#### `.spec.vpc.ram.principals[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Provider config for accepting the share

#### `.spec.vpc.ram.principals[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.vpc.ram.principals[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.vpc.ram.principals[*].providerConfigRef.policy.resolution`

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

#### `.spec.vpc.ram.principals[*].providerConfigRef.policy.resolve`

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

#### `.spec.vpc.ram.resources`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of resources to associate with the resource access manager.

#### `.spec.vpc.ram.resources[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.vpc.subnetsets`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

PeeredSubnets defines how many public and private subnet sets to create.

#### `.spec.vpc.subnetsets.cidrs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|1|
|Max Items|5|

A list of PeeredSubnetSets to create in the VPC

Each VPC Cidr may be split into *n* public and *n* private subnets as long
as there is enough room on the cidr for it to be split at that level. Any
overflow will cause the composition to fail and this will be reflected in
the status of the XR.

> [!IMPORTANT]
> There must be at least 1 entry in this set which will be used as the VPC
> default CIDR range, and you may define a maximum of 4 additional entries.

#### `.spec.vpc.subnetsets.cidrs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

PeeredSubnetSet defines the parameters for creating a set of subnets with the
same mask.

Either one of Netmask or Prefix must be set.

#### `.spec.vpc.subnetsets.cidrs[*].netmask`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The network mask to use when provisioning from IPAM

#### `.spec.vpc.subnetsets.cidrs[*].prefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|
|Immutability|immutable|

A VPC CIDR or Additional CIDR to use for the VPC. If this is the first
entry in the list, it will be used as the default VPC CIDR, otherwise it
will be assigned as an additional CIDR to the VPC.

#### `.spec.vpc.subnetsets.cidrs[*].private`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

Private is the number of private subnets to create in this set

#### `.spec.vpc.subnetsets.cidrs[*].private.clusterNames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of cluster names that may add load balancers in the tagged subnet
set. Each entry will result in the tag
`kubernetes.io/cluster/$CLUSTER_NAME shared` being added to the subnets
in this set.

See [public.lbSetIndex](#specsubnetsetscidrspubliclbsetindex) and
[private.lbSetIndex](#specsubnetsetscidrsprivatelbsetindex) for deciding
which subnetset gets these tags.

#### `.spec.vpc.subnetsets.cidrs[*].private.clusterNames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.vpc.subnetsets.cidrs[*].private.count`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|
|Immutability|increment only|

Count is the number of subnet sets to create with this mask.

> [!WARNING]
> Whilst this field is not `immutable`, care should be taken to never
> decrease its value once set as this will result in the destruction of
> subnet sets which may fail if there are attached resources.

#### `.spec.vpc.subnetsets.cidrs[*].private.lbSetIndex`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Identifies which subnet set to use for public EKS load balancers. Subnets
in this set will recieve either the `kubernetes.io/role/elb: 1` or
`kubernetes.io/role/internal-elb: 1` tag depending on if these are public
or private subnets.

If this is not set, or set to -1 (the default value), no subnets will be
tagged as load balancer subnets otherwise it should be the index of the
subnet set to tag, starting from index 0.

#### `.spec.vpc.subnetsets.cidrs[*].private.mask`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Immutability|immutable|

This should be a valid CIDR or CIDR suffix (including the prefix `/`) to
use as a mask for the subnet.

To prevent subnets being destroyed and recreated *This field is immutable*

#### `.spec.vpc.subnetsets.cidrs[*].private.offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Offset is the number of bits to offset the subnet mask by

#### `.spec.vpc.subnetsets.cidrs[*].public`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

Details on how to build the public subnets.

Public subnets are subnets with a route to the internet gateway.

> [!IMPORTANT]
> If this is the default VPC CIDR, i.e. the first entry in the list, the
> public subnets will be used for the NAT gateways. Setting this value to
> 0 on the default VPC CIDR may result in the creation of fully private
> networks with no route to the outside world.

#### `.spec.vpc.subnetsets.cidrs[*].public.clusterNames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of cluster names that may add load balancers in the tagged subnet
set. Each entry will result in the tag
`kubernetes.io/cluster/$CLUSTER_NAME shared` being added to the subnets
in this set.

See [public.lbSetIndex](#specsubnetsetscidrspubliclbsetindex) and
[private.lbSetIndex](#specsubnetsetscidrsprivatelbsetindex) for deciding
which subnetset gets these tags.

#### `.spec.vpc.subnetsets.cidrs[*].public.clusterNames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.vpc.subnetsets.cidrs[*].public.count`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|
|Immutability|increment only|

Count is the number of subnet sets to create with this mask.

> [!WARNING]
> Whilst this field is not `immutable`, care should be taken to never
> decrease its value once set as this will result in the destruction of
> subnet sets which may fail if there are attached resources.

#### `.spec.vpc.subnetsets.cidrs[*].public.lbSetIndex`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Identifies which subnet set to use for public EKS load balancers. Subnets
in this set will recieve either the `kubernetes.io/role/elb: 1` or
`kubernetes.io/role/internal-elb: 1` tag depending on if these are public
or private subnets.

If this is not set, or set to -1 (the default value), no subnets will be
tagged as load balancer subnets otherwise it should be the index of the
subnet set to tag, starting from index 0.

#### `.spec.vpc.subnetsets.cidrs[*].public.mask`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Immutability|immutable|

This should be a valid CIDR or CIDR suffix (including the prefix `/`) to
use as a mask for the subnet.

To prevent subnets being destroyed and recreated *This field is immutable*

#### `.spec.vpc.subnetsets.cidrs[*].public.offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Offset is the number of bits to offset the subnet mask by

#### `.spec.vpc.subnetsets.function`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|multiprefixloop|

Allowed Values:

- multiprefixloop

Defines the function to use to calculate the CIDR blocks for thesubnets.

The default value is "multiprefixloop" which will split multiple CIDRs
into equal parts based on the number of bits provided.

`multiprefixloop` is the only function being made available as part of
this XRD and as it's defaulted it can be hidden from the user. The
function input expects a path though so this has to exist but isn't
expected to be defined on the claim.

#### `.spec.vpc.subnetsets.ipam`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this composition is to use IPAM to calculate the CIDR blocks for the
VPC.

#### `.spec.vpc.subnetsets.poolName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the IPAM pool to use.

Only relevant if IPAM is enabled and there are IPAM pools available in
the region.

#### `.spec.vpc.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a map of additional tags to assign to the VPC.

#### `.spec.vpc.tags.cluster`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Cluster tags to apply subnets for autodiscovery of load balancers

#### `.spec.vpc.tags.common`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

common tags apoplied to all resources

#### `.spec.vpc.tags.subnet`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Subnet tags to apply to all subnetsets

#### `.spec.vpc.transitGateway`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

TransitGateway is the transit gateway to attach to the VPC.

#### `.spec.vpc.transitGateway.accountId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Account ID the VPC is in

#### `.spec.vpc.transitGateway.allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowPublic specifies if the VPC peering connections should be allowed to
be linked to the public subnets

#### `.spec.vpc.transitGateway.amazonSideAsn`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Amazon side ASN. Private autonomous system number (ASN) for
the Amazon side of a BGP session.

#### `.spec.vpc.transitGateway.applianceModeSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Appliance mode support. Indicates whether appliance mode support is enabled.

#### `.spec.vpc.transitGateway.autoAcceptSharedAttachments`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Auto accept shared attachments. Indicates whether there is automatic
acceptance of attachment requests.

#### `.spec.vpc.transitGateway.cidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Cidr blocks for the VPC

#### `.spec.vpc.transitGateway.cidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

Cidr is a string type that represents a CIDR block.

#### `.spec.vpc.transitGateway.createPolicyTable`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create the policy table.

#### `.spec.vpc.transitGateway.defaultRouteTableAssociation`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Default route table association. Indicates whether resource attachments
are automatically associated with the default association route table.

#### `.spec.vpc.transitGateway.defaultRouteTablePropagation`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Default route table propagation. Indicates whether resource attachments
automatically propagate routes to the default propagation route table.

#### `.spec.vpc.transitGateway.dnsSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Dns support. Indicates whether DNS support is enabled.

#### `.spec.vpc.transitGateway.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled specifies if the transit gateway is enabled.

#### `.spec.vpc.transitGateway.ipv6Support`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

If IPv6 support is enabled for the transit gateway.

#### `.spec.vpc.transitGateway.multicastSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Multicast support. Indicates whether multicast is enabled on the transit gateway.

Currently unused in this composition

#### `.spec.vpc.transitGateway.peers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Peers is a list of transit gateway peers to connect to

#### `.spec.vpc.transitGateway.peers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.peers[*].accountId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The Account ID this VPC is associated with

#### `.spec.vpc.transitGateway.peers[*].dynamicRouting`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is Dynamic routing support enabled on this peer

#### `.spec.vpc.transitGateway.peers[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The ID of the gateway to peer with

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ManagedPrefixList contains CIDRs for networks that can be traversed
via this transit gateway.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.vpc.transitGateway.peers[*].managedPrefixList[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.vpc.transitGateway.peers[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The name of the peer

#### `.spec.vpc.transitGateway.peers[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProviderConfigRef references a ProviderConfig used to create this
resource

If not provided, will fall back to the top-level ProviderConfigRef

Required for cross account transit gateway peering

#### `.spec.vpc.transitGateway.peers[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.vpc.transitGateway.peers[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.vpc.transitGateway.peers[*].providerConfigRef.policy.resolution`

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

#### `.spec.vpc.transitGateway.peers[*].providerConfigRef.policy.resolve`

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

#### `.spec.vpc.transitGateway.peers[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region the remote transit gateway is located in

#### `.spec.vpc.transitGateway.peers[*].routeTableId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The ID of the remote route table

#### `.spec.vpc.transitGateway.prefixList`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Prefix lists for the VPC

#### `.spec.vpc.transitGateway.prefixList[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.prefixList[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.vpc.transitGateway.prefixList[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.vpc.transitGateway.prefixList[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.vpc.transitGateway.prefixList[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.prefixList[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.vpc.transitGateway.prefixList[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.vpc.transitGateway.prefixList[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.vpc.transitGateway.prefixList[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.vpc.transitGateway.prefixList[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.vpc.transitGateway.prefixLists`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Prefix lists for the VPC

#### `.spec.vpc.transitGateway.prefixLists[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.prefixLists[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.vpc.transitGateway.prefixLists[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.vpc.transitGateway.prefixLists[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.vpc.transitGateway.prefixLists[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.prefixLists[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.vpc.transitGateway.prefixLists[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.vpc.transitGateway.prefixLists[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.vpc.transitGateway.prefixLists[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.vpc.transitGateway.prefixLists[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.vpc.transitGateway.region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region this VPC is located in

#### `.spec.vpc.transitGateway.remoteVpcs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

RemoteVpcs is a list of VPCs build a transit gateway between

#### `.spec.vpc.transitGateway.remoteVpcs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

TgwWrappedVpcWithProviderConfig defines the parameters for creating a VPC with
the option of peered subnets.

#### `.spec.vpc.transitGateway.remoteVpcs[*].accountId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Account ID the VPC is in

#### `.spec.vpc.transitGateway.remoteVpcs[*].allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AllowPublic specifies if the VPC peering connections should be allowed to
be linked to the public subnets

#### `.spec.vpc.transitGateway.remoteVpcs[*].cidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Cidr blocks for the VPC

#### `.spec.vpc.transitGateway.remoteVpcs[*].cidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

Cidr is a string type that represents a CIDR block.

#### `.spec.vpc.transitGateway.remoteVpcs[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The name of the VPC

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Prefix lists for the VPC

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.vpc.transitGateway.remoteVpcs[*].prefixLists[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.vpc.transitGateway.remoteVpcs[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProviderConfigRef references a ProviderConfig used to create this
resource

If not provided, will fall back to the top-level ProviderConfigRef

Required for cross account VPCs
Should not be set for same account VPCs unless restricted by
IAM

#### `.spec.vpc.transitGateway.remoteVpcs[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.vpc.transitGateway.remoteVpcs[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.vpc.transitGateway.remoteVpcs[*].providerConfigRef.policy.resolution`

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

#### `.spec.vpc.transitGateway.remoteVpcs[*].providerConfigRef.policy.resolve`

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

#### `.spec.vpc.transitGateway.remoteVpcs[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region this VPC is located in

#### `.spec.vpc.transitGateway.remoteVpcs[*].routeTableIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Route table ids in the VPC

#### `.spec.vpc.transitGateway.remoteVpcs[*].routeTableIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^rtb-[a-z0-9]{8,17}$`|

RouteTableId is a string type that represents the unique identifier for a
route table.

#### `.spec.vpc.transitGateway.remoteVpcs[*].subnetIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SubnetIds in the VPC

#### `.spec.vpc.transitGateway.remoteVpcs[*].subnetIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^subnet-[a-z0-9]{8,17}$`|

SubnetId is a string type that represents the unique identifier for a subnet.

#### `.spec.vpc.transitGateway.remoteVpcs[*].vpcId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^vpc-[a-z0-9]{8,17}$`|

The ID of the VPC

#### `.spec.vpc.transitGateway.routeTableIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Route table ids in the VPC

#### `.spec.vpc.transitGateway.routeTableIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^rtb-[a-z0-9]{8,17}$`|

RouteTableId is a string type that represents the unique identifier for a
route table.

#### `.spec.vpc.transitGateway.subnetIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SubnetIds in the VPC

#### `.spec.vpc.transitGateway.subnetIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^subnet-[a-z0-9]{8,17}$`|

SubnetId is a string type that represents the unique identifier for a subnet.

#### `.spec.vpc.transitGateway.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

The tags for the transit gateway.

#### `.spec.vpc.transitGateway.transitGatewayDefaultRouteTableAssociation`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

TransitGatewayDefaultRouteTableAssociation. Indicates whether resource
attachments are automatically associated with the default association route table.

#### `.spec.vpc.transitGateway.transitGatewayDefaultRouteTablePropagation`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

TransitGatewayDefaultRouteTablePropagation. Indicates whether resource
attachments automatically propagate routes to the default propagation route table.

#### `.spec.vpc.transitGateway.vpcId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^vpc-[a-z0-9]{8,17}$`|

The ID of the VPC

#### `.spec.vpc.transitGateway.vpnEcmpSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Vpn ecmp support. Indicates whether Equal Cost Multipath Protocol support is enabled.

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

#### `.status.cacheClusterEndpoints`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

CacheClusterEndpoints is a list of endpoints of the Elasticache clusters
when the cache is configured in cluster mode

#### `.status.cacheClusterEndpoints[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.status.cacheConnectionSecret`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheConnectionSecret is the secret containing the connection details for
the Elasticache replication group

#### `.status.cacheEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheEndpoint is the endpoint of the Elasticache replication group

#### `.status.cacheGlobalConnectionSecret`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheGlobalConnectionSecret is the secret containing the connection
details for the global Elasticache replication group

#### `.status.cacheGlobalEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheGlobalEndpoint is the global (RW) endpoint of the Elasticache
global replication group

#### `.status.cacheGlobalReaderEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheGlobalReaderEndpoint is the global (RO) endpoint of the Elasticache
global replication group

#### `.status.cachePort`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

CachePort is the port of the Elasticache

#### `.status.cacheReaderEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheReaderEndpoint is the reader endpoint of the Elasticache replication
group

#### `.status.cacheSubnets`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

CacheSubnets is the list of subnets to be used by ElasticSearch

#### `.status.cacheSubnets[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


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

#### `.status.rdsConnectionSecret`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RdsConnectionSecret is the secret containing the connection details
for the database

#### `.status.rdsEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RdsEndpoint is the endpoint of the database

#### `.status.rdsPort`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

RdsPort is the port of the database

#### `.status.rdsReaderEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

RdsReaderEndpoint is the reader endpoint of the database

#### `.status.rdsSubnets`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

RdsSubnets is the list of subnets to be used by the database

#### `.status.rdsSubnets[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.status.ready`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is the composition complete

#### `.status.vpc`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Vpc is a VPC configuration to bind the cluster to

#### `.status.vpc.additionalCidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of additional VPC CIDR blocks defined in this VPC

#### `.status.vpc.additionalCidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.status.vpc.cidrBlock`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The Ipv4 cidr block defined for this VPC

#### `.status.vpc.id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ID The VPC ID

#### `.status.vpc.internetGateway`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The internet gateway defined in this VPC

#### `.status.vpc.natGateways`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

A map of NAT gateways defined in this VPC

#### `.status.vpc.owner`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The owner of the current VPC

#### `.status.vpc.privateRouteTables`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A map of private route tables defined in this VPC

#### `.status.vpc.privateRouteTables[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

StatusRouteTables is a map of route tables and their status

#### `.status.vpc.privateSubnets`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A map of private subnets defined in this VPC

#### `.status.vpc.privateSubnets[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

StatusSubnets is a map of subnets and their status

#### `.status.vpc.providerConfig`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The provider config used to look up this VPC

#### `.status.vpc.publicRouteTables`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A map of public route tables defined in this VPC

#### `.status.vpc.publicRouteTables[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

StatusRouteTables is a map of route tables and their status

#### `.status.vpc.publicSubnets`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of maps of public subnets defined in this VPC

#### `.status.vpc.publicSubnets[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

StatusSubnets is a map of subnets and their status

#### `.status.vpc.region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The region this VPC is located in

#### `.status.vpc.securityGroups`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

A map of security groups defined in this VPC

#### `.status.vpc.transitGateways`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

A map of transit gateways defined in this VPC

#### `.status.vpc.vpcPeeringConnections`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

A map of VPC peering connections defined in this VPC
