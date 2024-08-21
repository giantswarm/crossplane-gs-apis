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
<dd class="shortnames">ec</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">cachebases</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

#### `.spec.applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately specifies whether the changes should be applied
immediately or during the next maintenance window.

#### `.spec.atRestEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AtRestEncryptionEnabled specifies whether data stored in the cluster is
encrypted at rest.

#### `.spec.authTokenUpdateStrategy`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- rotate
- set

AuthTokenUpdateStrategy specifies how the auth token should be updated.

#### `.spec.autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
applied automatically to the cluster during the maintenance window.

#### `.spec.automaticFailoverEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutomaticFailoverEnabled specifies whether a read replica will be
automatically promoted to the primary cluster if the existing primary
cluster fails.

If enabled, NumCacheNodes must be greater than 1. Must be enabled for
Redis (cluster mode enabled) replication groups.

#### `.spec.availabilityZones`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

AvailabilityZones is a list of Availability Zones in which the
cluster's nodes will be created.

#### `.spec.availabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.azMode`

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

#### `.spec.cacheClusters`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

CacheClusters is a list of cache clusters in the replication group.

This value is overridden by NumCacheClusters.

May be used to specify cluster specific configuration.

#### `.spec.cacheClusters[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.cacheClusters[*].applyImmediately`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ApplyImmediately specifies whether the changes should be applied
immediately or during the next maintenance window.

#### `.spec.cacheClusters[*].autoMinorVersionUpgrade`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutoMinorVersionUpgrade specifies whether minor engine upgrades will be
applied automatically to the cluster during the maintenance window.

#### `.spec.cacheClusters[*].availabilityZone`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

AvailabilityZone is the name of the Availability Zone in which the
cluster will be created.

If you want to create cache nodes in multi-az, use
preferred_availability_zones instead.
Default: System chosen Availability Zone.

#### `.spec.cacheClusters[*].azMode`

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

#### `.spec.cacheClusters[*].engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- memcached
- redis

Engine is the name of the cache engine to be used for the clusters in
this group.

#### `.spec.cacheClusters[*].engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version number of the cache engine to be used for
the cluster. If not set this will default to the latest version.

This value will be ignored once the cluster is created.

#### `.spec.cacheClusters[*].finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FinalSnapshotIdentifier is the user-supplied name for the final snapshot
that is created immediately before the cluster is deleted.

#### `.spec.cacheClusters[*].ipDiscovery`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6

IpDiscovery is the method used to discover cluster nodes.

#### `.spec.cacheClusters[*].logDeliveryConfigurations`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

LogDeliveryConfiguration is a list of log delivery configurations for
the cluster.

This is only applicable when the Engine parameter is redis.

#### `.spec.cacheClusters[*].logDeliveryConfigurations[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.cacheClusters[*].logDeliveryConfigurations[*].destination`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Destination Name of the cloudwatch log group or for kinesis firehose resource.

#### `.spec.cacheClusters[*].logDeliveryConfigurations[*].destinationType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- cloudwatch-logs
- kinesis-firehose

DestinationType The destination type for the logs.

#### `.spec.cacheClusters[*].logDeliveryConfigurations[*].logFormat`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- text
- json

LogFormat The log format to use.

#### `.spec.cacheClusters[*].logDeliveryConfigurations[*].logType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- slow-log
- engine-log

LogType The type of log to deliver.

#### `.spec.cacheClusters[*].maintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MaintenanceWindow specifies the weekly time range during which system
maintenance can occur.

#### `.spec.cacheClusters[*].networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6
- dual_stack

NetworkType specifies the network configuration for the cluster.

#### `.spec.cacheClusters[*].nodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NodeType is the instance class to use for the cache nodes.

Requried unless replication group is specified.

#### `.spec.cacheClusters[*].notificationTopicArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
topic to which notifications will be sent.

#### `.spec.cacheClusters[*].numCacheNodes`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumCacheNodes is the number of cache nodes in the cluster.

Required unless replication group is specified.

#### `.spec.cacheClusters[*].outpostMode`

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

#### `.spec.cacheClusters[*].parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the parameter group to associate with
this cluster.

Required unless replication group is specified.

#### `.spec.cacheClusters[*].port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Port is the port number on which each of the cache nodes will accept
connections.

#### `.spec.cacheClusters[*].preferredAvailabilityZones`

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

#### `.spec.cacheClusters[*].preferredAvailabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cacheClusters[*].preferredOutpostArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

PreferredOutpostArn is the Amazon Resource Name (ARN) of the outpost in
which the cache cluster will be created.

#### `.spec.cacheClusters[*].securityGroupIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SecurityGroupIds is a list of security group IDs to associate with the
cluster.

#### `.spec.cacheClusters[*].securityGroupIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cacheClusters[*].snapshotArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
from which to restore data into the cluster.

Optional, Redis only

#### `.spec.cacheClusters[*].snapshotArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.cacheClusters[*].snapshotName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotName is the name of the snapshot from which to restore data into
the cluster.

