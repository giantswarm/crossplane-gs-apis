---
title: RCCWithRegionLookup CRD schema reference (group xaws.crossplane.giantswarm.io)
linkTitle: RCCWithRegionLookup
description: |
  Custom resource definition (CRD) schema reference page for the RCCWithRegionLookup resource (rccwithregionlookups.xaws.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: RCCWithRegionLookupClaim
  claim_name_plural: rccwithregionlookupclaims
  default_composition_ref: rcc-with-region-lookup
  enforced_composition_ref: rcc-with-region-lookup
  name_camelcase: RCCWithRegionLookup
  name_plural: rccwithregionlookups
  name_singular: rccwithregionlookup
  short_names:
    - rccwrl
  group: xaws.crossplane.giantswarm.io
  technical_name: rccwithregionlookups.xaws.crossplane.giantswarm.io
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
  - /reference/cp-k8s-api/rccwithregionlookups.xaws.crossplane.giantswarm.io/
technical_name: rccwithregionlookups.xaws.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# RCCWithRegionLookup

<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">rccwithregionlookups.xaws.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">RCCWithRegionLookupClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">rccwithregionlookupclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">rcc-with-region-lookup</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">rcc-with-region-lookup</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xaws.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">rccwithregionlookup</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">
  <ul>
  
  <li>rccwrl</li>
  
</dd>

<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">rccwithregionlookups</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



## Version `v1alpha1`


### Spec Properties

#### `.spec.clusterDiscovery`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


ClusterDiscovery is the reference to the cluster to discover

#### `.spec.clusterDiscovery.deletionPolicy`

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

#### `.spec.clusterDiscovery.managementPolicies`

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

#### `.spec.clusterDiscovery.managementPolicies[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.

#### `.spec.clusterDiscovery.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the cluster to discover

#### `.spec.clusterDiscovery.namespace`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace is the namespace of the cluster to discover

#### `.spec.clusterDiscovery.providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.

#### `.spec.clusterDiscovery.providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.

#### `.spec.clusterDiscovery.providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.

#### `.spec.clusterDiscovery.providerConfigRef.policy.resolution`

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

#### `.spec.clusterDiscovery.providerConfigRef.policy.resolve`

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

#### `.spec.clusterDiscovery.publishConnectionDetailsTo`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.configRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.policy.resolution`

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

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.policy.resolve`

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

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.metadata`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.metadata.annotations`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.metadata.labels`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.metadata.type`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.

#### `.spec.clusterDiscovery.publishConnectionDetailsTo.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.

#### `.spec.clusterDiscovery.writeConnectionSecretToRef`

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

#### `.spec.clusterDiscovery.writeConnectionSecretToRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.

#### `.spec.clusterDiscovery.writeConnectionSecretToRef.namespace`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace of the secret.

#### `.spec.rdsCacheClusterSpec`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


RdsCacheClusterSpec is the spec for the RDS Cache Cluster

#### `.spec.rdsCacheClusterSpec.availabilityZones`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|3|
|Max Items|3|


AvailabilityZones is the list of availability zones to be used by the cluster

#### `.spec.rdsCacheClusterSpec.availabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Cache defines the cache settings

#### `.spec.rdsCacheClusterSpec.cache.applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.

#### `.spec.rdsCacheClusterSpec.cache.atRestEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AtRestEncryptionEnabled specifies whether data stored in the cluster is
  encrypted at rest.

#### `.spec.rdsCacheClusterSpec.cache.authTokenUpdateStrategy`

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

#### `.spec.rdsCacheClusterSpec.cache.autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.

#### `.spec.rdsCacheClusterSpec.cache.automaticFailoverEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
  
  
  If enabled, NumCacheNodes must be greater than 1. Must be enabled for
  Redis (cluster mode enabled) replication groups.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheClusters is a list of cache clusters in the replication group.
  
  
  This value is overridden by NumCacheClusters.
  
  
  May be used to specify cluster specific configuration.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].availabilityZone`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the name of the Availability Zone in which the
  cluster will be created.
  
  
  If you want to create cache nodes in multi-az, use
  preferred_availability_zones instead.
  Default: System chosen Availability Zone.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].azMode`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].engine`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].ipDiscovery`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].destination`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].destinationType`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].logFormat`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].logType`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].maintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].networkType`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].nodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless replication group is specified.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].notificationTopicArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].numCacheNodes`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Required unless replication group is specified.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].outpostMode`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster.
  
  
  Required unless replication group is specified.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].preferredAvailabilityZones`

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

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].preferredAvailabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].preferredOutpostArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
  which the cache cluster will be created.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].securityGroupIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].securityGroupIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotRetentionLimit`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].subnetGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SubnetGroupName is the name of the subnet group to associate with this
  cluster.
  
  
  Required unless replication group is specified in which case it will be
  ignored.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.

#### `.spec.rdsCacheClusterSpec.cache.cacheClusters[*].transitEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only

