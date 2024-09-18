---
title: Discovery CRD schema reference (group xnetworks.crossplane.giantswarm.io)
linkTitle: Discovery
description: |
  Custom resource definition (CRD) schema reference page for the Discovery resource (discoveries.xnetworks.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: DiscoveryClaim
  claim_name_plural: discoveryclaims
  default_composition_ref: network-discovery
  enforced_composition_ref: network-discovery
  name_camelcase: Discovery
  name_plural: discoveries
  name_singular: discovery
  short_names:
    - dscvr
  group: xnetworks.crossplane.giantswarm.io
  technical_name: discoveries.xnetworks.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - crossplane
    - networks
    - vpc
    - discovery
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/discoveries.xnetworks.crossplane.giantswarm.io/
technical_name: discoveries.xnetworks.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# Discovery


<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">discoveries.xnetworks.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">DiscoveryClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">discoveryclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">network-discovery</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">network-discovery</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xnetworks.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">discovery</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">dscvr</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">discoveries</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

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

#### `.spec.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Whether this discovery is enabled.

#### `.spec.groupBy`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

A tag that can be referenced to group subnets and route tables
into subnetsets.

The tag must have an integer value

#### `.spec.kubernetesProviderConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|

The name of the provider config to use for creating kubernetes resources.

#### `.spec.kubernetesProviderConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.kubernetesProviderConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.kubernetesProviderConfigRef.policy.resolution`

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

#### `.spec.kubernetesProviderConfigRef.policy.resolve`

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

#### `.spec.providerType`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The name of the provider config to use for looking up remote VPCs.

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

The default region to look in.

#### `.spec.remoteVpcs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|0|
|Max Items|Unlimited|

Details about the remove VPCs to look up.

#### `.spec.remoteVpcs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

VpcPeer defines the parameters for peering with a VPC.

#### `.spec.remoteVpcs[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name specifies the name of the VPC to peer with.

#### `.spec.remoteVpcs[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProviderConfigRef specifies the provider config to use for the peering
connection.

#### `.spec.remoteVpcs[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.remoteVpcs[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.remoteVpcs[*].providerConfigRef.policy.resolution`

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

#### `.spec.remoteVpcs[*].providerConfigRef.policy.resolve`

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

#### `.spec.remoteVpcs[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region specifies the region the VPC is found in.

If not defined, the region of the VPC will be assumed to be the same as
the region of the peered VPC.

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

#### `.status.vpcs`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

The VPCs that have been discovered.