Optional, Redis only

#### `.spec.cacheClusters[*].snapshotRetentionLimit`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

SnapshotRetentionLimit is the number of days for which ElastiCache will
retain automatic cache cluster snapshots before deleting them.

Optional, Redis only

#### `.spec.cacheClusters[*].snapshotWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotWindow is the daily time range (in UTC) during which ElastiCache
will begin taking a daily snapshot of the cache cluster.

Optional, Redis only

#### `.spec.cacheClusters[*].subnetGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SubnetGroupName is the name of the subnet group to associate with this
cluster.

Required unless replication group is specified in which case it will be
ignored.

#### `.spec.cacheClusters[*].tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a list of key-value pairs to associate with the cluster.

#### `.spec.cacheClusters[*].transitEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

TransitEncryptionEnabled specifies whether data in the cluster is
encrypted in transit.

Optional, Memcached only

#### `.spec.cidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

CidrBlocks is a list of CIDR blocks that are allowed to access the
cluster.

#### `.spec.cidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.clusterModeEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

ClusterModeEnabled specifies whether cluster mode is enabled for the
replication group.

#### `.spec.createReplicationGroup`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

CreateReplicationGroup specifies whether a replication group should be
created.

If set false, the replication group configuration will be used for
creating a single cluster

#### `.spec.dataTieringEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

DataTieringEnabled specifies whether data tiering is enabled for the
replication group.

Must be true if the replcation group is using r6gd nodes

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

#### `.spec.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- memcached
- redis

Engine is the name of the cache engine to be used for the clusters in
this group.

#### `.spec.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version number of the cache engine to be used for
the cluster. If not set this will default to the latest version.

This value will be ignored once the cluster is created.

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

#### `.spec.eso.stores[*].secretStore`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

SecretStoreName is the name of the secret store.

#### `.spec.finalSnapshotIdentifier`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

FinalSnapshotIdentifier is the user-supplied name for the final snapshot
that is created immediately before the cluster is deleted.

#### `.spec.globalReplicationGroup`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

GlobalReplicationGroup is the global replication group configuration.

#### `.spec.globalReplicationGroup.automaticFailoverEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

AutomaticFailoverEnabled specifies whether a read replica will be
automatically promoted to the primary cluster if the existing primary
cluster fails.

#### `.spec.globalReplicationGroup.cacheNodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

CacheNodeType is the instance class to use for the cache nodes.

#### `.spec.globalReplicationGroup.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled is a flag that enables the global replication group.

#### `.spec.globalReplicationGroup.engineVersion`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

EngineVersion is the version number of the cache engine to be used for
the cluster. If not set this will default to the latest version.

#### `.spec.globalReplicationGroup.numNodeGroups`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumNodeGroups is the number of node groups in the replication group.

#### `.spec.globalReplicationGroup.parameterGroupName`

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

#### `.spec.globalReplicationGroup.suffix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalReplicationGroupIdSuffix is the suffix to append to the global
replication group id.

#### `.spec.globalReplicationGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalReplicationGroupId is the id of the global replication group to
which this replication group should belong.

If this value is specified, the number of node groups parameter must not
be specified.

#### `.spec.ipDiscovery`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6

IpDiscovery is the method used to discover cluster nodes.

#### `.spec.kmsKeyId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

KmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
encrypt the data in the cluster.

Ignored unless AtRestEncryptionEnabled is set to true.

#### `.spec.kubernetesProviderConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Provider configuration for the kubernetes provider

This is required for creating users for redis clusters.
If Redis is the engine type, this must be provided and
external-secrets-operator must be installed.

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

#### `.spec.logDeliveryConfigurations`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

LogDeliveryConfiguration is a list of log delivery configurations for
the cluster.

This is only applicable when the Engine parameter is redis.

#### `.spec.logDeliveryConfigurations[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.logDeliveryConfigurations[*].destination`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Destination Name of the cloudwatch log group or for kinesis firehose resource.

#### `.spec.logDeliveryConfigurations[*].destinationType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- cloudwatch-logs
- kinesis-firehose

DestinationType The destination type for the logs.

#### `.spec.logDeliveryConfigurations[*].logFormat`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- text
- json

LogFormat The log format to use.

#### `.spec.logDeliveryConfigurations[*].logType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Allowed Values:

- slow-log
- engine-log

LogType The type of log to deliver.

#### `.spec.maintenanceWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

MaintenanceWindow specifies the weekly time range during which system
maintenance can occur.

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

#### `.spec.multiAzEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

MultiAzEnabled specifies whether the cluster should be created in
multiple Availability Zones.

If true, AutomaticFailoverEnabled must also be true.

#### `.spec.networkType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- ipv4
- ipv6
- dual_stack

NetworkType specifies the network configuration for the cluster.

#### `.spec.nodeType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NodeType is the instance class to use for the cache nodes.

Requried unless global replication group is specified.

#### `.spec.notificationTopicArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

