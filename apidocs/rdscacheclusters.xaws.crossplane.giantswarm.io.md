---
title: RdsCacheCluster CRD schema reference (group xaws.crossplane.giantswarm.io)
linkTitle: RdsCacheCluster
description: |
  Custom resource definition (CRD) schema reference page for the RdsCacheCluster resource (rdscacheclusters.xaws.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
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
  group: xaws.crossplane.giantswarm.io
  technical_name: rdscacheclusters.xaws.crossplane.giantswarm.io
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
  - /reference/cp-k8s-api/rdscacheclusters.xaws.crossplane.giantswarm.io/
technical_name: rdscacheclusters.xaws.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# RdsCacheCluster

<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">rdscacheclusters.xaws.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">RdsCacheClusterClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">rdscacheclusterclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">rds-cache-cluster</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">rds-cache-cluster</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xaws.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">rdscachecluster</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">
  <ul>
  
  <li>rdscc</li>
  
</dd>

<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">rdscacheclusters</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



## Version `v1alpha1`


### Spec Properties
<details>
<summary>
  <h4>.spec.availabilityZones</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|3|
|Max Items|3|


AvailabilityZones is the list of availability zones to be used by the cluster
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
  <h4>.spec.cache</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Cache defines the cache settings
</details>
<details>
<summary>
  <h4>.spec.cache.applyImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.
</details>
<details>
<summary>
  <h4>.spec.cache.atRestEncryptionEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AtRestEncryptionEnabled specifies whether data stored in the cluster is
  encrypted at rest.
</details>
<details>
<summary>
  <h4>.spec.cache.authTokenUpdateStrategy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- rotate
- set

AuthTokenUpdateStrategy specifies how the auth token should be updated.
  
  
  Valid values are:
  - ROTATE
  - SET
  - DELETE
</details>
<details>
<summary>
  <h4>.spec.cache.autoMinorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.
</details>
<details>
<summary>
  <h4>.spec.cache.automaticFailoverEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
  
  
  If enabled, NumCacheNodes must be greater than 1. Must be enabled for
  Redis (cluster mode enabled) replication groups.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheClusters is a list of cache clusters in the replication group.
  
  
  This value is overridden by NumCacheClusters.
  
  
  May be used to specify cluster specific configuration.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].applyImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].autoMinorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].availabilityZone</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the name of the Availability Zone in which the
  cluster will be created.
  
  
  If you want to create cache nodes in multi-az, use
  preferred_availability_zones instead.
  Default: System chosen Availability Zone.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].azMode</h4>
</summary>

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
  
  
  Valid values are:
  - single-az: The cluster is created in a single Availability Zone.
  - cross-az: The cluster is created across multiple Availability Zones.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].engine</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Allowed Values:
- memcached
- redis

Engine is the name of the cache engine to be used for the clusters in
  this group.
  
  
  Valid values are:
  - memcached
  - redis
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].engineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].finalSnapshotIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].ipDiscovery</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- ipv4
- ipv6

IpDiscovery is the method used to discover cluster nodes.
  
  
  Valid values are:
  - ipv4 (default)
  - ipv6
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].logDeliveryConfigurations</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].logDeliveryConfigurations[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].destination</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].destinationType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Allowed Values:
- cloudwatch-logs
- kinesis-firehose

DestinationType The destination type for the logs.
  
  
  Valid values are:
  - cloudwatch-logs
  - kinesis-firehose
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].logFormat</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- text
- json

LogFormat The log format to use.
  
  
  Valid values are:
  - text
  - json
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].logDeliveryConfigurations[*].logType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Allowed Values:
- slow-log
- engine-log

LogType The type of log to deliver.
  
  
  Valid values are:
  - slow-log
  - engine-log
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].maintenanceWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].networkType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- ipv4
- ipv6
- dual_stack

NetworkType specifies the network configuration for the cluster.
  
  
  Valid values are:
  - ipv4
  - ipv6
  - dual_stack
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].nodeType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless replication group is specified.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].notificationTopicArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].numCacheNodes</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Required unless replication group is specified.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].outpostMode</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- single-outpost
- cross-outpost

