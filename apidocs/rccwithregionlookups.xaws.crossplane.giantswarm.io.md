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
<h4>`.spec.clusterDiscovery`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


ClusterDiscovery is the reference to the cluster to discover
<h4>`.spec.clusterDiscovery.deletionPolicy`</h4>

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
<h4>`.spec.clusterDiscovery.managementPolicies`</h4>

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
<h4>`.spec.clusterDiscovery.managementPolicies[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.
<h4>`.spec.clusterDiscovery.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the cluster to discover
<h4>`.spec.clusterDiscovery.namespace`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace is the namespace of the cluster to discover
<h4>`.spec.clusterDiscovery.providerConfigRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.
<h4>`.spec.clusterDiscovery.providerConfigRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>`.spec.clusterDiscovery.providerConfigRef.policy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>`.spec.clusterDiscovery.providerConfigRef.policy.resolution`</h4>

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
<h4>`.spec.clusterDiscovery.providerConfigRef.policy.resolve`</h4>

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
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.configRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.policy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.policy.resolution`</h4>

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
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.configRef.policy.resolve`</h4>

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
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.metadata`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.metadata.annotations`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.metadata.labels`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.metadata.type`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.
<h4>`.spec.clusterDiscovery.publishConnectionDetailsTo.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.
<h4>`.spec.clusterDiscovery.writeConnectionSecretToRef`</h4>

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
<h4>`.spec.clusterDiscovery.writeConnectionSecretToRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.
<h4>`.spec.clusterDiscovery.writeConnectionSecretToRef.namespace`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace of the secret.
<h4>`.spec.rdsCacheClusterSpec`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


RdsCacheClusterSpec is the spec for the RDS Cache Cluster
<h4>`.spec.rdsCacheClusterSpec.availabilityZones`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|3|
|Max Items|3|


AvailabilityZones is the list of availability zones to be used by the cluster
<h4>`.spec.rdsCacheClusterSpec.availabilityZones[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Cache defines the cache settings
<h4>`.spec.rdsCacheClusterSpec.cache.applyImmediately`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.
<h4>`.spec.rdsCacheClusterSpec.cache.atRestEncryptionEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AtRestEncryptionEnabled specifies whether data stored in the cluster is
  encrypted at rest.
<h4>`.spec.rdsCacheClusterSpec.cache.authTokenUpdateStrategy`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.autoMinorVersionUpgrade`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.
<h4>`.spec.rdsCacheClusterSpec.cache.automaticFailoverEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
  
  
  If enabled, NumCacheNodes must be greater than 1. Must be enabled for
  Redis (cluster mode enabled) replication groups.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheClusters is a list of cache clusters in the replication group.
  
  
  This value is overridden by NumCacheClusters.
  
  
  May be used to specify cluster specific configuration.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].applyImmediately`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately specifies whether the changes should be applied
  immediately or during the next maintenance window.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].autoMinorVersionUpgrade`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
  applied automatically to the cluster during the maintenance window.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].availabilityZone`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the name of the Availability Zone in which the
  cluster will be created.
  
  
  If you want to create cache nodes in multi-az, use
  preferred_availability_zones instead.
  Default: System chosen Availability Zone.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].azMode`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].engine`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].engineVersion`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].finalSnapshotIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].ipDiscovery`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].destination`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].destinationType`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].logFormat`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].logDeliveryConfigurations[*].logType`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].maintenanceWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].networkType`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].nodeType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless replication group is specified.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].notificationTopicArn`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].numCacheNodes`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Required unless replication group is specified.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].outpostMode`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].parameterGroupName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster.
  
  
  Required unless replication group is specified.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].port`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].preferredAvailabilityZones`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].preferredAvailabilityZones[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].preferredOutpostArn`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
  which the cache cluster will be created.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].securityGroupIds`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].securityGroupIds[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotArns`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotArns[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotRetentionLimit`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].snapshotWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].subnetGroupName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SubnetGroupName is the name of the subnet group to associate with this
  cluster.
  
  
  Required unless replication group is specified in which case it will be
  ignored.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.
<h4>`.spec.rdsCacheClusterSpec.cache.cacheClusters[*].transitEncryptionEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only
<h4>`.spec.rdsCacheClusterSpec.cache.clusterModeEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ClusterModeEnabled specifies whether cluster mode is enabled for the
  replication group.
<h4>`.spec.rdsCacheClusterSpec.cache.createReplicationGroup`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateReplicationGroup specifies whether a replication group should be
  created.
  
  
  If set false, the replication group configuration will be used for
  creating a single cluster
