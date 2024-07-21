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
    - crossplane
    - networks
    - aws
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
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">subnetsets</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



<div class="crd-schema-version">
<h2 id="v1alpha1">Version v1alpha1</h2>



<h3 id="property-details-v1alpha1">Properties</h3>


<div class="property depth-0">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec">.spec</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>
<span class="property-required">Required</span>
</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.appIndex">.spec.appIndex</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>AppIndex is the index of the application that the subnet is being created for.</p>

<p>This is used for complex applications that require multiple subnet groups
Normally leave this on the default.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.deletionPolicy">.spec.deletionPolicy</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>DeletionPolicy specifies what will happen to the underlying external
when this managed resource is deleted - either &ldquo;Delete&rdquo; or &ldquo;Orphan&rdquo; the
external resource.
This field is planned to be deprecated in favor of the ManagementPolicies
field in a future release. Currently, both could be set independently and
non-default values would be honored if the feature flag is enabled.
See the design doc for more information: <a href="https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223">https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223</a></p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.managementPolicies">.spec.managementPolicies</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">array</span>

</div>

<div class="property-description">
<p>THIS IS A BETA FIELD. It is on by default but can be opted out
through a Crossplane feature flag.
ManagementPolicies specify the array of actions Crossplane is allowed to
take on the managed and external resources.
This field is planned to replace the DeletionPolicy field in a future
release. Currently, both could be set independently and non-default
values would be honored if the feature flag is enabled. If both are
custom, the DeletionPolicy field will be ignored.
See the design doc for more information: <a href="https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223">https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223</a>
and this one: <a href="https://github.com/crossplane/crossplane/blob/444267e84783136daa93568b364a5f01228cacbe/design/one-pager-ignore-changes.md">https://github.com/crossplane/crossplane/blob/444267e84783136daa93568b364a5f01228cacbe/design/one-pager-ignore-changes.md</a></p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.managementPolicies[*]">.spec.managementPolicies[*]</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>A ManagementAction represents an action that the Crossplane controllers
can take on an external resource.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.providerConfigRef">.spec.providerConfigRef</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>ProviderConfigReference specifies how the provider that will be used to
create, observe, update, and delete this managed resource should be
configured.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.providerConfigRef.name">.spec.providerConfigRef.name</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Name of the referenced object.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.providerConfigRef.policy">.spec.providerConfigRef.policy</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Policies for referencing.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.providerConfigRef.policy.resolution">.spec.providerConfigRef.policy.resolution</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>Resolution specifies whether resolution of this reference is required.
The default is &lsquo;Required&rsquo;, which means the reconcile will fail if the
reference cannot be resolved. &lsquo;Optional&rsquo; means this reference will be
a no-op if it cannot be resolved.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.providerConfigRef.policy.resolve">.spec.providerConfigRef.policy.resolve</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>Resolve specifies when this reference should be resolved. The default
is &lsquo;IfNotPresent&rsquo;, which will attempt to resolve the reference only when
the corresponding field is not present. Use &lsquo;Always&rsquo; to resolve the
reference on every reconcile.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo">.spec.publishConnectionDetailsTo</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>PublishConnectionDetailsTo specifies the connection secret config which
contains a name, metadata and a reference to secret store config to
which any connection details for this managed resource should be written.
Connection details frequently include the endpoint, username,
and password required to connect to the managed resource.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.configRef">.spec.publishConnectionDetailsTo.configRef</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>SecretStoreConfigRef specifies which secret store config should be used
for this ConnectionSecret.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.configRef.name">.spec.publishConnectionDetailsTo.configRef.name</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Name of the referenced object.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.configRef.policy">.spec.publishConnectionDetailsTo.configRef.policy</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Policies for referencing.</p>

</div>

</div>
</div>

<div class="property depth-4">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.configRef.policy.resolution">.spec.publishConnectionDetailsTo.configRef.policy.resolution</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>Resolution specifies whether resolution of this reference is required.
The default is &lsquo;Required&rsquo;, which means the reconcile will fail if the
reference cannot be resolved. &lsquo;Optional&rsquo; means this reference will be
a no-op if it cannot be resolved.</p>

</div>

</div>
</div>