OutpostMode specifies the outpost mode that will apply to the cache
  cluster creation.
  
  
  Valid values are:
  - single-outpost
  - cross-outpost
  
  
  Currently only single-outpost is supported.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].parameterGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster.
  
  
  Required unless replication group is specified.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].port</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].preferredAvailabilityZones</h4>
</summary>

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
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].preferredAvailabilityZones[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].preferredOutpostArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
  which the cache cluster will be created.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].securityGroupIds</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].securityGroupIds[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].snapshotArns</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].snapshotArns[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].snapshotName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].snapshotRetentionLimit</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].snapshotWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].subnetGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SubnetGroupName is the name of the subnet group to associate with this
  cluster.
  
  
  Required unless replication group is specified in which case it will be
  ignored.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.
</details>
<details>
<summary>
  <h4>.spec.cache.cacheClusters[*].transitEncryptionEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only
</details>
<details>
<summary>
  <h4>.spec.cache.clusterModeEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ClusterModeEnabled specifies whether cluster mode is enabled for the
  replication group.
</details>
<details>
<summary>
  <h4>.spec.cache.createReplicationGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateReplicationGroup specifies whether a replication group should be
  created.
  
  
  If set false, the replication group configuration will be used for
  creating a single cluster
</details>
<details>
<summary>
  <h4>.spec.cache.dataTieringEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DataTieringEnabled specifies whether data tiering is enabled for the
  replication group.
  
  
  Must be true if the replcation group is using r6gd nodes
</details>
<details>
<summary>
  <h4>.spec.cache.engine</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- memcached
- redis

Engine is the name of the cache engine to be used for the clusters in
  this group.
  
  
  Valid values are:
  - memcached
  - redis
</details>
<details>
<summary>
  <h4>.spec.cache.engineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.
</details>
<details>
<summary>
  <h4>.spec.cache.finalSnapshotIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


GlobalReplicationGroup is the global replication group configuration.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.automaticFailoverEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.cacheNodeType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheNodeType is the instance class to use for the cache nodes.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is a flag that enables the global replication group.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.engineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.numNodeGroups</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.parameterGroupName</h4>
</summary>

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
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroup.suffix</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupIdSuffix is the suffix to append to the global
  replication group id.
</details>
<details>
<summary>
  <h4>.spec.cache.globalReplicationGroupId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupId is the id of the global replication group to
  which this replication group should belong.
  
  
  If this value is specified, the number of node groups parameter must not
  be specified.
</details>
<details>
<summary>
  <h4>.spec.cache.ipDiscovery</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- ipv4
- ipv6

IpDiscovery is the method used to discover cluster nodes.
  
  
  Valid values are:
  - ipv4 (default)
  - ipv6
</details>
<details>
<summary>
  <h4>.spec.cache.kmsKeyId</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
  encrypt the data in the cluster.
  
  
  Ignored unless AtRestEncryptionEnabled is set to true.
</details>
<details>
<summary>
  <h4>.spec.cache.logDeliveryConfigurations</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.