<h4>`.spec.rdsCacheClusterSpec.cache.dataTieringEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DataTieringEnabled specifies whether data tiering is enabled for the
  replication group.
  
  
  Must be true if the replcation group is using r6gd nodes
<h4>`.spec.rdsCacheClusterSpec.cache.engine`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.engineVersion`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
  
  
  This value will be ignored once the cluster is created.
<h4>`.spec.rdsCacheClusterSpec.cache.finalSnapshotIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the user-supplied name for the final snapshot
  that is created immediately before the cluster is deleted.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


GlobalReplicationGroup is the global replication group configuration.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.automaticFailoverEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutomaticFailoverEnabled specifies whether a read replica will be
  automatically promoted to the primary cluster if the existing primary
  cluster fails.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.cacheNodeType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheNodeType is the instance class to use for the cache nodes.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is a flag that enables the global replication group.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.engineVersion`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version number of the cache engine to be used for
  the cluster. If not set this will default to the latest version.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.numNodeGroups`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.parameterGroupName`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroup.suffix`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupIdSuffix is the suffix to append to the global
  replication group id.
<h4>`.spec.rdsCacheClusterSpec.cache.globalReplicationGroupId`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalReplicationGroupId is the id of the global replication group to
  which this replication group should belong.
  
  
  If this value is specified, the number of node groups parameter must not
  be specified.
<h4>`.spec.rdsCacheClusterSpec.cache.ipDiscovery`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.kmsKeyId`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
  encrypt the data in the cluster.
  
  
  Ignored unless AtRestEncryptionEnabled is set to true.
<h4>`.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


LogDeliveryConfiguration is a list of log delivery configurations for
  the cluster.
  
  
  This is only applicable when the Engine parameter is redis.
<h4>`.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].destination`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Destination Name of the cloudwatch log group or for kinesis firehose resource.
<h4>`.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].destinationType`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].logFormat`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.logDeliveryConfigurations[*].logType`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.maintenanceWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MaintenanceWindow specifies the weekly time range during which system
  maintenance can occur.
<h4>`.spec.rdsCacheClusterSpec.cache.multiAzEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAzEnabled specifies whether the cluster should be created in
  multiple Availability Zones.
  
  
  If true, AutomaticFailoverEnabled must also be true.
<h4>`.spec.rdsCacheClusterSpec.cache.networkType`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.cache.nodeType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NodeType is the instance class to use for the cache nodes.
  
  
  Requried unless global replication group is specified.
<h4>`.spec.rdsCacheClusterSpec.cache.notificationTopicArn`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
  topic to which notifications will be sent.
<h4>`.spec.rdsCacheClusterSpec.cache.numCacheClusters`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheClusters is the number of cache clusters in the replication group.
  
  
  If MultiAzEnabled is true, this value must be at least 2 but generally
  should be equal to the number of Availability Zones.
  
  
  Conflicts with NumNodeGroups.
<h4>`.spec.rdsCacheClusterSpec.cache.numCacheNodes`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumCacheNodes is the number of cache nodes in the cluster.
  
  
  Ignored if replication group is specified or being created
  This is a convenience parameter when building a single cluster.
<h4>`.spec.rdsCacheClusterSpec.cache.numNodeGroups`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


NumNodeGroups is the number of node groups in the replication group.
  
  
  If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
  is true, this value must not be specified.
  
  
  Conflicts with NumCacheClusters.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ParameterGroupConfiguration defines the configuration for the parameter
  group.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.description`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is a description of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.family`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Family is the name of the parameter group family that this parameter
  group is compatible with.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.parameters`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Parameters is a list of parameters in the parameter group.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupConfiguration.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the parameter group.
<h4>`.spec.rdsCacheClusterSpec.cache.parameterGroupName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the parameter group to associate with
  this cluster. To create a new parameter group, use the
  `ParameterGroupConfiguration` option instead.
<h4>`.spec.rdsCacheClusterSpec.cache.port`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Port is the port number on which each of the cache nodes will accept
  connections.
<h4>`.spec.rdsCacheClusterSpec.cache.preferredCacheClusterAzs`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


PreferredCacheClusterAzs is a list ec2 availability zones in which the
  cache clusters will be created.
<h4>`.spec.rdsCacheClusterSpec.cache.preferredCacheClusterAzs[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.replicasPerNodeGroup`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ReplicasPerNodeGroup is the number of read replicas per node group.
<h4>`.spec.rdsCacheClusterSpec.cache.securityGroupIds`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SecurityGroupIds is a list of security group IDs to associate with the
  cluster.
