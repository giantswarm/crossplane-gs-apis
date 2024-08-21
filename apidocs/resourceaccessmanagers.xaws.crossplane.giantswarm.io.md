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
  enforced_composition_ref: resouce-access-manager
  name_camelcase: ResourceAccessManager
  name_plural: resourceaccessmanagers
  name_singular: resourceaccessmanager
  short_names:
    - mpl
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
<dd class="enforcedcompositionref">resouce-access-manager</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xaws.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">resourceaccessmanager</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">mpl</dd>
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


#### `.spec.principles`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

A list of principals to associate with the resource access manager.

#### `.spec.principles[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.principles[*].principal`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The principal to associate with the resource access manager.

Possible values are AWS Account ID, AWS Organization ID, or AWS organizations.

#### `.spec.principles[*].providerConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Provider config for accepting the share

#### `.spec.principles[*].providerConfig.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.principles[*].providerConfig.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.principles[*].providerConfig.policy.resolution`

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

#### `.spec.principles[*].providerConfig.policy.resolve`

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