#### `.spec.rdsCacheClusterSpec.cache.clusterModeEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ClusterModeEnabled specifies whether cluster mode is enabled for the
  replication group.

#### `.spec.rdsCacheClusterSpec.cache.createReplicationGroup`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateReplicationGroup specifies whether a replication group should be
  created.
  
  
  If set false, the replication group configuration will be used for
  creating a single cluster

#### `.spec.rdsCacheClusterSpec.cache.dataTieringEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DataTieringEnabled specifies whether data tiering is enabled for the
  replication group.
  
  
  Must be true if the replcation group is using r6gd nodes

#### `.spec.rdsCacheClusterSpec.cache.engine`

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

#### `.spec.rdsCacheClusterSpec.cache.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.

#### `.spec.rdsCacheClusterSpec.cache.finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


GlobalReplicationGroup is the global replication group configuration.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.automaticFailoverEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.cacheNodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheNodeType is the instance class to use for the cache nodes.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is a flag that enables the global replication group.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.numNodeGroups`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.parameterGroupName`

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

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.suffix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupIdSuffix is the suffix to append to the global
  replication group id.

#### `.spec.rdsCacheClusterSpec.cache.globalReplicationGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupId is the id of the global replication group to
  which this replication group should belong.
  
  
  If this value is specified, the number of node groups parameter must not
  be specified.

#### `.spec.rdsCacheClusterSpec.cache.ipDiscovery`

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

#### `.spec.rdsCacheClusterSpec.cache.kmsKeyId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
  encrypt the data in the cluster.
  
  
  Ignored unless AtRestEncryptionEnabled is set to true.

#### `.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.

#### `.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].destination`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.

#### `.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].destinationType`

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

#### `.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].logFormat`

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

#### `.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].logType`

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

#### `.spec.rdsCacheClusterSpec.cache.maintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.

#### `.spec.rdsCacheClusterSpec.cache.multiAzEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAzEnabled specifies whether the cluster should be created in
  multiple Availability Zones.
  
  
  If true, AutomaticFailoverEnabled must also be true.

#### `.spec.rdsCacheClusterSpec.cache.networkType`

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

#### `.spec.rdsCacheClusterSpec.cache.nodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless global replication group is specified.

#### `.spec.rdsCacheClusterSpec.cache.notificationTopicArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.

#### `.spec.rdsCacheClusterSpec.cache.numCacheClusters`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheClusters is the number of cache clusters in the replication group.
  
  
  If MultiAzEnabled is true, this value must be at least 2 but generally
  should be equal to the number of Availability Zones.
  
  
  Conflicts with NumNodeGroups.

#### `.spec.rdsCacheClusterSpec.cache.numCacheNodes`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Ignored if replication group is specified or being created
  This is a convenience parameter when building a single cluster.