<h4>`.spec.rdsCacheClusterSpec.cache.securityGroupIds[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.snapshotArns`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
  from which to restore data into the cluster.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.snapshotArns[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.cache.snapshotName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotName is the name of the snapshot from which to restore data into
  the cluster.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.snapshotRetentionLimit`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SnapshotRetentionLimit is the number of days for which ElastiCache will
  retain automatic cache cluster snapshots before deleting them.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.snapshotWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SnapshotWindow is the daily time range (in UTC) during which ElastiCache
  will begin taking a daily snapshot of the cache cluster.
  
  
  Optional, Redis only
<h4>`.spec.rdsCacheClusterSpec.cache.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a list of key-value pairs to associate with the cluster.
<h4>`.spec.rdsCacheClusterSpec.cache.transitEncryptionEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


TransitEncryptionEnabled specifies whether data in the cluster is
  encrypted in transit.
  
  
  Optional, Memcached only
<h4>`.spec.rdsCacheClusterSpec.cache.usernames`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Usernames is a list of users to associate with the cluster.
<h4>`.spec.rdsCacheClusterSpec.cache.usernames[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Database defines the database settings
<h4>`.spec.rdsCacheClusterSpec.database.activityStream`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ActivityStream is the activity stream configuration.
<h4>`.spec.rdsCacheClusterSpec.database.activityStream.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether activity stream is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.activityStream.engineNativeAuditFieldsIncluded`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EngineNativeAuditFieldsIncluded is whether engine native audit fields are
  included. This option only applies to Oracle databases.
<h4>`.spec.rdsCacheClusterSpec.database.activityStream.mode`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- sync
- async

Mode is the mode of the activity stream. Valid values are `sync` and `async`.
<h4>`.spec.rdsCacheClusterSpec.database.allocatedStorage`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
<h4>`.spec.rdsCacheClusterSpec.database.allowMajorVersionUpgrade`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
<h4>`.spec.rdsCacheClusterSpec.database.applyImmediately`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
<h4>`.spec.rdsCacheClusterSpec.database.autoMinorVersionUpgrade`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically. This value can be overridden on a per instance basis.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Autoscaling is the autoscaling configuration.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Autoscaling is whether autoscaling is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.maxCapacity`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for autoscaling.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.metricType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- RDSReaderAverageCPUUtilization
- RDSReaderAverageDatabaseConnections

MetricType is the type of metric to use for autoscaling.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.minCapacity`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for autoscaling.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.policyName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PolicyName is the name of the autoscaling policy.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.scaleInCooldown`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleInCooldown is the amount of time, in seconds, after a scaling in
  activity completes before another scaling activity can start.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.scaleOutCooldown`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


ScaleOutCooldown is the amount of time, in seconds, after a scaling out
  activity completes before another scaling activity can start.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.targetCPU`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetCPU is CPU threshold which will initiate autoscaling.
<h4>`.spec.rdsCacheClusterSpec.database.autoscaling.targetConnections`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


TargetConnections is the average number of connections threshold which
  will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's
  default max_connections
<h4>`.spec.rdsCacheClusterSpec.database.backtrackWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BacktrackWindow is the target backtrack window, in seconds.
  Only available for Aurora engine. To disable backtracking, set this value to 0.
<h4>`.spec.rdsCacheClusterSpec.database.backupRetentionPeriod`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
<h4>`.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


CloudwatchLogGroup defines the parameters for the log groups
<h4>`.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.class`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Class is the class of the log group.
<h4>`.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.create`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the log group is to be created.
<h4>`.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.retentionInDays`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RetentionInDays is the number of days to retain logs for.
<h4>`.spec.rdsCacheClusterSpec.database.cloudwatchLogGroupParameters.skipDestroy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipDestroy is whether the log group should be skipped during destroy.
<h4>`.spec.rdsCacheClusterSpec.database.copyTagsToSnapshot`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
<h4>`.spec.rdsCacheClusterSpec.database.createCluster`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CreateCluster is whether the cluster should be created.
  By default this is true but for non-aurora clusters, the DB Cluster
  resource is optional and can be omitted. In this case, the DB instances
  will be created as `instance.rds` types.
<h4>`.spec.rdsCacheClusterSpec.database.databaseName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
<h4>`.spec.rdsCacheClusterSpec.database.databases`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Databases is a map of databases to create.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterInstanceClass`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DbClusterInstanceClass is the instance class to use.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbClusterParameterGroup defines the parameters for the DB cluster.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.applyMethod`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.create`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is to be created.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.description`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.family`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.parameters`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.parameters[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbClusterParameterGroup.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


DbParameterGroup defines the parameters for the DB instance.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.create`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Create is whether the parameter group is created.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.description`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.family`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Family is the family of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Name is the name of the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.parameters`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Parameters is a list of parameters to associate with the parameter group.
  Note that parameters may differ between families
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.parameters[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-zA-Z0-9_]*$`|


Parameter is a parameter to associate with a parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.dbParameterGroup.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the parameter group.
<h4>`.spec.rdsCacheClusterSpec.database.deleteAutomatedBackups`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
<h4>`.spec.rdsCacheClusterSpec.database.deletionProtection`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.domain`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Domain is the domain to use.
<h4>`.spec.rdsCacheClusterSpec.database.domainIAMRoleName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIAMRoleName is the name of the IAM role to use.
<h4>`.spec.rdsCacheClusterSpec.database.enableGlobalWriteForwarding`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableGlobalWriteForwarding is whether global write forwarding is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.enableHttpEndpoint`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableHttpEndpoint is whether the HTTP endpoint is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.enableLocalWriteForwarding`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


EnableLocalWriteForwarding is whether local write forwarding is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.enabledCloudwatchLogsExports`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
<h4>`.spec.rdsCacheClusterSpec.database.enabledCloudwatchLogsExports[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
<h4>`.spec.rdsCacheClusterSpec.database.endpoints`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Endpoints is a list of custom endpoints to create.
<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*].customEndpointType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- READER
- ANY

CustomEndpointType is the type of the custom endpoint.
<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*].excludedMembers`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludedMembers is a list of DB instances that aren't part of the custom
  endpoint group.
<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*].excludedMembers[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*].staticMembers`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


StaticMembers is a list of DB instances that are part of the custom
  endpoint group.
<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*].staticMembers[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database.endpoints[*].tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the custom endpoint.
<h4>`.spec.rdsCacheClusterSpec.database.engine`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Engine is the database engine to use.
<h4>`.spec.rdsCacheClusterSpec.database.engineMode`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- parallelquery
- provisioned
- serverless

EngineMode is the database engine mode to use.
<h4>`.spec.rdsCacheClusterSpec.database.engineVersion`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


EngineVersion is the version of the database engine to use.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


EnhancedMonitoring is the enhanced monitoring configuration.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.description`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Description is the description of the monitoring role.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether enhanced monitoring is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.forceDetachPolicies`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ForceDetachPolicies Whether to force detaching any policies the monitoring role has before destroying it
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.managedPolicyArns`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ManagedPolicyArns is a list of ARNs for managed policies to attach to the monitoring role.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.managedPolicyArns[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.maxSessionDuration`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxSessionDuration is the maximum session duration (in seconds) that you want to set for the monitoring role.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.monitoringInterval`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.path`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Path is the path of the monitoring role.
<h4>`.spec.rdsCacheClusterSpec.database.enhancedMonitoring.permissionsBoundary`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PermissionsBoundary is the ARN of the policy that is used to set the permissions boundary for the monitoring role.
<h4>`.spec.rdsCacheClusterSpec.database.eso`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Eso is the ESO configuration.
  
  
  This field is used to sync secrets using `external-secrets-operator`.
  External Secrets Operator must be installed if this value is set to true
<h4>`.spec.rdsCacheClusterSpec.database.eso.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled Whether or not to enable `external-secrets-operator` object
  deployments using `provider-kubernetes.
<h4>`.spec.rdsCacheClusterSpec.database.eso.kubernetesSecretStore`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


KubernetesSecretStore is the Kubernetes secret store to use.
  
  
  The kubernetes secret store is expected to be namespace scoped to prevent
  secrets leaking across namespaces.
<h4>`.spec.rdsCacheClusterSpec.database.eso.stores`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Stores is a list of secret stores to use for push secrets.
<h4>`.spec.rdsCacheClusterSpec.database.eso.stores[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretsStore is a reference to a secrets store to be passed to External
  Secrets Operator for creating PushSecrets
<h4>`.spec.rdsCacheClusterSpec.database.eso.stores[*].enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether the secrets store is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.eso.stores[*].isClusterSecretStore`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IsClusterSecretStore is whether the secret store is a cluster secret store.
<h4>`.spec.rdsCacheClusterSpec.database.eso.stores[*].secretStore`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


SecretStoreName is the name of the secret store.
<h4>`.spec.rdsCacheClusterSpec.database.globalClusterIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GlobalClusterIdentifier is the global cluster identifier for an Aurora global database.
<h4>`.spec.rdsCacheClusterSpec.database.iamDatabaseAuthenticationEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IAMDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.iamRoles`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


IamRoles is a list of IAM roles to associate with the DB cluster.
<h4>`.spec.rdsCacheClusterSpec.database.iamRoles[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database.iamRoles[*].featureName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FeatureName is the name of the feature.
<h4>`.spec.rdsCacheClusterSpec.database.iamRoles[*].roleArn`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RoleArn is the ARN of the role.
<h4>`.spec.rdsCacheClusterSpec.database.instanceCount`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


InstanceCount is the number of instances to create.
  
  
  If set, this value will create the requested number of instances using
  defaults from the cluster configuration. If `instances` are specified,
  this value is ignored.
<h4>`.spec.rdsCacheClusterSpec.database.instances`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Instances is a list of instances to create.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.database.instances[*].allocatedStorage`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AllocatedStorage is the size of the database.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllocatedStorage`
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].allowMajorVersionUpgrade`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowMajorVersionUpgrade is whether major version upgrades are allowed.
  
  
  Only applicable if not running in cluster mode. In cluster mode this value
  is ignored.
  
  
  Overrides `ClusterParameters.AllowMajorVersionUpgrade`
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].applyImmediately`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ApplyImmediately is whether changes should be applied immediately.
  
  
  Overrides `ClusterParameters.ApplyImmediately`
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].autoMinorVersionUpgrade`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoMinorVersionUpgrade is whether minor version upgrades are applied
  automatically.
  
  
  Overrides `ClusterParameters.AutoMinorVersionUpgrade`
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].availabilityZone`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AvailabilityZone is the availability zone for this instance.
  Ignored if `multiAz` is true
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].backupRetentionPeriod`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


