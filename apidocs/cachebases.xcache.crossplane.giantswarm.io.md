---
title: CacheBase CRD schema reference (group xcache.crossplane.giantswarm.io)
linkTitle: CacheBase
description: |
  Custom resource definition (CRD) schema reference page for the CacheBase resource (cachebases.xcache.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: CacheBaseClaim
  claim_name_plural: cachebaseclaims
  default_composition_ref: cache-base
  enforced_composition_ref: cache-base
  name_camelcase: CacheBase
  name_plural: cachebases
  name_singular: cachebase
  short_names:
    - ec
  group: xcache.crossplane.giantswarm.io
  technical_name: cachebases.xcache.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - cache
    - crossplane
    - elasticache
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/cachebases.xcache.crossplane.giantswarm.io/
technical_name: cachebases.xcache.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# CacheBase

<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">cachebases.xcache.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">CacheBaseClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">cachebaseclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">cache-base</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">cache-base</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xcache.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">cachebase</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">
  <ul>
  
  <li>ec</li>
  
</dd>

<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">cachebases</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



## Version `v1alpha1`


### Spec Properties
<h4>.spec.applyImmediately</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.
<h4>.spec.atRestEncryptionEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AtRestEncryptionEnabled specifies whether data stored in the cluster is
  encrypted at rest.
<h4>.spec.authTokenUpdateStrategy</h4>

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
<h4>.spec.autoMinorVersionUpgrade</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.
<h4>.spec.automaticFailoverEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
  
  
  If enabled, NumCacheNodes must be greater than 1. Must be enabled for
  Redis (cluster mode enabled) replication groups.
<h4>.spec.availabilityZones</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


AvailabilityZones is a list of Availability Zones in which the
  cluster's nodes will be created.
<h4>.spec.availabilityZones[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.cacheClusters</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheClusters is a list of cache clusters in the replication group.
  
  
  This value is overridden by NumCacheClusters.
  
  
  May be used to specify cluster specific configuration.
<h4>.spec.cacheClusters[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>.spec.cacheClusters[*].applyImmediately</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.
<h4>.spec.cacheClusters[*].autoMinorVersionUpgrade</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.
<h4>.spec.cacheClusters[*].availabilityZone</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the name of the Availability Zone in which the
  cluster will be created.
  
  
  If you want to create cache nodes in multi-az, use
  preferred_availability_zones instead.
  Default: System chosen Availability Zone.
<h4>.spec.cacheClusters[*].azMode</h4>

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
<h4>.spec.cacheClusters[*].engine</h4>

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
<h4>.spec.cacheClusters[*].engineVersion</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.
<h4>.spec.cacheClusters[*].finalSnapshotIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.
<h4>.spec.cacheClusters[*].ipDiscovery</h4>

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
<h4>.spec.cacheClusters[*].logDeliveryConfigurations</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.
<h4>.spec.cacheClusters[*].logDeliveryConfigurations[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>.spec.cacheClusters[*].logDeliveryConfigurations[*].destination</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.
<h4>.spec.cacheClusters[*].logDeliveryConfigurations[*].destinationType</h4>

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
<h4>.spec.cacheClusters[*].logDeliveryConfigurations[*].logFormat</h4>

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
<h4>.spec.cacheClusters[*].logDeliveryConfigurations[*].logType</h4>

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
<h4>.spec.cacheClusters[*].maintenanceWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.
<h4>.spec.cacheClusters[*].networkType</h4>

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
<h4>.spec.cacheClusters[*].nodeType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless replication group is specified.
<h4>.spec.cacheClusters[*].notificationTopicArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.
<h4>.spec.cacheClusters[*].numCacheNodes</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Required unless replication group is specified.
<h4>.spec.cacheClusters[*].outpostMode</h4>

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
<h4>.spec.cacheClusters[*].parameterGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster.
  
  
  Required unless replication group is specified.
<h4>.spec.cacheClusters[*].port</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
<h4>.spec.cacheClusters[*].preferredAvailabilityZones</h4>

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
<h4>.spec.cacheClusters[*].preferredAvailabilityZones[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.cacheClusters[*].preferredOutpostArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
  which the cache cluster will be created.
<h4>.spec.cacheClusters[*].securityGroupIds</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.
<h4>.spec.cacheClusters[*].securityGroupIds[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.cacheClusters[*].snapshotArns</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only
<h4>.spec.cacheClusters[*].snapshotArns[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.cacheClusters[*].snapshotName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only
<h4>.spec.cacheClusters[*].snapshotRetentionLimit</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only
<h4>.spec.cacheClusters[*].snapshotWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only
<h4>.spec.cacheClusters[*].subnetGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SubnetGroupName is the name of the subnet group to associate with this
  cluster.
  
  
  Required unless replication group is specified in which case it will be
  ignored.
<h4>.spec.cacheClusters[*].tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.
<h4>.spec.cacheClusters[*].transitEncryptionEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only
<h4>.spec.cidrBlocks</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CidrBlocks is a list of CIDR blocks that are allowed to access the
  cluster.
<h4>.spec.cidrBlocks[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.clusterModeEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ClusterModeEnabled specifies whether cluster mode is enabled for the
  replication group.
<h4>.spec.createReplicationGroup</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateReplicationGroup specifies whether a replication group should be
  created.
  
  
  If set false, the replication group configuration will be used for
  creating a single cluster
<h4>.spec.dataTieringEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DataTieringEnabled specifies whether data tiering is enabled for the
  replication group.
  
  
  Must be true if the replcation group is using r6gd nodes
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
<h4>.spec.engine</h4>

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
<h4>.spec.engineVersion</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.
<h4>.spec.finalSnapshotIdentifier</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.
<h4>.spec.globalReplicationGroup</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


GlobalReplicationGroup is the global replication group configuration.
<h4>.spec.globalReplicationGroup.automaticFailoverEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
<h4>.spec.globalReplicationGroup.cacheNodeType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheNodeType is the instance class to use for the cache nodes.
<h4>.spec.globalReplicationGroup.enabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is a flag that enables the global replication group.
<h4>.spec.globalReplicationGroup.engineVersion</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
<h4>.spec.globalReplicationGroup.numNodeGroups</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
<h4>.spec.globalReplicationGroup.parameterGroupName</h4>

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
<h4>.spec.globalReplicationGroup.suffix</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupIdSuffix is the suffix to append to the global
  replication group id.
<h4>.spec.globalReplicationGroupId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupId is the id of the global replication group to
  which this replication group should belong.
  
  
  If this value is specified, the number of node groups parameter must not
  be specified.
<h4>.spec.ipDiscovery</h4>

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
<h4>.spec.kmsKeyId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
  encrypt the data in the cluster.
  
  
  Ignored unless AtRestEncryptionEnabled is set to true.
<h4>.spec.logDeliveryConfigurations</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.
<h4>.spec.logDeliveryConfigurations[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>.spec.logDeliveryConfigurations[*].destination</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.
<h4>.spec.logDeliveryConfigurations[*].destinationType</h4>

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
<h4>.spec.logDeliveryConfigurations[*].logFormat</h4>

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
<h4>.spec.logDeliveryConfigurations[*].logType</h4>

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
<h4>.spec.maintenanceWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.
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
<h4>.spec.multiAzEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAzEnabled specifies whether the cluster should be created in
  multiple Availability Zones.
  
  
  If true, AutomaticFailoverEnabled must also be true.
<h4>.spec.networkType</h4>

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
<h4>.spec.nodeType</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless global replication group is specified.
<h4>.spec.notificationTopicArn</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.
<h4>.spec.numCacheClusters</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheClusters is the number of cache clusters in the replication group.
  
  
  If MultiAzEnabled is true, this value must be at least 2 but generally
  should be equal to the number of Availability Zones.
  
  
  Conflicts with NumNodeGroups.
<h4>.spec.numCacheNodes</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Ignored if replication group is specified or being created
  This is a convenience parameter when building a single cluster.
<h4>.spec.numNodeGroups</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
  
  
  If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
  is true, this value must not be specified.
  
  
  Conflicts with NumCacheClusters.
<h4>.spec.parameterGroupConfiguration</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ParameterGroupConfiguration defines the configuration for the parameter
  group.
<h4>.spec.parameterGroupConfiguration.description</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is a description of the parameter group.
<h4>.spec.parameterGroupConfiguration.family</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Family is the name of the parameter group family that this parameter
  group is compatible with.
<h4>.spec.parameterGroupConfiguration.name</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the parameter group.
<h4>.spec.parameterGroupConfiguration.parameters</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Parameters is a list of parameters in the parameter group.
<h4>.spec.parameterGroupConfiguration.tags</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the parameter group.
<h4>.spec.parameterGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster. To create a new parameter group, use the
  `ParameterGroupConfiguration` option instead.
<h4>.spec.port</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
<h4>.spec.preferredCacheClusterAzs</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


PreferredCacheClusterAzs is a list ec2 availability zones in which the
  cache clusters will be created.
<h4>.spec.preferredCacheClusterAzs[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


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


Region is the region in which the cluster will be created.
<h4>.spec.replicasPerNodeGroup</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ReplicasPerNodeGroup is the number of read replicas per node group.
<h4>.spec.securityGroupIds</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.
<h4>.spec.securityGroupIds[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.snapshotArns</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only
<h4>.spec.snapshotArns[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.snapshotName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only
<h4>.spec.snapshotRetentionLimit</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only
<h4>.spec.snapshotWindow</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only
<h4>.spec.subnetIds</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SubnetIds is a list of subnet IDs in which the cluster's nodes will be
  created.
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


Tags is a list of key-value pairs to associate with the cluster.
<h4>.spec.transitEncryptionEnabled</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only
<h4>.spec.usernames</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Usernames is a list of users to associate with the cluster.
<h4>.spec.usernames[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.spec.vpcId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


VpcId is the ID of the VPC in which the cluster will be created.
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
<h4>.status.clusterEndpoints</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterEndpoints is a list of endpoints for the clusters.
<h4>.status.clusterEndpoints[*]</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>.status.clusterName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ClusterName is the name of the cluster.
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


ConnectionSecret is the name of the connection secret.
<h4>.status.endpoint</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Endpoint is the DNS name of the endpoint for the cluster.
<h4>.status.globalConnectionSecret</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalConnectionSecret is the name of the global connection secret.
<h4>.status.globalEndpoint</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalEndpoint is the DNS name of the endpoint for the cluster at global
  scope
<h4>.status.globalReaderEndpoint</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReaderEndpoint is the DNS name of the reader endpoint for the
  cluster at global scope
<h4>.status.globalReplicationGroupId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupId is the ID of the global replication group.
<h4>.status.kmsKeyId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


kmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
  encrypt the data in the cluster.
<h4>.status.parameterGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group associated with the
  cluster.
<h4>.status.port</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
<h4>.status.readerEndpoint</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ReaderEndpoint is the DNS name of the reader endpoint for the cluster.
<h4>.status.replicationGroupId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ReplicationGroupId is the ID of the replication group.
<h4>.status.securityGroupId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SecurityGroupId is the ID of the security group for the cluster.
<h4>.status.subnetGroupName</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SubnetGroupName is the name of the subnet group for the cluster.
<h4>.status.userGroupId</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


UserGroupId is the ID of the user group for the cluster.