#### `.spec.rdsCacheClusterSpec.cache.numNodeGroups`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
  
  
  If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
  is true, this value must not be specified.
  
  
  Conflicts with NumCacheClusters.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ParameterGroupConfiguration defines the configuration for the parameter
  group.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is a description of the parameter group.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Family is the name of the parameter group family that this parameter
  group is compatible with.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the parameter group.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Parameters is a list of parameters in the parameter group.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the parameter group.

#### `.spec.rdsCacheClusterSpec.cache.parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster. To create a new parameter group, use the
  `ParameterGroupConfiguration` option instead.

#### `.spec.rdsCacheClusterSpec.cache.port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.

#### `.spec.rdsCacheClusterSpec.cache.preferredCacheClusterAzs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


PreferredCacheClusterAzs is a list ec2 availability zones in which the
  cache clusters will be created.

#### `.spec.rdsCacheClusterSpec.cache.preferredCacheClusterAzs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.replicasPerNodeGroup`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ReplicasPerNodeGroup is the number of read replicas per node group.

#### `.spec.rdsCacheClusterSpec.cache.securityGroupIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.

#### `.spec.rdsCacheClusterSpec.cache.securityGroupIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.snapshotArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.snapshotArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.cache.snapshotName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.snapshotRetentionLimit`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.snapshotWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only

#### `.spec.rdsCacheClusterSpec.cache.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.

#### `.spec.rdsCacheClusterSpec.cache.transitEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only

#### `.spec.rdsCacheClusterSpec.cache.usernames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Usernames is a list of users to associate with the cluster.

#### `.spec.rdsCacheClusterSpec.cache.usernames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Database defines the database settings

#### `.spec.rdsCacheClusterSpec.database.activityStream`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ActivityStream is the activity stream configuration.

#### `.spec.rdsCacheClusterSpec.database.activityStream.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether activity stream is enabled.

#### `.spec.rdsCacheClusterSpec.database.activityStream.engineNativeAuditFieldsIncluded`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EngineNativeAuditFieldsIncluded is whether engine native audit fields are
  included. This option only applies to Oracle databases.

#### `.spec.rdsCacheClusterSpec.database.activityStream.mode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- sync
- async

Mode is the mode of the activity stream. Valid values are `sync` and `async`.

#### `.spec.rdsCacheClusterSpec.database.allocatedStorage`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.

#### `.spec.rdsCacheClusterSpec.database.allowMajorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.

#### `.spec.rdsCacheClusterSpec.database.applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.

#### `.spec.rdsCacheClusterSpec.database.autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically. This value can be overridden on a per instance basis.

#### `.spec.rdsCacheClusterSpec.database.autoscaling`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Autoscaling is the autoscaling configuration.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Autoscaling is whether autoscaling is enabled.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for autoscaling.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.metricType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- RDSReaderAverageCPUUtilization
- RDSReaderAverageDatabaseConnections

MetricType is the type of metric to use for autoscaling.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for autoscaling.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.policyName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PolicyName is the name of the autoscaling policy.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.scaleInCooldown`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleInCooldown is the amount of time, in seconds, after a scaling in
  activity completes before another scaling activity can start.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.scaleOutCooldown`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleOutCooldown is the amount of time, in seconds, after a scaling out
  activity completes before another scaling activity can start.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.targetCPU`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetCPU is CPU threshold which will initiate autoscaling.

#### `.spec.rdsCacheClusterSpec.database.autoscaling.targetConnections`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetConnections is the average number of connections threshold which
  will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
  default max_connections

#### `.spec.rdsCacheClusterSpec.database.backtrackWindow`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BacktrackWindow is the target backtrack window, in seconds.
  Only available for Aurora engine. To disable backtracking, set this value to 0.

#### `.spec.rdsCacheClusterSpec.database.backupRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.

#### `.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


CloudwatchLogGroup defines the parameters for the log groups

#### `.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.class`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Class is the class of the log group.