BackupRetentionPeriod is the number of days to retain backups for.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].copyTagsToSnapshot`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


CopyTagsToSnapshot is whether tags should be copied to snapshots.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].databaseName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DatabaseName is the name of the database to create.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].deleteAutomatedBackups`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeleteAutomatedBackups is whether automated backups should be deleted.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].deletionProtection`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


DeletionProtection is whether deletion protection is enabled.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].domainIamRoleName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


DomainIamRoleName is the name of the IAM role to use.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].enabledCloudwatchLogsExports`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


EnabledCloudwatchLogsExports is the list of log types to export to CloudWatch Logs.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].enabledCloudwatchLogsExports[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LogGroup is the name of a log group.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].finalSnapshotIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


FinalSnapshotIdentifier is the identifier of the final snapshot.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].iamDatabaseAuthenticationEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


IamDatabaseAuthenticationEnabled is whether IAM database authentication is enabled.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].instanceClass`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


InstanceClass is the instance class to use.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].iops`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].licenseModel`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


LicenseModel is the license model to use.
  
  
  Only applicable if not running in cluster mode.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].monitoringInterval`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MonitoringInterval is the interval, in seconds, between points when
  Enhanced Monitoring metrics are collected for the DB instance.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].multiAz`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].networkType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


NetworkType is the network type to use.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].optionGroupName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


OptionGroupName is the name of the option group to associate with this DB
  instance.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].parameterGroupName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ParameterGroupName is the name of the DB parameter group to associate
  with this DB instance. Must pre-exist in the account. Mutually exclusive
  with `RdsBaseDbCluster.dbParameterGroup`
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].performanceInsightsEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].performanceInsightsKmsKeyID`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption
  of Performance Insights data.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].performanceInsightsRetentionPeriod`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to
  retain Performance Insights data.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].preferredMaintenanceWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].promotionTier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PromotionTier is the order in which to promote an Aurora replica to the
  primary instance.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].publiclyAccessible`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].skipFinalSnapshot`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


SkipFinalSnapshot is whether to skip the final snapshot.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].storageEncrypted`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


