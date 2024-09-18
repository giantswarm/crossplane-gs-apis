---
title: RdsProvisioning CRD schema reference (group xdatabase.crossplane.giantswarm.io)
linkTitle: RdsProvisioning
description: |
  Custom resource definition (CRD) schema reference page for the RdsProvisioning resource (rdsprovisionings.xdatabase.crossplane.giantswarm.io), as part of the Giant Swarm Management API documentation.
weight: 100
crd:
  claim_name: RdsProvisioningClaim
  claim_name_plural: rdsprovisioningclaims
  default_composition_ref: rds-provisioning
  enforced_composition_ref: rds-provisioning
  name_camelcase: RdsProvisioning
  name_plural: rdsprovisionings
  name_singular: rdsprovisioning
  short_names:
    - rdsprv
  group: xdatabase.crossplane.giantswarm.io
  technical_name: rdsprovisionings.xdatabase.crossplane.giantswarm.io
  scope: 
  source_repository: https://github.com/giantswarm/crossplane-gs-apis
  source_repository_ref: main
  versions:
    - v1alpha1
  topics:
    - aws
    - crossplane
    - database
    - rds
layout: crd
owner:
  - https://github.com/orgs/giantswarm/teams/team-honeybadger
aliases:
  - /reference/cp-k8s-api/rdsprovisionings.xdatabase.crossplane.giantswarm.io/
technical_name: rdsprovisionings.xdatabase.crossplane.giantswarm.io
source_repository: https://github.com/giantswarm/crossplane-gs-apis
source_repository_ref: main
---

# RdsProvisioning


<dl class="crd-meta">
<dt class="fullname">Full name:</dt>
<dd class="fullname">rdsprovisionings.xdatabase.crossplane.giantswarm.io</dd>
<dt class="claimname">Claim name:</dt>
<dd class="claimname">RdsProvisioningClaim</dd>
<dt class="claimnamesplural">Claim plural names:</dt>
<dd class="claimnamesplural">rdsprovisioningclaims</dd>
<dt class="defaultcompositionref">Default composition ref:</dt>
<dd class="defaultcompositionref">rds-provisioning</dd>
<dt class="enforcedcompositionref">Enforced composition ref:</dt>
<dd class="enforcedcompositionref">rds-provisioning</dd>
<dt class="groupname">Group:</dt>
<dd class="groupname">xdatabase.crossplane.giantswarm.io</dd>
<dt class="singularname">Singular name:</dt>
<dd class="singularname">rdsprovisioning</dd>
<dt class="shortnames">Short Names</dt>
<dd class="shortnames">rdsprv</dd>
<dt class="pluralname">Plural name:</dt>
<dd class="pluralname">rdsprovisionings</dd>
<dt class="scope">Scope:</dt>
<dd class="scope"></dd>
<dt class="versions">Versions:</dt>
<dd class="versions"><a class="version" href="#version-v1alpha1" title="Show schema for version v1alpha1">v1alpha1</a></dd>
</dl>

## Version `v1alpha1`

### Spec Properties

#### `.spec.connectionSecretName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the connection secret to use for the RDS instance

Required if `providerConfigRef` is not provided, ignored otherwise
Must exist in the same namespace as the provisioning claim

If this value is provided, the composition will attempt to create a
provider config using the engine specific providerconfig spec

#### `.spec.databases`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Databases is a map of databases to create.

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

Determines if the RDS provisioning should be enabled

#### `.spec.engine`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Allowed Values:

- postgres
- mysql
- aurora-mysql
- aurora-postgresql
- mariadb

The type of database engine being provisioned

#### `.spec.eso`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

ESO configuration

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

#### `.spec.eso.stores[*].name`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |**Yes**|

Name is the name of the secret store.

#### `.spec.eso.tenantCluster`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Tenant Cluster details

#### `.spec.eso.tenantCluster.apiServerEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The API endpoint for the tenant cluster.

#### `.spec.eso.tenantCluster.clusterName`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the tenant cluster.

#### `.spec.eso.tenantCluster.enabled`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Enabled Whether or not to enable `external-secrets-operator` object
deployments using `provider-kubernetes.

#### `.spec.eso.tenantCluster.namespace`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The namespace on the tenant cluster to deploy secrets to. If not set
will default to the `default` namespace.

#### `.spec.kubernetesProviderConfig`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

KubernetesProviderConfig is the provider config for the Kubernetes provider.

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

#### `.spec.readerEndpoint`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

Reader Endpoint is the endpoint to use for read operations

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

#### `.status.connectionSecrets`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

Connection secrets created for the databases

#### `.status.connectionSecrets.app`

|Property |Value    |
|:--------|:--------|
|Type     |string|
|Required |No|

The name of the secret created specifically for the app

#### `.status.connectionSecrets.users`

|Property |Value    |
|:--------|:--------|
|Type     |object|
|Required |No|

A map of secret names created for users

#### `.status.ready`

|Property |Value    |
|:--------|:--------|
|Type     |boolean|
|Required |No|

Is the provisioning ready