#### `.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the log group is to be created.

#### `.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.retentionInDays`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RetentionInDays is the number of days to retain logs for.

#### `.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.skipDestroy`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipDestroy is whether the log group should be skipped during destroy.

#### `.spec.rdsCacheClusterSpec.database.copyTagsToSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.

#### `.spec.rdsCacheClusterSpec.database.createCluster`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateCluster is whether the cluster should be created.
  By default this is true but for non-aurora clusters, the DB Cluster
  resource is optional and can be omitted. In this case, the DB instances
  will be created as `instance.rds` types.

#### `.spec.rdsCacheClusterSpec.database.databaseName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.

#### `.spec.rdsCacheClusterSpec.database.databases`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Databases is a map of databases to create.

#### `.spec.rdsCacheClusterSpec.database.dbClusterInstanceClass`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbClusterInstanceClass is the instance class to use.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbClusterParameterGroup defines the parameters for the DB cluster.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.applyMethod`

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

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is to be created.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.parameters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbParameterGroup defines the parameters for the DB instance.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.create`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is created.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.parameters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.

#### `.spec.rdsCacheClusterSpec.database.dbParameterGroup.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.

#### `.spec.rdsCacheClusterSpec.database.deleteAutomatedBackups`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.

#### `.spec.rdsCacheClusterSpec.database.deletionProtection`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.

#### `.spec.rdsCacheClusterSpec.database.domain`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Domain is the domain to use.

#### `.spec.rdsCacheClusterSpec.database.domainIAMRoleName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIAMRoleName is the name of the IAM role to use.

#### `.spec.rdsCacheClusterSpec.database.enableGlobalWriteForwarding`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableGlobalWriteForwarding is whether global write forwarding is enabled.

#### `.spec.rdsCacheClusterSpec.database.enableHttpEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableHttpEndpoint is whether the HTTP endpoint is enabled.

#### `.spec.rdsCacheClusterSpec.database.enableLocalWriteForwarding`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableLocalWriteForwarding is whether local write forwarding is enabled.

#### `.spec.rdsCacheClusterSpec.database.enabledCloudwatchLogsExports`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.

#### `.spec.rdsCacheClusterSpec.database.enabledCloudwatchLogsExports[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.

#### `.spec.rdsCacheClusterSpec.database.endpoints`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Endpoints is a list of custom endpoints to create.

#### `.spec.rdsCacheClusterSpec.database.endpoints[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database.endpoints[*].customEndpointType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- READER
- ANY

CustomEndpointType is the type of the custom endpoint.

#### `.spec.rdsCacheClusterSpec.database.endpoints[*].excludedMembers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludedMembers is a list of DB instances that aren't part of the custom
  endpoint group.

#### `.spec.rdsCacheClusterSpec.database.endpoints[*].excludedMembers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database.endpoints[*].staticMembers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


StaticMembers is a list of DB instances that are part of the custom
  endpoint group.

#### `.spec.rdsCacheClusterSpec.database.endpoints[*].staticMembers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database.endpoints[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the custom endpoint.

#### `.spec.rdsCacheClusterSpec.database.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Engine is the database engine to use.

#### `.spec.rdsCacheClusterSpec.database.engineMode`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- parallelquery
- provisioned
- serverless

EngineMode is the database engine mode to use.

#### `.spec.rdsCacheClusterSpec.database.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version of the database engine to use.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


EnhancedMonitoring is the enhanced monitoring configuration.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the monitoring role.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether enhanced monitoring is enabled.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.forceDetachPolicies`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.managedPolicyArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.managedPolicyArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.maxSessionDuration`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.monitoringInterval`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.path`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Path is the path of the monitoring role.

#### `.spec.rdsCacheClusterSpec.database.enhancedMonitoring.permissionsBoundary`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.

#### `.spec.rdsCacheClusterSpec.database.eso`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Eso is the ESO configuration.
  
  
  This field is used to sync secrets using `external-secrets-operator`.
  External Secrets Operator must be installed if this value is set to true