StorageEncrypted is whether storage is encrypted.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].storageThroughput`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


StorageThroughput is the amount of storage throughput. Only applicable if
  `storageType` is `gp3`
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].storageType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType is the storage type to use.
  
  
  Only applicable if not running in cluster mode
<h4>`.spec.rdsCacheClusterSpec.database.instances[*].tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB instance.
<h4>`.spec.rdsCacheClusterSpec.database.iops`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Iops is the amount of provisioned IOPS.
<h4>`.spec.rdsCacheClusterSpec.database.masterUsername`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


MasterUsername is the master username to use.
<h4>`.spec.rdsCacheClusterSpec.database.multiAz`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


MultiAZ is whether the DB instance is a Multi-AZ deployment.
<h4>`.spec.rdsCacheClusterSpec.database.partition`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- aws
- aws-cn
- aws-us-gov

Partition is the AWS partition to use.
<h4>`.spec.rdsCacheClusterSpec.database.performanceInsightsEnabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PerformanceInsightsEnabled is whether Performance Insights is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.performanceInsightsKmsKeyID`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PerformanceInsightsKmsKeyID is the AWS KMS key identifier for encryption of Performance Insights data.
<h4>`.spec.rdsCacheClusterSpec.database.performanceInsightsRetentionPeriod`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


