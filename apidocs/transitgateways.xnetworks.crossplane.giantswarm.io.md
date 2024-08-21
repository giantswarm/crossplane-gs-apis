---
title: TransitGateway CRD schema reference (group xnetworks.crossplane.giantswarm.io)
linkTitle: TransitGateway
description: |
  Custom resource definition (CRD) schema reference page for the TransitGateway resource (transitgateways.xnetworks.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: TransitGatewayClaim
  claim_name_plural: transitgatewayclaims
  default_composition_ref: transitgateway
  enforced_composition_ref: transitgateway
  name_camelcase: TransitGateway
  name_plural: transitgateways
  name_singular: transitgateway
  short_names:
    - tgw
  group: xnetworks.crossplane.giantswarm.io
  technical_name: transitgateways.xnetworks.crossplane.giantswarm.io
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
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/transitgateways.xnetworks.crossplane.giantswarm.io/
technical_name: transitgateways.xnetworks.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# TransitGateway


<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">transitgateways.xnetworks.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">TransitGatewayClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">transitgatewayclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">transitgateway</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">transitgateway</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xnetworks.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">transitgateway</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">tgw</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">transitgateways</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

#### `.spec.amazonSideAsn`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

Amazon side ASN. Private autonomous system number (ASN) for
the Amazon side of a BGP session.

#### `.spec.applianceModeSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Appliance mode support. Indicates whether appliance mode support is enabled.

#### `.spec.autoAcceptSharedAttachments`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Auto accept shared attachments. Indicates whether there is automatic
acceptance of attachment requests.

#### `.spec.createPolicyTable`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Create the policy table.

#### `.spec.defaultRouteTableAssociation`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Default route table association. Indicates whether resource attachments
are automatically associated with the default association route table.

#### `.spec.defaultRouteTablePropagation`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Default route table propagation. Indicates whether resource attachments
automatically propagate routes to the default propagation route table.

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

#### `.spec.dnsSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Dns support. Indicates whether DNS support is enabled.

#### `.spec.ipv6Support`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

If IPv6 support is enabled for the transit gateway.

#### `.spec.localVpc`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Contains details about the local VPC (Where the TGW will be built)

#### `.spec.localVpc.cidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Cidr blocks for the VPC

#### `.spec.localVpc.cidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

Cidr is a string type that represents a CIDR block.

#### `.spec.localVpc.prefixLists`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Prefix lists for the VPC

#### `.spec.localVpc.prefixLists[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.localVpc.prefixLists[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.localVpc.prefixLists[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.localVpc.prefixLists[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.localVpc.prefixLists[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.localVpc.prefixLists[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.localVpc.prefixLists[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.localVpc.prefixLists[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.localVpc.prefixLists[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.localVpc.prefixLists[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.localVpc.region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region this VPC is located in

#### `.spec.localVpc.routeTableIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Route table ids in the VPC

#### `.spec.localVpc.routeTableIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^rtb-[a-z0-9]{8,17}$`|

RouteTableId is a string type that represents the unique identifier for a
route table.

#### `.spec.localVpc.subnetIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SubnetIds in the VPC

#### `.spec.localVpc.subnetIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^subnet-[a-z0-9]{8,17}$`|

SubnetId is a string type that represents the unique identifier for a subnet.

#### `.spec.localVpc.vpcId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^vpc-[a-z0-9]{8,17}$`|

The ID of the VPC

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

#### `.spec.multicastSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Multicast support. Indicates whether multicast is enabled on the transit gateway.

Currently unused in this composition

#### `.spec.peers`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Peers defines other transit gateways that this transit gateway
should peer with

#### `.spec.peers[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.peers[*].accountId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The Account ID this VPC is associated with

#### `.spec.peers[*].dynamicRouting`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is Dynamic routing support enabled on this peer

#### `.spec.peers[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The ID of the gateway to peer with

#### `.spec.peers[*].managedPrefixList`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

ManagedPrefixList contains CIDRs for networks that can be traversed
via this transit gateway.

#### `.spec.peers[*].managedPrefixList[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.peers[*].managedPrefixList[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.peers[*].managedPrefixList[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.peers[*].managedPrefixList[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.peers[*].managedPrefixList[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.peers[*].managedPrefixList[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.peers[*].managedPrefixList[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.peers[*].managedPrefixList[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.peers[*].managedPrefixList[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.peers[*].managedPrefixList[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.peers[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The name of the peer

#### `.spec.peers[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProviderConfigRef references a ProviderConfig used to create this
resource

If not provided, will fall back to the top-level ProviderConfigRef

Required for cross account transit gateway peering

#### `.spec.peers[*].providerConfigRef.name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name of the referenced object.

#### `.spec.peers[*].providerConfigRef.policy`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Policies for referencing.

#### `.spec.peers[*].providerConfigRef.policy.resolution`

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

#### `.spec.peers[*].providerConfigRef.policy.resolve`

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

#### `.spec.peers[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Region the remote transit gateway is located in

#### `.spec.peers[*].routeTableId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The ID of the remote route table

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

#### `.spec.ram`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Resource Access Management (RAM)

#### `.spec.ram.allowExternalPrincipals`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Do we allow external principles with this ram

#### `.spec.ram.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is RAM enabled

#### `.spec.ram.principals`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Principals that are allowed to access the resource

#### `.spec.ram.principals[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


#### `.spec.remoteVpcs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Contains details about the remote VPCs

#### `.spec.remoteVpcs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.remoteVpcs[*].cidrBlocks`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Cidr blocks for the VPC

#### `.spec.remoteVpcs[*].cidrBlocks[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

Cidr is a string type that represents a CIDR block.

#### `.spec.remoteVpcs[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

The name of the VPC

#### `.spec.remoteVpcs[*].prefixLists`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Prefix lists for the VPC

#### `.spec.remoteVpcs[*].prefixLists[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.remoteVpcs[*].prefixLists[*].addressFamily`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Default Value|IPv4|

Allowed Values:

- IPv4
- IPv6

The address family (ipv4 or ipv6) for the prefix list.

#### `.spec.remoteVpcs[*].prefixLists[*].blackhole`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

If this is a blackhole route

#### `.spec.remoteVpcs[*].prefixLists[*].entries`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

The prefix list entries.

#### `.spec.remoteVpcs[*].prefixLists[*].entries[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


#### `.spec.remoteVpcs[*].prefixLists[*].entries[*].cidr`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|

The CIDR block for the prefix list entry.

#### `.spec.remoteVpcs[*].prefixLists[*].entries[*].description`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The description for the prefix list entry.

#### `.spec.remoteVpcs[*].prefixLists[*].id`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the prefix list.

#### `.spec.remoteVpcs[*].prefixLists[*].maxEntries`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|

The maximum number of entries for the prefix list.

#### `.spec.remoteVpcs[*].prefixLists[*].outbound`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Outbound route

This places it in the ManagedPrefixList attached
to the outbound route table

#### `.spec.remoteVpcs[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ProviderConfigRef references a ProviderConfig used to create this
resource

If not provided, will fall back to the top-level ProviderConfigRef

Required for cross account VPCs
Should not be set for same account VPCs unless restricted by
IAM

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

Region this VPC is located in

#### `.spec.remoteVpcs[*].routeTableIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

Route table ids in the VPC

#### `.spec.remoteVpcs[*].routeTableIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^rtb-[a-z0-9]{8,17}$`|

RouteTableId is a string type that represents the unique identifier for a
route table.

#### `.spec.remoteVpcs[*].subnetIds`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|

SubnetIds in the VPC

#### `.spec.remoteVpcs[*].subnetIds[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^subnet-[a-z0-9]{8,17}$`|

SubnetId is a string type that represents the unique identifier for a subnet.

#### `.spec.remoteVpcs[*].vpcId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^vpc-[a-z0-9]{8,17}$`|

The ID of the VPC

#### `.spec.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

The tags for the transit gateway.

#### `.spec.transitGatewayDefaultRouteTableAssociation`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

TransitGatewayDefaultRouteTableAssociation. Indicates whether resource
attachments are automatically associated with the default association route table.

#### `.spec.transitGatewayDefaultRouteTablePropagation`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

TransitGatewayDefaultRouteTablePropagation. Indicates whether resource
attachments automatically propagate routes to the default propagation route table.

#### `.spec.vpnEcmpSupport`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Vpn ecmp support. Indicates whether Equal Cost Multipath Protocol support is enabled.

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

#### `.status.localAttachmentIds`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

map of local attachments

#### `.status.ramShareArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

If Resource Access Management is enabled, the ARN of the RAM share

#### `.status.ramShareId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

If Resource Access Management is enabled, the ID of the RAM share

#### `.status.ready`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is the transit gateway ready

#### `.status.remoteAttachmentIds`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

map of remote attachments

#### `.status.tgwArn`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ARN of the Transit Gateway.

#### `.status.tgwId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the Transit Gateway.

#### `.status.tgwRouteTableId`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The ID of the route table associated with the Transit Gateway.