<div class="property depth-4">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.configRef.policy.resolve">.spec.publishConnectionDetailsTo.configRef.policy.resolve</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>Resolve specifies when this reference should be resolved. The default
is &lsquo;IfNotPresent&rsquo;, which will attempt to resolve the reference only when
the corresponding field is not present. Use &lsquo;Always&rsquo; to resolve the
reference on every reconcile.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.metadata">.spec.publishConnectionDetailsTo.metadata</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Metadata is the metadata for connection secret.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.metadata.annotations">.spec.publishConnectionDetailsTo.metadata.annotations</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Annotations are the annotations to be added to connection secret.
- For Kubernetes secrets, this will be used as &ldquo;metadata.annotations&rdquo;.
- It is up to Secret Store implementation for others store types.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.metadata.labels">.spec.publishConnectionDetailsTo.metadata.labels</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Labels are the labels/tags to be added to connection secret.
- For Kubernetes secrets, this will be used as &ldquo;metadata.labels&rdquo;.
- It is up to Secret Store implementation for others store types.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.metadata.type">.spec.publishConnectionDetailsTo.metadata.type</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>Type is the SecretType for the connection secret.
- Only valid for Kubernetes Secret Stores.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.publishConnectionDetailsTo.name">.spec.publishConnectionDetailsTo.name</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Name is the name of the connection secret.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.region">.spec.region</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Region is the region you&rsquo;d like the VPC to be created in.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.subnets">.spec.subnets</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Subnets is a map of availability zones and subnet cidr blocks.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.tags">.spec.tags</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Tags is a set of tags to apply to resources in the subnetset</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.tags.all">.spec.tags.all</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>All is a map of tags to apply to all resources in the subnetset.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.tags.subnet">.spec.tags.subnet</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Subnet is a map of tags to apply only to the subnet resources</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.type">.spec.type</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>Type is the type of VPC Subnet to create.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.vpcId">.spec.vpcId</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>VpcId is the unique identifier for the VPC.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.writeConnectionSecretToRef">.spec.writeConnectionSecretToRef</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>WriteConnectionSecretToReference specifies the namespace and name of a
Secret to which any connection details for this managed resource should
be written. Connection details frequently include the endpoint, username,
and password required to connect to the managed resource.
This field is planned to be replaced in a future release in favor of
PublishConnectionDetailsTo. Currently, both could be set independently
and connection details would be published to both without affecting
each other.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.writeConnectionSecretToRef.name">.spec.writeConnectionSecretToRef.name</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Name of the secret.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.spec.writeConnectionSecretToRef.namespace">.spec.writeConnectionSecretToRef.namespace</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Namespace of the secret.</p>

</div>

</div>
</div>

<div class="property depth-0">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status">.status</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions">.status.conditions</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">array</span>

</div>

<div class="property-description">
<p>Conditions of the resource.</p>

</div>

</div>
</div>

<div class="property depth-2">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions[*]">.status.conditions[*]</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>A Condition that may apply to a resource.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions[*].lastTransitionTime">.status.conditions[*].lastTransitionTime</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>LastTransitionTime is the last time this condition transitioned from one
status to another.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions[*].message">.status.conditions[*].message</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>A Message containing details about this condition&rsquo;s last transition from
one status to another, if any.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions[*].reason">.status.conditions[*].reason</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>A Reason for this condition&rsquo;s last transition from one status to another.</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions[*].status">.status.conditions[*].status</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Status of this condition; is it currently True, False, or Unknown?</p>

</div>

</div>
</div>

<div class="property depth-3">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.conditions[*].type">.status.conditions[*].type</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>
<span class="property-required">Required</span>
</div>

<div class="property-description">
<p>Type of this condition. At most one of each condition type may apply to
a resource at any point in time.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.routeTables">.status.routeTables</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>RouteTables is a map of route tables discovered by the composite.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.subnets">.status.subnets</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">object</span>

</div>

<div class="property-description">
<p>Subnets is a map of subnets discovered by the composite.</p>

</div>

</div>
</div>

<div class="property depth-1">
<div class="property-header">
<h3 class="property-path" id="v1alpha1-.status.vpcId">.status.vpcId</h3>
</div>
<div class="property-body">
<div class="property-meta">
<span class="property-type">string</span>

</div>

<div class="property-description">
<p>VpcID is the unique identifier for the VPC.</p>

</div>

</div>
</div>





</div>



