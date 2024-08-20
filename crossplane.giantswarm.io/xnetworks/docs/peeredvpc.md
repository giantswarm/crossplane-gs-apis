# PeeredVpcNetwork

![peeredvpc](./peeredvpc.png)

The `PeeredVpcNetwork` composition builds an n-dimensional VPC network with
peering connections where requested.

The composition creates a VPC network in a single region, with subnets split
into `SubnetSets` where each `SubnetSet` contains *n* subnets, route tables and
route table associations spread across *n* availability zones.

> [!IMPORTANT]
> The created VPC will have the same name as the claim that creates it,
> therefore it is important to properly consider how you will name your
> resources prior to applying the claim as claims are namespace scoped and may
> conflict with the names of other applications in the cluster.

By default, this VPC will be created without any security groups or security
group rules and the outbound (egress) rule is removed from the default VPC
security group.

It is up to the applications deployed into the VPC to define any security groups
and security group rules they require.

## Providers and functions

This composition relies on the following providers and functions:

### Providers

- [`upbound/provider-aws-ec2`] Used to provision VPC level resources

### Functions

- [`function-auto-ready`] A Crossplane Contrib composition function that waits
  for resources to become ready then updates the READY state of the XR.
- [`function-cidr`]. Martin Proffitts fork of `upbound/function-cidr`, a
  composition function that calculates CIDR blocks for a given network size and
  number of subnets. The extended version allows the provision of slicing
  any number of CIDR blocks into smaller blocks by specifying the mask to use.
- [`function-kcl`] The main [`KCL`] language function that provides the core
  functionality for the composition.
- [`function-network-discovery`]. A GiantSwarm composition function that discovers
  network topology for one or more VPCs specified by name.
- [`function-patch-and-transform`] A Crossplane Contrib composition function that
  patches and transforms resources.

## Configuration parameters

Configuration parameters are documented as part of the API documentation here:
[apidocs/peeredvpcnetworks.xnetworks.crossplane.giantswarm.io](../../../apidocs/peeredvpcnetworks.xnetworks.crossplane.giantswarm.io.md)

Overall, the VPC can be configured in multiple different ways and include various
combinations of VPC peering and/or transit gateway depending on your requirements.

You may also specify Resource Access Manager to be enabled which allows the
transit gateway and associated remote managed prefix lists to be shared with a
remote account.

If, when using the Network Discovery function, any VPCs have a different owner
than the current account, RAM will be automatically enabled if a transit gateway
is enabled for the current VPC.

## Examples

The following examples are provided as part of this composition.

> [!TIP]
> Each of these examples is also tested with [`localstack`] which is used
> heavily during development of these compositions by the author.

These require the `PeeredVpcNetwork` composition be installed to your cluster.
If you have not already done so, follow the instructions on installing the
composition and all its pre-requisites.

### 1. Basic, No Peering

![basic-no-peering](./basic-no-peerimg.png)

#### [examples/basic-no-peering](../examples/basic-no-peering.yaml)

This claim will create a basic VPC network in the `eu-central-1` region with a
single default cidr prefix of `10.18.0.0/24` consisting of 2 public subnet sets
with mask `/28` and 2 private subnet sets also on mask `/28` across 3
availability zones.

### 2. Basic, Peered

![basic-peered](./basic-peered.png)

#### [examples/basic-peered](../examples/basic-peered.yaml)

> [!NOTE]
> This example requires that the `basic-no-peering` claim has already been applied
to your account.

This claim will create a second VPC with peering across to the `basic-no-peering`
VPC created as part of example 1.

Like the example above, this VPC will be split across 3 availability zones

- 1 public subnet set with a `/27`
- 3 private subnet sets (9 subnets), each on `/28`

Peering will be initiated to the basic-no-peering VPC on both public and private
subnets.

### 3. Complex Peered

#### [examples/complex-peered](../examples/complex-peered.yaml)

## Definition

The definition can be found at [peeredvpcnetwork_types.go](../v1alpha1/peeredvpcnetwork_types.go)

For a YAML version of this file that can be applied to a cluster, see
[peeredvpcnetworks.yaml](../package/xrds/xnetworks.crossplane.giantswarm.io_peeredvpcnetworks.yaml)

## Composition

The `go` code version of the composition can be found at
[../compositions/peeredvpc](../compositions/peeredvpc)

The composition is made up of multiple segments:

- **Network discovery**. Find information about any VPCs requested for peering.
- **Subnet bits** - KCL language script to calculate subnet bits from CIDR masks.
  Uses [subnets.k](../compositions/peeredvpc/templates/subnets.k)
- **CIDR splitting** using [`function-cidr`]
- **Create Resources**. A KCL script to create complex and repetitive resources.
  Uses [resources.k](../compositions/peeredvpc/templates/resources.k)
- **Dynamic Patching** with KCL for patches that cannot be done with
  [function-patch-and-transform].
  Uses [patching.k](../compositions/peeredvpc/templates/patching.k)
- **Static resource creation** and patching with `function-patch-and-transform`
  For single resources that contain minimal or no complexity.
- **Auto ready**: Mark the XR as ready once all resources are ready.

SubnetSets are created using the [SubnetSet] composition

For a YAML version of the composition that can be applied to the cluster see
[peered-vpc-network.yaml](../package/compositions/peered-vpc-network.yaml)

[`upbound/provider-aws-ec2`]: https://marketplace.upbound.io/providers/upbound/provider-aws-ec2
[`function-network-discovery`]: https://github.com/giantswarm/crossplane-fn-network-discovery
[`function-cidr`]: https://github.com/mproffitt/function-cidr/
[`function-kcl`]: https://github.com/crossplane-contrib/function-kcl
[`function-patch-and-transform`]: https://github.com/crossplane-contrib/function-patch-and-transform
[`function-auto-ready`]: https://github.com/crossplane-contrib/function-auto-ready
[`KCL`]: https://www.kcl-lang.io/
[SubnetSet]: ./subnetset.md
[`localstack`]: https://www.localstack.cloud/
