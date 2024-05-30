# PeeredVpcNetwork

![peeredvpc](./peeredvpc.png)

The `PeeredVpcNetwork` composition builds an n-dimensional VPC network with
peering connections where requested.

The composition creates a VPC network in a single region, with subnets split
into `SubnetSets` where each `SubnetSet` contains 3 subnets, route tables and
route table associations spread across 3 availability zones.

The composition utilises a number of composition functions which must be
installed into the cluster prior to applying a claim.

- [`function-network-discovery`]. A GiantSwarm composition function that discovers
  network topology for one or more VPCs specified by name.
- [`function-cidr`]. Martin Proffitts fork of `upbound/function-cidr`, a
  composition function that calculates CIDR blocks for a given network size and
  number of subnets. The extended version allows the provision of slicing
  any number of CIDR blocks into smaller blocks by specifying the mask to use.
- [`function-kcl`] The main [`KCL`] language function that provides the core
  functionality for the composition.
- [`function-patch-and-transform`] A Crossplane Contrib composition function that
  patches and transforms resources.
- [`function-auto-ready`] A Crossplane Contrib composition function that waits
  for resources to become ready then updates the READY state of the XR.

Additionally, the sub-composition `SubnetSet` requires the following functions:

- [`function-go-templating`] a Crossplane Contrib composition function that
  provides Go templating functionality.

To build resources, only the [`upbound/aws-provider-ec2`] provider is required.

## Claim parameters

In addition to the crossplane parameters, the claim requires the following:

- `region` The name of the region in which to create the VPC
- `peering` Details about peering connections that need to be created
  - `allowPublic` Allow peering connections from the public subnets in the local
    vpc. Default `true`
  - `enabled` Whether to enable or disable peering defdault: `true`
  - `remoteVpcs` A list of remote VPCs to create peering connections to
    - `name` The name of the VPC
    - `region` The region the VPC is in
    - `providerConfigRef` The name of the `ProviderConfig` to use for setting up
      the peering connection - defaults to the claim provider config
    - `allowPublic` If true, will set up routes to the public subnets in addition
      to private subnets. Default `true`

Example:

```yaml
peering:
  enabled: true
  remoteVpcs:
  - name: my-app-vpc
    allowPublic: true
  - name: my-other-app
    allowPublic: false
```

- `subnetsets` specify how to slice the VPC Cidr blocks
  - `availabilityZones` a list of single characters identifying the availability
    zones to build the VPC resources in
  - `cidrs` A list of prefixes and details on how to slice them. The first entry
    in the list is used as the primary VPC CIDR, with any additional being
    assigned as additional CIDR blocks to the VPC. A maximum of 5 entries may be
    entered here.
    - `prefix` The CIDR block to give to the VPC
    - `public` How to create public subnets. These will have a route to the
      internet assigned to the subnet route tables
      - `mask` The CIDR mask to use. This must fit inside the `prefix` above and
        should be specified as a string such as `"/27"` with the `/` being
        optional but preferred.
      - `count` How many times to repeat the group.
        > [!WARNING]
        > Count is multiplied by the number of availability zones (3) therefore
        > care must be taken to ensure that there is room on the VPC prefix for
        > it to be split successfully.
      - `lbSetIndex` The set index at which tags are added for AWS Kubernetes
        load balancers. This is 0 indexed (e.g. the first item has index 0) and
        has a default of `-1` which instructs the composition to not add the tags
      - `offset` Where to start the range from. Should be specified as a CIDR
        mask.

Example:

```yaml
- prefix: '10.16.0.0/24'
  public:
    mask: /27
    count: 1
    lbSetIndex: 0
  private:
    mask: /28
    count: 3
    lbSetIndex: 2
- prefix: '10.18.0.0/23'
  public:
    mask: ""
    count: 0
    lbSetIndex: 0
  private:
    mask: /27
    count: 3
    lbSetIndex: 0
    offset: /25
```

- `tags` Tags to apply to resources in the VPC
  - `common` These are tags that should be applied to all resources
  - `subnets` Specific tags to add to the subnets

[`function-network-discovery`]: https://github.com/giantswarm/crossplane-fn-network-discovery
[`function-cidr`]: https://github.com/mproffitt/function-cidr/
[`function-kcl`]: https://github.com/crossplane-contrib/function-kcl
[`function-patch-and-transform`]: https://github.com/crossplane-contrib/function-patch-and-transform
[`function-auto-ready`]: https://github.com/crossplane-contrib/function-auto-ready
[`function-go-templating`]: https://github.com/crossplane-contrib/function-go-templating
[`KCL`]: https://www.kcl-lang.io/
[`upbound/aws-provider-ec2`]: https://marketplace.upbound.io/providers/upbound/provider-aws-ec2

## Definition

The definition can be found at [peeredvpcnetwork_types.go](../v1alpha1/peeredvpcnetwork_types.go)

For a YAML version of this file that can be applied to a cluster, see
[peeredvpcnetworks.yaml](../package/xrds/xnetworks.crossplane.giantswarm.io_peeredvpcnetworks.yaml)

## Composition

The `go` code version of the composition can be found at [../compositions/peeredvpc](../compositions/peeredvpc)

The composition is made up of 5 main parts:

- Network discovery. Finds information about any VPCs requested for peering
- subnet-bits - KCL language script to calculates subnet bits from CIDR masks.
  Uses [subnets.k](../compositions/peeredvpc/templates/subnets.k)
- CIDR splitting using [`function-cidr`]
- Create Resources. A KCL script to create complex and repetative resources.
  Uses [resources.k](../compositions/peeredvpc/templates/resources.k)
- Dynamic Patching with KCL for patches that cannot be done with
  [function-patch-and-transform].
  Uses [patching.k](../compositions/peeredvpc/templates/patching.k)
- Static resource creation and patching with `function-patch-and-transform`
  For single resources that contain minimal or no complexity.

For a YAML version of the composition that can be applied to the cluster see
[peered-vpc-network.yaml](../package/compositions/peered-vpc-network.yaml)