NotificationTopicArn is the Amazon Resource Name (ARN) of the Amazon SNS
topic to which notifications will be sent.

#### `.spec.numCacheClusters`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumCacheClusters is the number of cache clusters in the replication group.

If MultiAzEnabled is true, this value must be at least 2 but generally
should be equal to the number of Availability Zones.

Conflicts with NumNodeGroups.

#### `.spec.numCacheNodes`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumCacheNodes is the number of cache nodes in the cluster.

Ignored if replication group is specified or being created
This is a convenience parameter when building a single cluster.

#### `.spec.numNodeGroups`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

NumNodeGroups is the number of node groups in the replication group.

If GlobalReplicationGroupId is specified or GlobalReplicationGroup.Enabled
is true, this value must not be specified.

Conflicts with NumCacheClusters.

#### `.spec.parameterGroupConfiguration`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ParameterGroupConfiguration defines the configuration for the parameter
group.

#### `.spec.parameterGroupConfiguration.description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Description is a description of the parameter group.

#### `.spec.parameterGroupConfiguration.family`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Family is the name of the parameter group family that this parameter
group is compatible with.

#### `.spec.parameterGroupConfiguration.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name is the name of the parameter group.

#### `.spec.parameterGroupConfiguration.parameters`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Parameters is a list of parameters in the parameter group.

#### `.spec.parameterGroupConfiguration.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tags is a list of key-value pairs to associate with the parameter group.

#### `.spec.parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the parameter group to associate with
this cluster. To create a new parameter group, use the
`ParameterGroupConfiguration` option instead.

#### `.spec.port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Port is the port number on which each of the cache nodes will accept
connections.

#### `.spec.preferredCacheClusterAzs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

PreferredCacheClusterAzs is a list ec2 availability zones in which the
cache clusters will be created.

#### `.spec.preferredCacheClusterAzs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


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

Region is the region in which the cluster will be created.

#### `.spec.replicasPerNodeGroup`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

ReplicasPerNodeGroup is the number of read replicas per node group.

#### `.spec.securityGroupIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SecurityGroupIds is a list of security group IDs to associate with the
cluster.

#### `.spec.securityGroupIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.snapshotArns`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SnapshotArns is a list of Amazon Resource Names (ARNs) of the snapshots
from which to restore data into the cluster.

Optional, Redis only

#### `.spec.snapshotArns[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.snapshotName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotName is the name of the snapshot from which to restore data into
the cluster.

Optional, Redis only

#### `.spec.snapshotRetentionLimit`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

SnapshotRetentionLimit is the number of days for which ElastiCache will
retain automatic cache cluster snapshots before deleting them.

Optional, Redis only

#### `.spec.snapshotWindow`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SnapshotWindow is the daily time range (in UTC) during which ElastiCache
will begin taking a daily snapshot of the cache cluster.

Optional, Redis only

#### `.spec.subnetIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SubnetIds is a list of subnet IDs in which the cluster's nodes will be
created.

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

Tags is a list of key-value pairs to associate with the cluster.

#### `.spec.transitEncryptionEnabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

TransitEncryptionEnabled specifies whether data in the cluster is
encrypted in transit.

Optional, Memcached only

#### `.spec.usernames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Usernames is a list of users to associate with the cluster.

#### `.spec.usernames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.vpcId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

VpcId is the ID of the VPC in which the cluster will be created.

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

#### `.status.clusterEndpoints`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ClusterEndpoints is a list of endpoints for the clusters.

#### `.status.clusterEndpoints[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.status.clusterName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ClusterName is the name of the cluster.

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

ConnectionSecret is the name of the connection secret.

#### `.status.endpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Endpoint is the DNS name of the endpoint for the cluster.

#### `.status.globalConnectionSecret`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalConnectionSecret is the name of the global connection secret.

#### `.status.globalEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalEndpoint is the DNS name of the endpoint for the cluster at global
scope

#### `.status.globalReaderEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalReaderEndpoint is the DNS name of the reader endpoint for the
cluster at global scope

#### `.status.globalReplicationGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

GlobalReplicationGroupId is the ID of the global replication group.

#### `.status.kmsKeyId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

kmsKeyId is the ID of the AWS Key Management Service (KMS) key used to
encrypt the data in the cluster.

#### `.status.parameterGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ParameterGroupName is the name of the parameter group associated with the
cluster.

#### `.status.port`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Port is the port number on which each of the cache nodes will accept
connections.

#### `.status.readerEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ReaderEndpoint is the DNS name of the reader endpoint for the cluster.

#### `.status.ready`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Ready is a flag that indicates whether the cluster is ready.

#### `.status.replicationGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

ReplicationGroupId is the ID of the replication group.

#### `.status.securityGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SecurityGroupId is the ID of the security group for the cluster.

#### `.status.subnetGroupName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

SubnetGroupName is the name of the subnet group for the cluster.

#### `.status.userGroupId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

UserGroupId is the ID of the user group for the cluster.
