---
title: PeeredVpcNetwork CRD schema reference (group xnetworks.crossplane.giantswarm.io)
linkTitle: PeeredVpcNetwork
description: |
  PeeredVpcNetwork defines the desired state of a VPC.
  
  
  This composition can be used to create an *n-dimensional* VPC with optional
  peering to other VPCs.
  
  
  A claim made against this composition will result in the creation of a VPC
  with a number of subnets grouped into sets across *n* availability zones.
  
  
  If VPC Peering is enabled, the VPC will be peered with the VPCs specified in
  the claim under the `spec.peering.remoteVpcs` field.
  
  
  Up to 5 CIDR ranges can be specified and these are done via the
  `spec.subnetsets.cidrs` field, where the first entry in the list is the
  default VPC CIDR and all subsequent entries are attached as additional
  VPC CIDRs.
weight: 100
crd:
  claim_name: PeeredVpcNetworkClaim
  claim_name_plural: peeredvpcnetworkclaims
  default_composition_ref: peered-vpc-network
  enforced_composition_ref: peered-vpc-network
  name_camelcase: PeeredVpcNetwork
  name_plural: peeredvpcnetworks
  name_singular: peeredvpcnetwork
  short_names:
    - pvpc
  group: xnetworks.crossplane.giantswarm.io
  technical_name: peeredvpcnetworks.xnetworks.crossplane.giantswarm.io
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
  - /reference/cp-k8s-api/peeredvpcnetworks.xnetworks.crossplane.giantswarm.io/
technical_name: peeredvpcnetworks.xnetworks.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# PeeredVpcNetwork


PeeredVpcNetwork defines the desired state of a VPC.


This composition can be used to create an *n-dimensional* VPC with optional
peering to other VPCs.


A claim made against this composition will result in the creation of a VPC
with a number of subnets grouped into sets across *n* availability zones.


If VPC Peering is enabled, the VPC will be peered with the VPCs specified in
the claim under the `spec.peering.remoteVpcs` field.


Up to 5 CIDR ranges can be specified and these are done via the
`spec.subnetsets.cidrs` field, where the first entry in the list is the
default VPC CIDR and all subsequent entries are attached as additional
VPC CIDRs.
<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">peeredvpcnetworks.xnetworks.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">PeeredVpcNetworkClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">peeredvpcnetworkclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">peered-vpc-network</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">peered-vpc-network</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xnetworks.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">peeredvpcnetwork</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">
  <ul>
  
  <li>pvpc</li>
  
</dd>

<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">peeredvpcnetworks</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>



## Version `v1alpha1`


### Spec Properties

#### `.spec.availabilityZones`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|3|
|Max Items|3|


AvailabilityZones is a list of availability zones in the region to be
  used for this VPC. This should be a list of single character strings

#### `.spec.availabilityZones[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|
|Validation|`^[a-z]$`|


A single character representation of the short name of an availability zone.
  For example, "a" for "eu-west-1a".

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

#### `.spec.peering`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Peering is the VPC to peer with.

#### `.spec.peering.allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


AllowPublic specifies if the VPC peering connections should be allowed to
  be linked to the public subnets
  Defaults to false

#### `.spec.peering.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Enabled specifies if the VPC peering connections should be enabled for
  this VPC.
  Defaults to false

#### `.spec.peering.groupBy`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


GroupBy specifies the key to group the remote subnets by

#### `.spec.peering.remoteVpcs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|125|


RemoteVpcs is a list of VPCs to peer with.

#### `.spec.peering.remoteVpcs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


VpcPeer defines the parameters for peering with a VPC.

#### `.spec.peering.remoteVpcs[*].allowPublic`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|


Disabled specifies if the peering connection should be disabled.
  Defaults to true

#### `.spec.peering.remoteVpcs[*].excludeFromLocalPeering`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


ExcludeFromLocalPeering specifies the indexes of subnetsets for this VPC to
  exclude from routing to the peering connection

#### `.spec.peering.remoteVpcs[*].excludeFromLocalPeering.private`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering

#### `.spec.peering.remoteVpcs[*].excludeFromLocalPeering.private[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.peering.remoteVpcs[*].excludeFromLocalPeering.public`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering

#### `.spec.peering.remoteVpcs[*].excludeFromLocalPeering.public[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.peering.remoteVpcs[*].excludeFromRemotePeering`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


ExcludeFromRemotePeering specifies the indexes of subnetsets for the remote
  VPC to exclude from routing to the peering connection. If emmpty, all
  subnetsets will be included by default

#### `.spec.peering.remoteVpcs[*].excludeFromRemotePeering[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|



#### `.spec.peering.remoteVpcs[*].excludeFromRemotePeering[*].private`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


private subnets to exclude from peering

#### `.spec.peering.remoteVpcs[*].excludeFromRemotePeering[*].private[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.peering.remoteVpcs[*].excludeFromRemotePeering[*].public`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


public subnets to exclude from peering

#### `.spec.peering.remoteVpcs[*].excludeFromRemotePeering[*].public[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.spec.peering.remoteVpcs[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|


Name specifies the name of the VPC to peer with.

#### `.spec.peering.remoteVpcs[*].providerConfigRef`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


ProviderConfigRef specifies the provider config to use for the peering
  connection.

#### `.spec.peering.remoteVpcs[*].region`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|


Region specifies the region the VPC is found in.
  
  
  If not defined, the region of the VPC will be assumed to be the same as
  the region of the peered VPC.

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


Region is the region in which the VPC will be created.

#### `.spec.subnetsets`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


PeeredSubnets defines how many public and private subnet sets to create.

#### `.spec.subnetsets.cidrs`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|1|
|Max Items|5|


A list of PeeredSubnetSets to create in the VPC
  
  
  Each VPC Cidr may be split into *n* public and *n* private subnets as long
  as there is enough room on the cidr for it to be split at that level. Any
  overflow will cause the composition to fail and this will be reflected in
  the status of the XR.
  
  
  > [!IMPORTANT]
  > There must be at least 1 entry in this set which will be used as the VPC
  > default CIDR range, and you may define a maximum of 4 additional entries.

#### `.spec.subnetsets.cidrs[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


PeeredSubnetSet defines the parameters for creating a set of subnets with the
  same mask.

#### `.spec.subnetsets.cidrs[*].prefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|


A VPC CIDR or Additional CIDR to use for the VPC. If this is the first
  entry in the list, it will be used as the default VPC CIDR, otherwise it
  will be assigned as an additional CIDR to the VPC.

#### `.spec.subnetsets.cidrs[*].private`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Private is the number of private subnets to create in this set

