# SubnetSet

![subnetset](./subnetset.png)

> [!NOTE]
> This composition is not meant to be used directly but is used as part of the
> [peeredvpc](./peeredvpc.md) composition.

The purpose of this composition is to create a subnet, route table and route
table associations for each availability zone requested.

The composition does not manage routes which are instead handled by the VPC
composition.

## Providers and functions

This composition relies on the following providers and functions:

### Providers

- [`upbound/provider-aws-ec2`] Used to provision VPC level resources

### Functions

- [`crossplane-contrib/function-auto-ready`] Used to mark the XR as ready once
  all resources are ready.
- [`crossplane-contrib/function-kcl`] Used to dynamically provision managed
  resources

## Configuration parameters

Configuration parameters are documented as part of the API documentation here:
[apidocs/subnetsets.xnetworks.crossplane.giantswarm.io](../../../apidocs/subnetsets.xnetworks.crossplane.giantswarm.io.md)

## Examples

For examples on how to use this composition, please refer to
[PeeredVpcNetwork > Examples](./peeredvpc.md#examples)

[`upbound/provider-aws-ec2`]: https://marketplace.upbound.io/providers/upbound/provider-aws-ec2
[`crossplane-contrib/function-auto-ready`]: https://marketplace.upbound.io/functions/crossplane-contrib/function-auto-ready
[`crossplane-contrib/function-kcl`]: https://marketplace.upbound.io/functions/crossplane-contrib/function-kcl