PerformanceInsightsRetentionPeriod is the amount of time, in days, to retain Performance Insights data.
<h4>`.spec.rdsCacheClusterSpec.database.preferredBackupWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredBackupWindow is the preferred backup window.
<h4>`.spec.rdsCacheClusterSpec.database.preferredMaintenanceWindow`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


PreferredMaintenanceWindow is the preferred maintenance window.
<h4>`.spec.rdsCacheClusterSpec.database.provisionSql`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


ProvisionSql determines whether or not to provision databases inside the
  RDS cluster.
<h4>`.spec.rdsCacheClusterSpec.database.publiclyAccessible`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


PubliclyAccessible is whether the DB instance is publicly accessible.
<h4>`.spec.rdsCacheClusterSpec.database.replicationSourceIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ReplicationSourceIdentifier ARN of a source DB cluster or DB instance if
  this DB cluster is to be created as a Read Replica
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


RestoreToPointInTime is the point in time to restore to.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.identifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Identifier is the identifier of the source DB cluster snapshot or DB
  instance snapshot to restore from. Only valid if not running in cluster
  mode.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.restoreToTime`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RestoreToTime is the time to restore to.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.restoreType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Allowed Values:
- full-copy
- copy-on-write

RestoreType is the type of restore to perform. This option is ignored if
  not running in cluster mode.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbClusterIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbClusterIdentifier is the identifier of the source DB cluster.
  This option is ignored if not running in cluster mode.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbInstanceAutomatedBackupsArn`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


sourceDbInstanceAutomatedBackupsArn is the ARN of the source DB instance
  automated backup to restore from. Only valid if not running in cluster mode.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbInstanceIdentifier`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbInstanceIdentifier is the identifier of the source DB instance.
  Only valid if not running in cluster mode. If running in cluster mode, use
  `SourceDbClusterIdentifier` instead.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.sourceDbiResourceId`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceDbiResourceId is the resource ID of the source DB instance. Only
  valid if not running in cluster mode.
<h4>`.spec.rdsCacheClusterSpec.database.restoreToPointInTime.useLatestRestorableTime`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


UseLatestRestorableTime is whether to use the latest restorable time.
<h4>`.spec.rdsCacheClusterSpec.database.s3Import`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


S3Import is the S3 import configuration.
<h4>`.spec.rdsCacheClusterSpec.database.s3Import.bucketName`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketName is the name of the S3 bucket.
<h4>`.spec.rdsCacheClusterSpec.database.s3Import.bucketPrefix`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


BucketPrefix is the prefix of the S3 bucket. Can be blank but is the path
  within the bucket where the data is located.
<h4>`.spec.rdsCacheClusterSpec.database.s3Import.ingestionRole`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


IngestionRole is the role to use for ingestion.
<h4>`.spec.rdsCacheClusterSpec.database.s3Import.sourceEngine`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngine is the source engine to use.
<h4>`.spec.rdsCacheClusterSpec.database.s3Import.sourceEngineVersion`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


SourceEngineVersion is the source engine version to use.
<h4>`.spec.rdsCacheClusterSpec.database.scalingConfiguration`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ScalingConfiguration is the scaling configuration.
<h4>`.spec.rdsCacheClusterSpec.database.scalingConfiguration.autoPause`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AutoPause is whether the database should automatically pause.
<h4>`.spec.rdsCacheClusterSpec.database.scalingConfiguration.maxCapacity`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
<h4>`.spec.rdsCacheClusterSpec.database.scalingConfiguration.minCapacity`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
<h4>`.spec.rdsCacheClusterSpec.database.scalingConfiguration.secondsUntilAutoPause`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


SecondsUntilAutoPause is the number of seconds until the database
  automatically pauses.
<h4>`.spec.rdsCacheClusterSpec.database.secretRotation`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SecretRotation is the secret rotation configuration.
<h4>`.spec.rdsCacheClusterSpec.database.secretRotation.automaticallyAfterDays`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


AutomaticallyAfterDays is the number of days after which the secret is
  rotated automatically.
<h4>`.spec.rdsCacheClusterSpec.database.secretRotation.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled is whether secret rotation is enabled.
<h4>`.spec.rdsCacheClusterSpec.database.secretRotation.rotateImmediately`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


RotateImmediately is whether the secret should be rotated immediately.
<h4>`.spec.rdsCacheClusterSpec.database.secretRotation.scheduleExpression`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ScheduleExpression is the schedule expression for secret rotation.
<h4>`.spec.rdsCacheClusterSpec.database.serverlessV2ScalingConfiguration`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ServerlessV2ScalingConfiguration is the serverless v2 scaling configuration.
<h4>`.spec.rdsCacheClusterSpec.database.serverlessV2ScalingConfiguration.maxCapacity`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MaxCapacity is the maximum capacity for the database.
<h4>`.spec.rdsCacheClusterSpec.database.serverlessV2ScalingConfiguration.minCapacity`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


MinCapacity is the minimum capacity for the database.
<h4>`.spec.rdsCacheClusterSpec.database.storageType`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


StorageType specifies the storage type to be associated with the cluster
<h4>`.spec.rdsCacheClusterSpec.database.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to associate with the DB cluster.
<h4>`.spec.rdsCacheClusterSpec.deletionPolicy`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.kubernetesProviderConfig`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


KubernetesProviderConfig
<h4>`.spec.rdsCacheClusterSpec.kubernetesProviderConfig.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


