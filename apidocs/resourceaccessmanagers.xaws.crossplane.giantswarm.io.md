---
title: ResourceAccessManager CRD schema reference (group xaws.crossplane.giantswarm.io)
linkTitle: ResourceAccessManager
description: |
  Custom resource definition (CRD) schema reference page for the ResourceAccessManager resource (resourceaccessmanagers.xaws.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: ResourceAccessManagerClaim
  claim_name_plural: resourceaccessmanagerclaims
  default_composition_ref: resource-access-manager
  enforced_composition_ref: resource-access-manager
  name_camelcase: ResourceAccessManager
  name_plural: resourceaccessmanagers
  name_singular: resourceaccessmanager
  short_names:
    - ram
  group: xaws.crossplane.giantswarm.io
  technical_name: resourceaccessmanagers.xaws.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - crossplane
    - ram
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/resourceaccessmanagers.xaws.crossplane.giantswarm.io/
technical_name: resourceaccessmanagers.xaws.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# ResourceAccessManager


<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">resourceaccessmanagers.xaws.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">ResourceAccessManagerClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">resourceaccessmanagerclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">resource-access-manager</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">resource-access-manager</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xaws.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">resourceaccessmanager</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">ram</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">resourceaccessmanagers</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

#### `.spec.allowExternalPrincipals`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If external principals are allowed to access the resource access manager.

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

#### `.spec.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The name of the resource access manager.

#### `.spec.permissions`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The permissions to associate with the resource access manager.

#### `.spec.permissions[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.principals`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of principals to associate with the resource access manager.

#### `.spec.principals[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.principals[*].crossOrg`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a cross-org principal.

#### `.spec.principals[*].principal`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The principal to associate with the resource access manager.

Possible values are AWS Account ID, AWS Organization ID, or AWS organizations.

#### `.spec.principals[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Provider config for accepting the share

#### `.spec.principals[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.principals[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.principals[*].providerConfigRef.policy.resolution`

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

#### `.spec.principals[*].providerConfigRef.policy.resolve`

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

The region in which the resource should be created.

#### `.spec.resources`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of resources to associate with the resource access manager.

#### `.spec.resources[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

The tags to associate with the resource access manager.

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

#### `.status.arn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ARN of the resource access manager.

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

#### `.status.id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the resource access manager.

#### `.status.ready`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is the resource access manager ready