</details>
<details>
<summary>
  <h4>.spec.cache.logDeliveryConfigurations[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.logDeliveryConfigurations[*].destination</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.
</details>
<details>
<summary>
  <h4>.spec.cache.logDeliveryConfigurations[*].destinationType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Allowed Values:
- cloudwatch-logs
- kinesis-firehose

DestinationType The destination type for the logs.
  
  
  Valid values are:
  - cloudwatch-logs
  - kinesis-firehose
</details>
<details>
<summary>
  <h4>.spec.cache.logDeliveryConfigurations[*].logFormat</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- text
- json

LogFormat The log format to use.
  
  
  Valid values are:
  - text
  - json
</details>
<details>
<summary>
  <h4>.spec.cache.logDeliveryConfigurations[*].logType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Allowed Values:
- slow-log
- engine-log

LogType The type of log to deliver.
  
  
  Valid values are:
  - slow-log
  - engine-log
</details>
<details>
<summary>
  <h4>.spec.cache.maintenanceWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.
</details>
<details>
<summary>
  <h4>.spec.cache.multiAzEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAzEnabled specifies whether the cluster should be created in
  multiple Availability Zones.
  
  
  If true, AutomaticFailoverEnabled must also be true.
</details>
<details>
<summary>
  <h4>.spec.cache.networkType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- ipv4
- ipv6
- dual_stack

NetworkType specifies the network configuration for the cluster.
  
  
  Valid values are:
  - ipv4
  - ipv6
  - dual_stack
</details>
<details>
<summary>
  <h4>.spec.cache.nodeType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless global replication group is specified.
</details>
<details>
<summary>
  <h4>.spec.cache.notificationTopicArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.
</details>
<details>
<summary>
  <h4>.spec.cache.numCacheClusters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheClusters is the number of cache clusters in the replication group.
  
  
  If MultiAzEnabled is true, this value must be at least 2 but generally
  should be equal to the number of Availability Zones.
  
  
  Conflicts with NumNodeGroups.
</details>
<details>
<summary>
  <h4>.spec.cache.numCacheNodes</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Ignored if replication group is specified or being created
  This is a convenience parameter when building a single cluster.
</details>
<details>
<summary>
  <h4>.spec.cache.numNodeGroups</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
  
  
  If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
  is true, this value must not be specified.
  
  
  Conflicts with NumCacheClusters.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupConfiguration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ParameterGroupConfiguration defines the configuration for the parameter
  group.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupConfiguration.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is a description of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupConfiguration.family</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Family is the name of the parameter group family that this parameter
  group is compatible with.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupConfiguration.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupConfiguration.parameters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Parameters is a list of parameters in the parameter group.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupConfiguration.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the parameter group.
</details>
<details>
<summary>
  <h4>.spec.cache.parameterGroupName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster. To create a new parameter group, use the
  `ParameterGroupConfiguration` option instead.
</details>
<details>
<summary>
  <h4>.spec.cache.port</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
</details>
<details>
<summary>
  <h4>.spec.cache.preferredCacheClusterAzs</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


PreferredCacheClusterAzs is a list ec2 availability zones in which the
  cache clusters will be created.
</details>
<details>
<summary>
  <h4>.spec.cache.preferredCacheClusterAzs[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.replicasPerNodeGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ReplicasPerNodeGroup is the number of read replicas per node group.
</details>
<details>
<summary>
  <h4>.spec.cache.securityGroupIds</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.
</details>
<details>
<summary>
  <h4>.spec.cache.securityGroupIds[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.snapshotArns</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.snapshotArns[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.cache.snapshotName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.snapshotRetentionLimit</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.snapshotWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only
</details>
<details>
<summary>
  <h4>.spec.cache.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.
</details>
<details>
<summary>
  <h4>.spec.cache.transitEncryptionEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only
</details>
<details>
<summary>
  <h4>.spec.cache.usernames</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Usernames is a list of users to associate with the cluster.
</details>
<details>
<summary>
  <h4>.spec.cache.usernames[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Database defines the database settings
</details>
<details>
<summary>
  <h4>.spec.database.activityStream</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ActivityStream is the activity stream configuration.
</details>
<details>
<summary>
  <h4>.spec.database.activityStream.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether activity stream is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.activityStream.engineNativeAuditFieldsIncluded</h4>
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
  <h4>.spec.database.activityStream.mode</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- sync
- async

Mode is the mode of the activity stream. Valid values are `sync` and `async`.
</details>
<details>
<summary>
  <h4>.spec.database.allocatedStorage</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
</details>
<details>
<summary>
  <h4>.spec.database.allowMajorVersionUpgrade</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
</details>
<details>
<summary>
  <h4>.spec.database.applyImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
</details>
<details>
<summary>
  <h4>.spec.database.autoMinorVersionUpgrade</h4>
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
  <h4>.spec.database.autoscaling</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Autoscaling is the autoscaling configuration.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Autoscaling is whether autoscaling is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.maxCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for autoscaling.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.metricType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- RDSReaderAverageCPUUtilization
- RDSReaderAverageDatabaseConnections

MetricType is the type of metric to use for autoscaling.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.minCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for autoscaling.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.policyName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PolicyName is the name of the autoscaling policy.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.scaleInCooldown</h4>
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
  <h4>.spec.database.autoscaling.scaleOutCooldown</h4>
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
  <h4>.spec.database.autoscaling.targetCPU</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetCPU is CPU threshold which will initiate autoscaling.
</details>
<details>
<summary>
  <h4>.spec.database.autoscaling.targetConnections</h4>
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
  <h4>.spec.database.backtrackWindow</h4>
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
  <h4>.spec.database.backupRetentionPeriod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
</details>
<details>
<summary>
  <h4>.spec.database.cloudwatchLogGroupParameters</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


CloudwatchLogGroup defines the parameters for the log groups
</details>
<details>
<summary>
  <h4>.spec.database.cloudwatchLogGroupParameters.class</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Class is the class of the log group.
</details>
<details>
<summary>
  <h4>.spec.database.cloudwatchLogGroupParameters.create</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the log group is to be created.
</details>
<details>
<summary>
  <h4>.spec.database.cloudwatchLogGroupParameters.retentionInDays</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RetentionInDays is the number of days to retain logs for.
</details>
<details>
<summary>
  <h4>.spec.database.cloudwatchLogGroupParameters.skipDestroy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipDestroy is whether the log group should be skipped during destroy.
</details>
<details>
<summary>
  <h4>.spec.database.copyTagsToSnapshot</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
</details>
<details>
<summary>
  <h4>.spec.database.createCluster</h4>
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
  <h4>.spec.database.databaseName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
</details>
<details>
<summary>
  <h4>.spec.database.databases</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Databases is a map of databases to create.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterInstanceClass</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbClusterInstanceClass is the instance class to use.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbClusterParameterGroup defines the parameters for the DB cluster.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup.applyMethod</h4>
</summary>

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
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup.create</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is to be created.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup.family</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbClusterParameterGroup.parameters</h4>
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
  <h4>.spec.database.dbClusterParameterGroup.parameters[*]</h4>
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
  <h4>.spec.database.dbClusterParameterGroup.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbParameterGroup</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbParameterGroup defines the parameters for the DB instance.
</details>
<details>
<summary>
  <h4>.spec.database.dbParameterGroup.create</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is created.
</details>
<details>
<summary>
  <h4>.spec.database.dbParameterGroup.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbParameterGroup.family</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbParameterGroup.name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.dbParameterGroup.parameters</h4>
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
  <h4>.spec.database.dbParameterGroup.parameters[*]</h4>
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
  <h4>.spec.database.dbParameterGroup.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
</details>
<details>
<summary>
  <h4>.spec.database.deleteAutomatedBackups</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
</details>
<details>
<summary>
  <h4>.spec.database.deletionProtection</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.domain</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Domain is the domain to use.
</details>
<details>
<summary>
  <h4>.spec.database.domainIAMRoleName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIAMRoleName is the name of the IAM role to use.
</details>
<details>
<summary>
  <h4>.spec.database.enableGlobalWriteForwarding</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableGlobalWriteForwarding is whether global write forwarding is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.enableHttpEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableHttpEndpoint is whether the HTTP endpoint is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.enableLocalWriteForwarding</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableLocalWriteForwarding is whether local write forwarding is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.enabledCloudwatchLogsExports</h4>
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
  <h4>.spec.database.enabledCloudwatchLogsExports[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
</details>
<details>
<summary>
  <h4>.spec.database.endpoints</h4>
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
  <h4>.spec.database.endpoints[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database.endpoints[*].customEndpointType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- READER
- ANY

CustomEndpointType is the type of the custom endpoint.
</details>
<details>
<summary>
  <h4>.spec.database.endpoints[*].excludedMembers</h4>
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
  <h4>.spec.database.endpoints[*].excludedMembers[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database.endpoints[*].staticMembers</h4>
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
  <h4>.spec.database.endpoints[*].staticMembers[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database.endpoints[*].tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the custom endpoint.
</details>
<details>
<summary>
  <h4>.spec.database.engine</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Engine is the database engine to use.
</details>
<details>
<summary>
  <h4>.spec.database.engineMode</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- parallelquery
- provisioned
- serverless

EngineMode is the database engine mode to use.
</details>
<details>
<summary>
  <h4>.spec.database.engineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version of the database engine to use.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


EnhancedMonitoring is the enhanced monitoring configuration.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.description</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether enhanced monitoring is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.forceDetachPolicies</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.managedPolicyArns</h4>
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
  <h4>.spec.database.enhancedMonitoring.managedPolicyArns[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.maxSessionDuration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.monitoringInterval</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.path</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Path is the path of the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.database.enhancedMonitoring.permissionsBoundary</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.
</details>
<details>
<summary>
  <h4>.spec.database.eso</h4>
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
  <h4>.spec.database.eso.enabled</h4>
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
  <h4>.spec.database.eso.kubernetesSecretStore</h4>
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
  <h4>.spec.database.eso.stores</h4>
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
  <h4>.spec.database.eso.stores[*]</h4>
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
  <h4>.spec.database.eso.stores[*].enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether the secrets store is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.eso.stores[*].isClusterSecretStore</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IsClusterSecretStore is whether the secret store is a cluster secret store.
</details>
<details>
<summary>
  <h4>.spec.database.eso.stores[*].secretStore</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


SecretStoreName is the name of the secret store.
</details>
<details>
<summary>
  <h4>.spec.database.globalClusterIdentifier</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.
</details>
<details>
<summary>
  <h4>.spec.database.iamDatabaseAuthenticationEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.iamRoles</h4>
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
  <h4>.spec.database.iamRoles[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database.iamRoles[*].featureName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FeatureName is the name of the feature.
</details>
<details>
<summary>
  <h4>.spec.database.iamRoles[*].roleArn</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RoleArn is the ARN of the role.
</details>
<details>
<summary>
  <h4>.spec.database.instanceCount</h4>
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
  <h4>.spec.database.instances</h4>
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
  <h4>.spec.database.instances[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.database.instances[*].allocatedStorage</h4>
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
  <h4>.spec.database.instances[*].allowMajorVersionUpgrade</h4>
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
  <h4>.spec.database.instances[*].applyImmediately</h4>
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
  <h4>.spec.database.instances[*].autoMinorVersionUpgrade</h4>
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
  <h4>.spec.database.instances[*].availabilityZone</h4>
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
  <h4>.spec.database.instances[*].backupRetentionPeriod</h4>
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
  <h4>.spec.database.instances[*].copyTagsToSnapshot</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].databaseName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].deleteAutomatedBackups</h4>
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
  <h4>.spec.database.instances[*].deletionProtection</h4>
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
  <h4>.spec.database.instances[*].domainIamRoleName</h4>
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
  <h4>.spec.database.instances[*].enabledCloudwatchLogsExports</h4>
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
  <h4>.spec.database.instances[*].enabledCloudwatchLogsExports[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].finalSnapshotIdentifier</h4>
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
  <h4>.spec.database.instances[*].iamDatabaseAuthenticationEnabled</h4>
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
  <h4>.spec.database.instances[*].instanceClass</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


InstanceClass is the instance class to use.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].iops</h4>
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
  <h4>.spec.database.instances[*].licenseModel</h4>
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
  <h4>.spec.database.instances[*].monitoringInterval</h4>
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
  <h4>.spec.database.instances[*].multiAz</h4>
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
  <h4>.spec.database.instances[*].networkType</h4>
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
  <h4>.spec.database.instances[*].optionGroupName</h4>
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
  <h4>.spec.database.instances[*].parameterGroupName</h4>
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
  <h4>.spec.database.instances[*].performanceInsightsEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].performanceInsightsKmsKeyID</h4>
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
  <h4>.spec.database.instances[*].performanceInsightsRetentionPeriod</h4>
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
  <h4>.spec.database.instances[*].preferredMaintenanceWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].promotionTier</h4>
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
  <h4>.spec.database.instances[*].publiclyAccessible</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
</details>
<details>
<summary>
  <h4>.spec.database.instances[*].skipFinalSnapshot</h4>
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
  <h4>.spec.database.instances[*].storageEncrypted</h4>
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
  <h4>.spec.database.instances[*].storageThroughput</h4>
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
  <h4>.spec.database.instances[*].storageType</h4>
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
  <h4>.spec.database.instances[*].tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB instance.
</details>
<details>
<summary>
  <h4>.spec.database.iops</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
</details>
<details>
<summary>
  <h4>.spec.database.masterUsername</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MasterUsername is the master username to use.
</details>
<details>
<summary>
  <h4>.spec.database.multiAz</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
</details>
<details>
<summary>
  <h4>.spec.database.partition</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- aws
- aws-cn
- aws-us-gov

Partition is the AWS partition to use.
</details>
<details>
<summary>
  <h4>.spec.database.performanceInsightsEnabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.performanceInsightsKmsKeyID</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.
</details>
<details>
<summary>
  <h4>.spec.database.performanceInsightsRetentionPeriod</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.
</details>
<details>
<summary>
  <h4>.spec.database.preferredBackupWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredBackupWindow is the preferred backup window.
</details>
<details>
<summary>
  <h4>.spec.database.preferredMaintenanceWindow</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
</details>
<details>
<summary>
  <h4>.spec.database.provisionSql</h4>
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
  <h4>.spec.database.publiclyAccessible</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
</details>
<details>
<summary>
  <h4>.spec.database.replicationSourceIdentifier</h4>
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
  <h4>.spec.database.restoreToPointInTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


RestoreToPointInTime is the point in time to restore to.
</details>
<details>
<summary>
  <h4>.spec.database.restoreToPointInTime.identifier</h4>
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
  <h4>.spec.database.restoreToPointInTime.restoreToTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RestoreToTime is the time to restore to.
</details>
<details>
<summary>
  <h4>.spec.database.restoreToPointInTime.restoreType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- full-copy
- copy-on-write

RestoreType is the type of restore to perform. This option is ignored if
  not running in cluster mode.
</details>
<details>
<summary>
  <h4>.spec.database.restoreToPointInTime.sourceDbClusterIdentifier</h4>
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
  <h4>.spec.database.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn</h4>
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
  <h4>.spec.database.restoreToPointInTime.sourceDbInstanceIdentifier</h4>
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
  <h4>.spec.database.restoreToPointInTime.sourceDbiResourceId</h4>
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
  <h4>.spec.database.restoreToPointInTime.useLatestRestorableTime</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


UseLatestRestorableTime is whether to use the latest restorable time.
</details>
<details>
<summary>
  <h4>.spec.database.s3Import</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


S3Import is the S3 import configuration.
</details>
<details>
<summary>
  <h4>.spec.database.s3Import.bucketName</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketName is the name of the S3 bucket.
</details>
<details>
<summary>
  <h4>.spec.database.s3Import.bucketPrefix</h4>
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
  <h4>.spec.database.s3Import.ingestionRole</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


IngestionRole is the role to use for ingestion.
</details>
<details>
<summary>
  <h4>.spec.database.s3Import.sourceEngine</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngine is the source engine to use.
</details>
<details>
<summary>
  <h4>.spec.database.s3Import.sourceEngineVersion</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngineVersion is the source engine version to use.
</details>
<details>
<summary>
  <h4>.spec.database.scalingConfiguration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ScalingConfiguration is the scaling configuration.
</details>
<details>
<summary>
  <h4>.spec.database.scalingConfiguration.autoPause</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoPause is whether the database should automatically pause.
</details>
<details>
<summary>
  <h4>.spec.database.scalingConfiguration.maxCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.database.scalingConfiguration.minCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.database.scalingConfiguration.secondsUntilAutoPause</h4>
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
  <h4>.spec.database.secretRotation</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretRotation is the secret rotation configuration.
</details>
<details>
<summary>
  <h4>.spec.database.secretRotation.automaticallyAfterDays</h4>
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
  <h4>.spec.database.secretRotation.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether secret rotation is enabled.
</details>
<details>
<summary>
  <h4>.spec.database.secretRotation.rotateImmediately</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


RotateImmediately is whether the secret should be rotated immediately.
</details>
<details>
<summary>
  <h4>.spec.database.secretRotation.scheduleExpression</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ScheduleExpression is the schedule expression for secret rotation.
</details>
<details>
<summary>
  <h4>.spec.database.serverlessV2ScalingConfiguration</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.
</details>
<details>
<summary>
  <h4>.spec.database.serverlessV2ScalingConfiguration.maxCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.database.serverlessV2ScalingConfiguration.minCapacity</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
</details>
<details>
<summary>
  <h4>.spec.database.storageType</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType specifies the storage type to be associated with the cluster
</details>
<details>
<summary>
  <h4>.spec.database.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB cluster.
</details>
<details>
<summary>
  <h4>.spec.deletionPolicy</h4>
</summary>

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
</details>
<details>
<summary>
  <h4>.spec.kubernetesProviderConfig</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


KubernetesProviderConfig
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
  <h4>.spec.providerConfigRef</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


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
|Default Value|Required|


Allowed Values:
- Required
- Optional

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
- Always
- IfNotPresent

Resolve specifies when this reference should be resolved. The default
  is 'IfNotPresent', which will attempt to resolve the reference only when
  the corresponding field is not present. Use 'Always' to resolve the
  reference on every reconcile.
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
|Default Value|{name:default}|


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
|Default Value|Required|


Allowed Values:
- Required
- Optional

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
- Always
- IfNotPresent

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


Region is the region in which this collection will be created
</details>
<details>
<summary>
  <h4>.spec.subnetGroupIndexes</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SubnetGroupIndexes is a map of service name to subnet set indexes
</details>
<details>
<summary>
  <h4>.spec.subnetGroupIndexes.cache</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Cache is the subnet group index to use for the cache
</details>
<details>
<summary>
  <h4>.spec.subnetGroupIndexes.database</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Database is the subnet group index to use for the database
</details>
<details>
<summary>
  <h4>.spec.vpc</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Vpc defines the VPC settings
</details>
<details>
<summary>
  <h4>.spec.vpc.peering</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Peering is the VPC to peer with.
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.allowPublic</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowPublic specifies if the VPC peering connections should be allowed to
  be linked to the public subnets
  Defaults to false
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.enabled</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled specifies if the VPC peering connections should be enabled for
  this VPC.
  Defaults to false
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.groupBy</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GroupBy specifies the key to group the remote subnets by
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|125|


RemoteVpcs is a list of VPCs to peer with.
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


VpcPeer defines the parameters for peering with a VPC.
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].allowPublic</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Disabled specifies if the peering connection should be disabled.
  Defaults to true
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ExcludeFromLocalPeering specifies the indexes of subnetsets for this VPC to
  exclude from routing to the peering connection
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.private</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.private[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.public</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.public[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludeFromRemotePeering specifies the indexes of subnetsets for the remote
  VPC to exclude from routing to the peering connection. If emmpty, all
  subnetsets will be included by default
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].private</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].private[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].public</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].public[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].name</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name specifies the name of the VPC to peer with.
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].providerConfigRef</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ProviderConfigRef specifies the provider config to use for the peering
  connection.
</details>
<details>
<summary>
  <h4>.spec.vpc.peering.remoteVpcs[*].region</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Region specifies the region the VPC is found in.
  
  
  If not defined, the region of the VPC will be assumed to be the same as
  the region of the peered VPC.
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


PeeredSubnets defines how many public and private subnet sets to create.
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|1|
|Max Items|5|


Cidrs is a list of PeeredSubnetSets to create in the VPC
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PeeredSubnetSet defines the parameters for creating a set of subnets with the
  same mask.
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].prefix</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|


Prefix is the CIDR prefix to use for the subnet set
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Private is the number of private subnets to create in this set
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private.clusterNames</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterNames is a list of EKS cluster names to add shared LB tags for
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private.clusterNames[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private.count</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Count is the number of subnet sets to create with this mask
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private.lbSetIndex</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Determines which subnet set in this range to use for kubernetes load
  balancers. -1 means no load balancer tag is defined on this group
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private.mask</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Mask is the CIDR mask to use for the subnet set
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].private.offset</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Public is the number of public subnets to create in this set
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public.clusterNames</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterNames is a list of EKS cluster names to add shared LB tags for
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public.clusterNames[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public.count</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Count is the number of subnet sets to create with this mask
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public.lbSetIndex</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Determines which subnet set in this range to use for kubernetes load
  balancers. -1 means no load balancer tag is defined on this group
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public.mask</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Mask is the CIDR mask to use for the subnet set
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.cidrs[*].public.offset</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by
</details>
<details>
<summary>
  <h4>.spec.vpc.subnetsets.function</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|multiprefixloop|


Allowed Values:
- multiprefixloop

Function defines the function to use to calculate the CIDR blocks for the
  subnets. The default is "multiprefixloop" which will split multiple CIDRs
  into equal parts based on the number of bits provided.
  `multiprefixloop` is the only function being made available as part of
  this XRD and as it's defaulted it can be hidden from the user. The
  function input expects a path though so this has to exist but isn't
  expected to be defined on the claim.
</details>
<details>
<summary>
  <h4>.spec.vpc.tags</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a map of additional tags to assign to the VPC.
</details>
<details>
<summary>
  <h4>.spec.vpc.tags.cluster</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Cluster tags to apply subnets for autodiscovery of load balancers
</details>
<details>
<summary>
  <h4>.spec.vpc.tags.common</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


common tags apoplied to all resources
</details>
<details>
<summary>
  <h4>.spec.vpc.tags.subnet</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Subnet tags to apply to all subnetsets
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
  <h4>.status.cacheClusterEndpoints</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheClusterEndpoints is a list of endpoints of the Elasticache clusters
  when the cache is configured in cluster mode
</details>
<details>
<summary>
  <h4>.status.cacheClusterEndpoints[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.status.cacheConnectionSecret</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheConnectionSecret is the secret containing the connection details for
  the Elasticache replication group
</details>
<details>
<summary>
  <h4>.status.cacheEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheEndpoint is the endpoint of the Elasticache replication group
</details>
<details>
<summary>
  <h4>.status.cacheGlobalConnectionSecret</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheGlobalConnectionSecret is the secret containing the connection
  details for the global Elasticache replication group
</details>
<details>
<summary>
  <h4>.status.cacheGlobalEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheGlobalEndpoint is the global (RW) endpoint of the Elasticache
  global replication group
</details>
<details>
<summary>
  <h4>.status.cacheGlobalReaderEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheGlobalReaderEndpoint is the global (RO) endpoint of the Elasticache
  global replication group
</details>
<details>
<summary>
  <h4>.status.cachePort</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


CachePort is the port of the Elasticache
</details>
<details>
<summary>
  <h4>.status.cacheReaderEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheReaderEndpoint is the reader endpoint of the Elasticache replication
  group
</details>
<details>
<summary>
  <h4>.status.cacheSubnets</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheSubnets is the list of subnets to be used by ElasticSearch
</details>
<details>
<summary>
  <h4>.status.cacheSubnets[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


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
  <h4>.status.rdsConnectionSecret</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RdsConnectionSecret is the secret containing the connection details
  for the database
</details>
<details>
<summary>
  <h4>.status.rdsEndpoint</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RdsEndpoint is the endpoint of the database
</details>
<details>
<summary>
  <h4>.status.rdsPort</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RdsPort is the port of the database
</details>
<details>
<summary>
  <h4>.status.rdsSubnets</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


RdsSubnets is the list of subnets to be used by the database
</details>
<details>
<summary>
  <h4>.status.rdsSubnets[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.status.vpc</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Vpc is a VPC configuration to bind the cluster to
</details>
<details>
<summary>
  <h4>.status.vpc.additionalCidrBlocks</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A list of additional VPC CIDR blocks defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.additionalCidrBlocks[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


</details>
<details>
<summary>
  <h4>.status.vpc.cidrBlock</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The Ipv4 cidr block defined for this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.id</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


ID The VPC ID
</details>
<details>
<summary>
  <h4>.status.vpc.internetGateway</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The internet gateway defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.natGateways</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of NAT gateways defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.privateRouteTables</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A map of private route tables defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.privateRouteTables[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusRouteTables is a map of route tables and their status
</details>
<details>
<summary>
  <h4>.status.vpc.privateSubnets</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A map of private subnets defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.privateSubnets[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusSubnets is a map of subnets and their status
</details>
<details>
<summary>
  <h4>.status.vpc.providerConfig</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The provider config used to look up this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.publicRouteTables</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A map of public route tables defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.publicRouteTables[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusRouteTables is a map of route tables and their status
</details>
<details>
<summary>
  <h4>.status.vpc.publicSubnets</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A list of maps of public subnets defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.publicSubnets[*]</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusSubnets is a map of subnets and their status
</details>
<details>
<summary>
  <h4>.status.vpc.region</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The region this VPC is located in
</details>
<details>
<summary>
  <h4>.status.vpc.securityGroups</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of security groups defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.transitGateways</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of transit gateways defined in this VPC
</details>
<details>
<summary>
  <h4>.status.vpc.vpcPeeringConnections</h4>
</summary>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of VPC peering connections defined in this VPC
</details>