<h4>`.spec.rdsCacheClusterSpec.managementPolicies`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.managementPolicies[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.
<h4>`.spec.rdsCacheClusterSpec.providerConfigRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.
<h4>`.spec.rdsCacheClusterSpec.providerConfigRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>`.spec.rdsCacheClusterSpec.providerConfigRef.policy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>`.spec.rdsCacheClusterSpec.providerConfigRef.policy.resolution`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.providerConfigRef.policy.resolve`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.policy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.policy.resolution`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.configRef.policy.resolve`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata.annotations`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata.labels`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.metadata.type`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.
<h4>`.spec.rdsCacheClusterSpec.publishConnectionDetailsTo.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.
<h4>`.spec.rdsCacheClusterSpec.region`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Region is the region in which this collection will be created
<h4>`.spec.rdsCacheClusterSpec.subnetGroupIndexes`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


SubnetGroupIndexes is a map of service name to subnet set indexes
<h4>`.spec.rdsCacheClusterSpec.subnetGroupIndexes.cache`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Cache is the subnet group index to use for the cache
<h4>`.spec.rdsCacheClusterSpec.subnetGroupIndexes.database`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Database is the subnet group index to use for the database
<h4>`.spec.rdsCacheClusterSpec.vpc`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Vpc defines the VPC settings
<h4>`.spec.rdsCacheClusterSpec.vpc.peering`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Peering is the VPC to peer with.
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.allowPublic`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowPublic specifies if the VPC peering connections should be allowed to
  be linked to the public subnets
  Defaults to false
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.enabled`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled specifies if the VPC peering connections should be enabled for
  this VPC.
  Defaults to false
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.groupBy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GroupBy specifies the key to group the remote subnets by
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|125|


RemoteVpcs is a list of VPCs to peer with.
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


VpcPeer defines the parameters for peering with a VPC.
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].allowPublic`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Disabled specifies if the peering connection should be disabled.
  Defaults to true
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ExcludeFromLocalPeering specifies the indexes of subnetsets for this VPC to
  exclude from routing to the peering connection
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.private`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.private[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.public`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromLocalPeering.public[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludeFromRemotePeering specifies the indexes of subnetsets for the remote
  VPC to exclude from routing to the peering connection. If emmpty, all
  subnetsets will be included by default
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].private`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].private[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].public`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].excludeFromRemotePeering[*].public[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name specifies the name of the VPC to peer with.
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].providerConfigRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ProviderConfigRef specifies the provider config to use for the peering
  connection.
<h4>`.spec.rdsCacheClusterSpec.vpc.peering.remoteVpcs[*].region`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Region specifies the region the VPC is found in.
  
  
  If not defined, the region of the VPC will be assumed to be the same as
  the region of the peered VPC.
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


PeeredSubnets defines how many public and private subnet sets to create.
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|1|
|Max Items|5|


Cidrs is a list of PeeredSubnetSets to create in the VPC
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PeeredSubnetSet defines the parameters for creating a set of subnets with the
  same mask.
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].prefix`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|