#### `.spec.subnetsets.cidrs[*].private.clusterNames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A list of cluster names that may add load balancers in the tagged subnet
  set. Each entry will result in the tag
  `kubernetes.io/cluster/$CLUSTER_NAME shared` being added to the subnets
  in this set.
  
  
  See [public.lbSetIndex](#specsubnetsetscidrspubliclbsetindex) and
  [private.lbSetIndex](#specsubnetsetscidrsprivatelbsetindex) for deciding
  which subnetset gets these tags.

#### `.spec.subnetsets.cidrs[*].private.clusterNames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.subnetsets.cidrs[*].private.count`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|
|Immutability|increment only|


Count is the number of subnet sets to create with this mask.
  
  
  > [!WARNING]
  > Whilst this field is not `immutable`, care should be taken to never
  > decrease its value once set as this will result in the destruction of
  > subnet sets which may fail if there are attached resources.

#### `.spec.subnetsets.cidrs[*].private.lbSetIndex`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Identifies which subnet set to use for public EKS load balancers. Subnets
  in this set will recieve either the `kubernetes.io/role/elb: 1` or
  `kubernetes.io/role/internal-elb: 1` tag depending on if these are public
  or private subnets.
  
  
  If this is not set, or set to -1 (the default value), no subnets will be
  tagged as load balancer subnets otherwise it should be the index of the
  subnet set to tag, starting from index 0.

#### `.spec.subnetsets.cidrs[*].private.mask`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Immutability|immutable|


This should be a valid CIDR or CIDR suffix (including the prefix `/`) to
  use as a mask for the subnet.
  
  
  To prevent subnets being destroyed and recreated *This field is immutable*

#### `.spec.subnetsets.cidrs[*].private.offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by

#### `.spec.subnetsets.cidrs[*].public`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |**Yes**|


Details on how to build the public subnets.
  
  
  Public subnets are subnets with a route to the internet gateway.
  
  
  > [!IMPORTANT]
  > If this is the default VPC CIDR, the first entry in the list, the
  > public subnets will be used for the NAT gateways. Setting this value to
  > 0 on the default VPC CIDR may result in the creation of fully private
  > networks with no route to the outside world.

#### `.spec.subnetsets.cidrs[*].public.clusterNames`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


A list of cluster names that may add load balancers in the tagged subnet
  set. Each entry will result in the tag
  `kubernetes.io/cluster/$CLUSTER_NAME shared` being added to the subnets
  in this set.
  
  
  See [public.lbSetIndex](#specsubnetsetscidrspubliclbsetindex) and
  [private.lbSetIndex](#specsubnetsetscidrsprivatelbsetindex) for deciding
  which subnetset gets these tags.

#### `.spec.subnetsets.cidrs[*].public.clusterNames[*]`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|



#### `.spec.subnetsets.cidrs[*].public.count`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |**Yes**|
|Immutability|increment only|


Count is the number of subnet sets to create with this mask.
  
  
  > [!WARNING]
  > Whilst this field is not `immutable`, care should be taken to never
  > decrease its value once set as this will result in the destruction of
  > subnet sets which may fail if there are attached resources.

#### `.spec.subnetsets.cidrs[*].public.lbSetIndex`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Identifies which subnet set to use for public EKS load balancers. Subnets
  in this set will recieve either the `kubernetes.io/role/elb: 1` or
  `kubernetes.io/role/internal-elb: 1` tag depending on if these are public
  or private subnets.
  
  
  If this is not set, or set to -1 (the default value), no subnets will be
  tagged as load balancer subnets otherwise it should be the index of the
  subnet set to tag, starting from index 0.

#### `.spec.subnetsets.cidrs[*].public.mask`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Immutability|immutable|


This should be a valid CIDR or CIDR suffix (including the prefix `/`) to
  use as a mask for the subnet.
  
  
  To prevent subnets being destroyed and recreated *This field is immutable*

#### `.spec.subnetsets.cidrs[*].public.offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|


Offset is the number of bits to offset the subnet mask by

#### `.spec.subnetsets.function`

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

#### `.spec.tags`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Tags is a map of additional tags to assign to the VPC.

#### `.spec.tags.cluster`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Cluster tags to apply subnets for autodiscovery of load balancers

#### `.spec.tags.common`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


common tags apoplied to all resources

#### `.spec.tags.subnet`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Subnet tags to apply to all subnetsets

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

#### `.status.calculatedCidrs`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Contains the CIDR blocks output by function-cidr

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

#### `.status.subnetBits`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |No|
|Min Items|0|
|Max Items|Unlimited|


Contains the subnet bits output by function-kcl-subnet-bits

#### `.status.subnetBits[*]`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


MultiPrefix defines an item in a list of CIDR blocks to NewBits mappings

#### `.status.subnetBits[*].newBits`

|Property |Value    |
|:--------|:--------|
|Type     |array|
|Required |**Yes**|
|Min Items|1|
|Max Items|Unlimited|


NewBits is a list of bits to allocate to the subnet

#### `.status.subnetBits[*].newBits[*]`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|



#### `.status.subnetBits[*].offset`

|Property |Value    |
|:--------|:--------|
|Type     |integer|
|Required |No|
|Default Value|0|


Offset is the number of bits to offset the subnet mask by when generating
  subnets.

#### `.status.subnetBits[*].prefix`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|
|Validation|`^([0-9]{1,3}.){3}[0-9]{1,3}/[0-9]{1,2}$`|


Prefix is a CIDR block that is used as input for CIDR calculations

#### `.status.vpcs`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|


Vpcs contains details of both the peered VPCs and the current local VPC
  The current VPC can be found at the `self` key