#### `.spec.rdsCacheClusterSpec.database.eso.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled Whether or not to enable `external-secrets-operator` object
  deployments using `provider-kubernetes.

#### `.spec.rdsCacheClusterSpec.database.eso.kubernetesSecretStore`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KubernetesSecretStore is the Kubernetes secret store to use.
  
  
  The kubernetes secret store is expected to be namespace scoped to prevent
  secrets leaking across namespaces.

#### `.spec.rdsCacheClusterSpec.database.eso.stores`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Stores is a list of secret stores to use for push secrets.

#### `.spec.rdsCacheClusterSpec.database.eso.stores[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretsStore is a reference to a secrets store to be passed to External
  Secrets Operator for creating PushSecrets

#### `.spec.rdsCacheClusterSpec.database.eso.stores[*].enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether the secrets store is enabled.

#### `.spec.rdsCacheClusterSpec.database.eso.stores[*].isClusterSecretStore`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IsClusterSecretStore is whether the secret store is a cluster secret store.

#### `.spec.rdsCacheClusterSpec.database.eso.stores[*].secretStore`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


SecretStoreName is the name of the secret store.

#### `.spec.rdsCacheClusterSpec.database.globalClusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.

#### `.spec.rdsCacheClusterSpec.database.iamDatabaseAuthenticationEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.

#### `.spec.rdsCacheClusterSpec.database.iamRoles`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


IamRoles is a list of IAM roles to associate with the DB cluster.

#### `.spec.rdsCacheClusterSpec.database.iamRoles[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database.iamRoles[*].featureName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FeatureName is the name of the feature.

#### `.spec.rdsCacheClusterSpec.database.iamRoles[*].roleArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RoleArn is the ARN of the role.

#### `.spec.rdsCacheClusterSpec.database.instanceCount`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


InstanceCount is the number of instances to create.
  
  
  If set, this value will create the requested number of instances using
  defaults from the cluster configuration. If `instances` are specified,
  this value is ignored.

#### `.spec.rdsCacheClusterSpec.database.instances`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Instances is a list of instances to create.

#### `.spec.rdsCacheClusterSpec.database.instances[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.database.instances[*].allocatedStorage`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllocatedStorage`

#### `.spec.rdsCacheClusterSpec.database.instances[*].allowMajorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllowMajorVersionUpgrade`

#### `.spec.rdsCacheClusterSpec.database.instances[*].applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
  
  
  Overrides `ClusterParameters.ApplyImmediately`

#### `.spec.rdsCacheClusterSpec.database.instances[*].autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically.
  
  
  Overrides `ClusterParameters.AutoMinorVersionUpgrade`

#### `.spec.rdsCacheClusterSpec.database.instances[*].availabilityZone`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the availability zone for this instance.
  Ignored if `multiAz` is true

#### `.spec.rdsCacheClusterSpec.database.instances[*].backupRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].copyTagsToSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.

#### `.spec.rdsCacheClusterSpec.database.instances[*].databaseName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.

#### `.spec.rdsCacheClusterSpec.database.instances[*].deleteAutomatedBackups`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].deletionProtection`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].domainIamRoleName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIamRoleName is the name of the IAM role to use.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].enabledCloudwatchLogsExports`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].enabledCloudwatchLogsExports[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.

#### `.spec.rdsCacheClusterSpec.database.instances[*].finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the identifier of the final snapshot.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].iamDatabaseAuthenticationEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IamDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].instanceClass`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


InstanceClass is the instance class to use.

#### `.spec.rdsCacheClusterSpec.database.instances[*].iops`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].licenseModel`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LicenseModel is the license model to use.
  
  
  Only applicable if not running in cluster mode.

#### `.spec.rdsCacheClusterSpec.database.instances[*].monitoringInterval`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when
  Enhanced Monitoring metrics are collected for the DB instance.

#### `.spec.rdsCacheClusterSpec.database.instances[*].multiAz`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NetworkType is the network type to use.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].optionGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


OptionGroupName is the name of the option group to associate with this DB
  instance.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the DB parameter group to associate
  with this DB instance. Must pre-exist in the account. Mutually exclusive
  with `RdsBaseDbCluster.dbParameterGroup`

#### `.spec.rdsCacheClusterSpec.database.instances[*].performanceInsightsEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.

#### `.spec.rdsCacheClusterSpec.database.instances[*].performanceInsightsKmsKeyID`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption
  of Performance Insights data.

#### `.spec.rdsCacheClusterSpec.database.instances[*].performanceInsightsRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to
  retain Performance Insights data.

#### `.spec.rdsCacheClusterSpec.database.instances[*].preferredMaintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.

#### `.spec.rdsCacheClusterSpec.database.instances[*].promotionTier`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PromotionTier is the order in which to promote an Aurora replica to the
  primary instance.

#### `.spec.rdsCacheClusterSpec.database.instances[*].publiclyAccessible`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.

#### `.spec.rdsCacheClusterSpec.database.instances[*].skipFinalSnapshot`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipFinalSnapshot is whether to skip the final snapshot.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].storageEncrypted`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


StorageEncrypted is whether storage is encrypted.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].storageThroughput`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


StorageThroughput is the amount of storage throughput. Only applicable if
  `storageType` is `gp3`
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].storageType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType is the storage type to use.
  
  
  Only applicable if not running in cluster mode

#### `.spec.rdsCacheClusterSpec.database.instances[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB instance.

#### `.spec.rdsCacheClusterSpec.database.iops`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.

#### `.spec.rdsCacheClusterSpec.database.masterUsername`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MasterUsername is the master username to use.

#### `.spec.rdsCacheClusterSpec.database.multiAz`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.

#### `.spec.rdsCacheClusterSpec.database.partition`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- aws
- aws-cn
- aws-us-gov

Partition is the AWS partition to use.

#### `.spec.rdsCacheClusterSpec.database.performanceInsightsEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.

#### `.spec.rdsCacheClusterSpec.database.performanceInsightsKmsKeyID`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.

#### `.spec.rdsCacheClusterSpec.database.performanceInsightsRetentionPeriod`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.

#### `.spec.rdsCacheClusterSpec.database.preferredBackupWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredBackupWindow is the preferred backup window.

#### `.spec.rdsCacheClusterSpec.database.preferredMaintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.

#### `.spec.rdsCacheClusterSpec.database.provisionSql`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ProvisionSql determines whether or not to provision databases inside the
  RDS cluster.

#### `.spec.rdsCacheClusterSpec.database.publiclyAccessible`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.

#### `.spec.rdsCacheClusterSpec.database.replicationSourceIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
  this DB cluster is to be created as a Read Replica

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


RestoreToPointInTime is the point in time to restore to.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.identifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Identifier is the identifier of the source DB cluster snapshot or DB
  instance snapshot to restore from. Only valid if not running in cluster
  mode.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.restoreToTime`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RestoreToTime is the time to restore to.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.restoreType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- full-copy
- copy-on-write

RestoreType is the type of restore to perform. This option is ignored if
  not running in cluster mode.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbClusterIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbClusterIdentifier is the identifier of the source DB cluster.
  This option is ignored if not running in cluster mode.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


sourceDbInstanceAutomatedBackupsArn is the ARN of the source DB instance
  automated backup to restore from. Only valid if not running in cluster mode.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbInstanceIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbInstanceIdentifier is the identifier of the source DB instance.
  Only valid if not running in cluster mode. If running in cluster mode, use
  `SourceDbClusterIdentifier` instead.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbiResourceId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbiResourceId is the resource ID of the source DB instance. Only
  valid if not running in cluster mode.

#### `.spec.rdsCacheClusterSpec.database.restoreToPointInTime.useLatestRestorableTime`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


UseLatestRestorableTime is whether to use the latest restorable time.

#### `.spec.rdsCacheClusterSpec.database.s3Import`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


S3Import is the S3 import configuration.

#### `.spec.rdsCacheClusterSpec.database.s3Import.bucketName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketName is the name of the S3 bucket.

#### `.spec.rdsCacheClusterSpec.database.s3Import.bucketPrefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
  within the bucket where the data is located.

#### `.spec.rdsCacheClusterSpec.database.s3Import.ingestionRole`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


IngestionRole is the role to use for ingestion.

#### `.spec.rdsCacheClusterSpec.database.s3Import.sourceEngine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngine is the source engine to use.

#### `.spec.rdsCacheClusterSpec.database.s3Import.sourceEngineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngineVersion is the source engine version to use.

#### `.spec.rdsCacheClusterSpec.database.scalingConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ScalingConfiguration is the scaling configuration.

#### `.spec.rdsCacheClusterSpec.database.scalingConfiguration.autoPause`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoPause is whether the database should automatically pause.

#### `.spec.rdsCacheClusterSpec.database.scalingConfiguration.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.

#### `.spec.rdsCacheClusterSpec.database.scalingConfiguration.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.

#### `.spec.rdsCacheClusterSpec.database.scalingConfiguration.secondsUntilAutoPause`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SecondsUntilAutoPause is the number of seconds until the database
  automatically pauses.

#### `.spec.rdsCacheClusterSpec.database.secretRotation`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretRotation is the secret rotation configuration.

#### `.spec.rdsCacheClusterSpec.database.secretRotation.automaticallyAfterDays`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AutomaticallyAfterDays is the number of days after which the secret is
  rotated automatically.

#### `.spec.rdsCacheClusterSpec.database.secretRotation.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether secret rotation is enabled.

#### `.spec.rdsCacheClusterSpec.database.secretRotation.rotateImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


RotateImmediately is whether the secret should be rotated immediately.

#### `.spec.rdsCacheClusterSpec.database.secretRotation.scheduleExpression`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ScheduleExpression is the schedule expression for secret rotation.

#### `.spec.rdsCacheClusterSpec.database.serverlessV2ScalingConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.

#### `.spec.rdsCacheClusterSpec.database.serverlessV2ScalingConfiguration.maxCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.

#### `.spec.rdsCacheClusterSpec.database.serverlessV2ScalingConfiguration.minCapacity`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.

#### `.spec.rdsCacheClusterSpec.database.storageType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType specifies the storage type to be associated with the cluster

#### `.spec.rdsCacheClusterSpec.database.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB cluster.

#### `.spec.rdsCacheClusterSpec.deletionPolicy`

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

#### `.spec.rdsCacheClusterSpec.kubernetesProviderConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


KubernetesProviderConfig

#### `.spec.rdsCacheClusterSpec.kubernetesProviderConfig.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|



#### `.spec.rdsCacheClusterSpec.managementPolicies`

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

#### `.spec.rdsCacheClusterSpec.managementPolicies[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.

#### `.spec.rdsCacheClusterSpec.providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.

#### `.spec.rdsCacheClusterSpec.providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.

#### `.spec.rdsCacheClusterSpec.providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.

#### `.spec.rdsCacheClusterSpec.providerConfigRef.policy.resolution`

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

#### `.spec.rdsCacheClusterSpec.providerConfigRef.policy.resolve`

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

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.policy.resolution`

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

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.policy.resolve`

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

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata.annotations`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata.labels`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata.type`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.

#### `.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.

#### `.spec.rdsCacheClusterSpec.region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Region is the region in which this collection will be created

#### `.spec.rdsCacheClusterSpec.subnetGroupIndexes`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SubnetGroupIndexes is a map of service name to subnet set indexes

#### `.spec.rdsCacheClusterSpec.subnetGroupIndexes.cache`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Cache is the subnet group index to use for the cache

#### `.spec.rdsCacheClusterSpec.subnetGroupIndexes.database`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Database is the subnet group index to use for the database

#### `.spec.rdsCacheClusterSpec.vpc`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Vpc defines the VPC settings

#### `.spec.rdsCacheClusterSpec.vpc.peering`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Peering is the VPC to peer with.

#### `.spec.rdsCacheClusterSpec.vpc.peering.allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowPublic specifies if the VPC peering connections should be allowed to
  be linked to the public subnets
  Defaults to false

#### `.spec.rdsCacheClusterSpec.vpc.peering.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled specifies if the VPC peering connections should be enabled for
  this VPC.
  Defaults to false

#### `.spec.rdsCacheClusterSpec.vpc.peering.groupBy`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GroupBy specifies the key to group the remote subnets by

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|125|


RemoteVpcs is a list of VPCs to peer with.

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


VpcPeer defines the parameters for peering with a VPC.

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Disabled specifies if the peering connection should be disabled.
  Defaults to true

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ExcludeFromLocalPeering specifies the indexes of subnetsets for this VPC to
  exclude from routing to the peering connection

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.private`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.private[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.public`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.public[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludeFromRemotePeering specifies the indexes of subnetsets for the remote
  VPC to exclude from routing to the peering connection. If emmpty, all
  subnetsets will be included by default

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].private`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].private[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].public`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].public[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name specifies the name of the VPC to peer with.

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ProviderConfigRef specifies the provider config to use for the peering
  connection.

#### `.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Region specifies the region the VPC is found in.
  
  
  If not defined, the region of the VPC will be assumed to be the same as
  the region of the peered VPC.

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


PeeredSubnets defines how many public and private subnet sets to create.

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|1|
|Max Items|5|


Cidrs is a list of PeeredSubnetSets to create in the VPC

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PeeredSubnetSet defines the parameters for creating a set of subnets with the
  same mask.

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].prefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|