Prefix is the CIDR prefix to use for the subnet set
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Private is the number of private subnets to create in this set
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.clusterNames`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterNames is a list of EKS cluster names to add shared LB tags for
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.clusterNames[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.count`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Count is the number of subnet sets to create with this mask
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.lbSetIndex`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Determines which subnet set in this range to use for kubernetes load
  balancers. -1 means no load balancer tag is defined on this group
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.mask`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Mask is the CIDR mask to use for the subnet set
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].private.offset`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Public is the number of public subnets to create in this set
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.clusterNames`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ClusterNames is a list of EKS cluster names to add shared LB tags for
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.clusterNames[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.count`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|


Count is the number of subnet sets to create with this mask
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.lbSetIndex`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Determines which subnet set in this range to use for kubernetes load
  balancers. -1 means no load balancer tag is defined on this group
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.mask`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Mask is the CIDR mask to use for the subnet set
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.cidrs[*].public.offset`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by
<h4>`.spec.rdsCacheClusterSpec.vpc.subnetsets.function`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.vpc.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a map of additional tags to assign to the VPC.
<h4>`.spec.rdsCacheClusterSpec.vpc.tags.cluster`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Cluster tags to apply subnets for autodiscovery of load balancers
<h4>`.spec.rdsCacheClusterSpec.vpc.tags.common`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


common tags apoplied to all resources
<h4>`.spec.rdsCacheClusterSpec.vpc.tags.subnet`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Subnet tags to apply to all subnetsets
<h4>`.spec.rdsCacheClusterSpec.writeConnectionSecretToRef`</h4>

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
<h4>`.spec.rdsCacheClusterSpec.writeConnectionSecretToRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.
<h4>`.spec.rdsCacheClusterSpec.writeConnectionSecretToRef.namespace`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace of the secret.

### Status Properties
<h4>`.status.cacheClusterEndpoints`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheClusterEndpoints is a list of endpoints of the Elasticache clusters
  when the cache is configured in cluster mode
<h4>`.status.cacheClusterEndpoints[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.status.cacheConnectionSecret`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheConnectionSecret is the secret containing the connection details for
  the Elasticache replication group
<h4>`.status.cacheEndpoint`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheEndpoint is the endpoint of the Elasticache replication group
<h4>`.status.cacheGlobalConnectionSecret`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheGlobalConnectionSecret is the name of the global connection secret for the
  Elasticache cluster
<h4>`.status.cacheGlobalEndpoint`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheGlobalEndpoint is the global (RW) endpoint of the Elasticache
  global replication group
<h4>`.status.cacheGlobalReaderEndpoint`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheGlobalReaderEndpoint is the global (RO) endpoint of the Elasticache
  global replication group
<h4>`.status.cachePort`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


CachePort is the port of the Elasticache
<h4>`.status.cacheReaderEndpoint`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


CacheReaderEndpoint is the reader endpoint of the Elasticache replication
  group
<h4>`.status.cacheSubnets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


CacheSubnets is the list of subnets to be used by ElasticSearch
<h4>`.status.cacheSubnets[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.status.conditions`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Conditions of the resource.
<h4>`.status.conditions[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A Condition that may apply to a resource.
<h4>`.status.conditions[*].lastTransitionTime`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


LastTransitionTime is the last time this condition transitioned from one
  status to another.
<h4>`.status.conditions[*].message`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A Message containing details about this condition's last transition from
  one status to another, if any.
<h4>`.status.conditions[*].reason`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


A Reason for this condition's last transition from one status to another.
<h4>`.status.conditions[*].status`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Status of this condition; is it currently True, False, or Unknown?
<h4>`.status.conditions[*].type`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Type of this condition. At most one of each condition type may apply to
  a resource at any point in time.
<h4>`.status.rdsConnectionSecret`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RdsConnectionSecret is the secret containing the connection details
  for the database
<h4>`.status.rdsEndpoint`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


RdsEndpoint is the endpoint of the database
<h4>`.status.rdsPort`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


RdsPort is the port of the database
<h4>`.status.rdsSubnets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


RdsSubnets is the list of subnets to be used by the database
<h4>`.status.rdsSubnets[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.status.vpc`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Vpc is a VPC configuration to bind the cluster to
<h4>`.status.vpc.additionalCidrBlocks`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A list of additional VPC CIDR blocks defined in this VPC
<h4>`.status.vpc.additionalCidrBlocks[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


<h4>`.status.vpc.cidrBlock`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The Ipv4 cidr block defined for this VPC
<h4>`.status.vpc.id`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


ID The VPC ID
<h4>`.status.vpc.internetGateway`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The internet gateway defined in this VPC
<h4>`.status.vpc.natGateways`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of NAT gateways defined in this VPC
<h4>`.status.vpc.privateRouteTables`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A map of private route tables defined in this VPC
<h4>`.status.vpc.privateRouteTables[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusRouteTables is a map of route tables and their status
<h4>`.status.vpc.privateSubnets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A map of private subnets defined in this VPC
<h4>`.status.vpc.privateSubnets[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusSubnets is a map of subnets and their status
<h4>`.status.vpc.providerConfig`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The provider config used to look up this VPC
<h4>`.status.vpc.publicRouteTables`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A map of public route tables defined in this VPC
<h4>`.status.vpc.publicRouteTables[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusRouteTables is a map of route tables and their status
<h4>`.status.vpc.publicSubnets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A list of maps of public subnets defined in this VPC
<h4>`.status.vpc.publicSubnets[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


StatusSubnets is a map of subnets and their status
<h4>`.status.vpc.region`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


The region this VPC is located in
<h4>`.status.vpc.securityGroups`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of security groups defined in this VPC
<h4>`.status.vpc.transitGateways`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of transit gateways defined in this VPC
<h4>`.status.vpc.vpcPeeringConnections`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


A map of VPC peering connections defined in this VPC





