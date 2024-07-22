---
title: SubnetSet CRD schema reference (group xnetworks.crossplane.giantswarm.io)
linkTitle: SubnetSet
description: |
  Custom resource definition (CRD) schema reference page for the SubnetSet resource (subnetsets.xnetworks.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: SubnetSetClaim
  claim_name_plural: subnetsetclaims
  default_composition_ref: subnetset
  enforced_composition_ref: subnetset
  name_camelcase: SubnetSet
  name_plural: subnetsets
  name_singular: subnetset
  short_names:
    - sn
  group: xnetworks.crossplane.giantswarm.io
  technical_name: subnetsets.xnetworks.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - crossplane
    - networks
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/subnetsets.xnetworks.crossplane.giantswarm.io/
technical_name: subnetsets.xnetworks.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# SubnetSet

<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">subnetsets.xnetworks.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">SubnetSetClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">subnetsetclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">subnetset</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">subnetset</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xnetworks.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">subnetset</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">
  <ul>
  
  <li>sn</li>
  
</dd>

<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">subnetsets</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



## Version `v1alpha1`


### Spec Properties
<h4>`.spec.appIndex`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


AppIndex is the index of the application that the subnet is being created for.
  
  
  This is used for complex applications that require multiple subnet groups
  Normally leave this on the default.
<h4>`.spec.deletionPolicy`</h4>

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
<h4>`.spec.managementPolicies`</h4>

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
<h4>`.spec.managementPolicies[*]`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


A ManagementAction represents an action that the Crossplane controllers
  can take on an external resource.
<h4>`.spec.providerConfigRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


ProviderConfigReference specifies how the provider that will be used to
  create, observe, update, and delete this managed resource should be
  configured.
<h4>`.spec.providerConfigRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>`.spec.providerConfigRef.policy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>`.spec.providerConfigRef.policy.resolution`</h4>

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
<h4>`.spec.providerConfigRef.policy.resolve`</h4>

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
<h4>`.spec.publishConnectionDetailsTo`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PublishConnectionDetailsTo specifies the connection secret config which
  contains a name, metadata and a reference to secret store config to
  which any connection details for this managed resource should be written.
  Connection details frequently include the endpoint, username,
  and password required to connect to the managed resource.
<h4>`.spec.publishConnectionDetailsTo.configRef`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|
|Default Value|{name:default}|


SecretStoreConfigRef specifies which secret store config should be used
  for this ConnectionSecret.
<h4>`.spec.publishConnectionDetailsTo.configRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the referenced object.
<h4>`.spec.publishConnectionDetailsTo.configRef.policy`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Policies for referencing.
<h4>`.spec.publishConnectionDetailsTo.configRef.policy.resolution`</h4>

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
<h4>`.spec.publishConnectionDetailsTo.configRef.policy.resolve`</h4>

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
<h4>`.spec.publishConnectionDetailsTo.metadata`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Metadata is the metadata for connection secret.
<h4>`.spec.publishConnectionDetailsTo.metadata.annotations`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Annotations are the annotations to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.annotations".
  - It is up to Secret Store implementation for others store types.
<h4>`.spec.publishConnectionDetailsTo.metadata.labels`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Labels are the labels/tags to be added to connection secret.
  - For Kubernetes secrets, this will be used as "metadata.labels".
  - It is up to Secret Store implementation for others store types.
<h4>`.spec.publishConnectionDetailsTo.metadata.type`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Type is the SecretType for the connection secret.
  - Only valid for Kubernetes Secret Stores.
<h4>`.spec.publishConnectionDetailsTo.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name is the name of the connection secret.
<h4>`.spec.region`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^[a-z]{2}-[a-z]&#43;-[0-9]$`|


Region is the region you'd like the VPC to be created in.
<h4>`.spec.subnets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Subnets is a map of availability zones and subnet cidr blocks.
<h4>`.spec.tags`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a set of tags to apply to resources in the subnetset
<h4>`.spec.tags.all`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


All is a map of tags to apply to all resources in the subnetset.
<h4>`.spec.tags.subnet`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Subnet is a map of tags to apply only to the subnet resources
<h4>`.spec.type`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|public|


Allowed Values:
- public
- private

Type is the type of VPC Subnet to create.
<h4>`.spec.vpcId`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^vpc-[a-z0-9]{8,17}$`|


VpcId is the unique identifier for the VPC.
<h4>`.spec.writeConnectionSecretToRef`</h4>

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
<h4>`.spec.writeConnectionSecretToRef.name`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name of the secret.
<h4>`.spec.writeConnectionSecretToRef.namespace`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Namespace of the secret.

### Status Properties
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
<h4>`.status.routeTables`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


RouteTables is a map of route tables discovered by the composite.
<h4>`.status.subnets`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Subnets is a map of subnets discovered by the composite.
<h4>`.status.vpcId`</h4>

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^vpc-[a-z0-9]{8,17}$`|


VpcID is the unique identifier for the VPC.