Prefix is the CIDR prefix to use for the subnet set

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Private is the number of private subnets to create in this set

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.clusterNames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterNames is a list of EKS cluster names to add shared LB tags for

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.clusterNames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.count`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Count is the number of subnet sets to create with this mask

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.lbSetIndex`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Determines which subnet set in this range to use for kubernetes load
  balancers. -1 means no load balancer tag is defined on this group

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.mask`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Mask is the CIDR mask to use for the subnet set

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Public is the number of public subnets to create in this set

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.clusterNames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterNames is a list of EKS cluster names to add shared LB tags for

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.clusterNames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.count`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Count is the number of subnet sets to create with this mask

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.lbSetIndex`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Determines which subnet set in this range to use for kubernetes load
  balancers. -1 means no load balancer tag is defined on this group

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.mask`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Mask is the CIDR mask to use for the subnet set

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by

#### `.spec.rdsCacheClusterSpec.vpc.subnetsets.function`

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

#### `.spec.rdsCacheClusterSpec.vpc.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a map of additional tags to assign to the VPC.

#### `.spec.rdsCacheClusterSpec.vpc.tags.cluster`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Cluster tags to apply subnets for autodiscovery of load balancers

#### `.spec.rdsCacheClusterSpec.vpc.tags.common`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


common tags apoplied to all resources

#### `.spec.rdsCacheClusterSpec.vpc.tags.subnet`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Subnet tags to apply to all subnetsets

#### `.spec.rdsCacheClusterSpec.writeConnectionSecretToRef`

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

#### `.spec.rdsCacheClusterSpec.writeConnectionSecretToRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.

#### `.spec.rdsCacheClusterSpec.writeConnectionSecretToRef.namespace`

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


CacheGlobalConnectionSecret is the name of the global connection secret for the
  Elasticache cluster

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
|Required |**Yes**|


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





