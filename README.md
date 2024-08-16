# Giant Swarm Crossplane APIs

This repository contains both code and crossplane compositions and definitions
generated via `crossbuilder`, an opensource crossplane compiler.

## APIs

If an API is marked `(definition only)`, check the [crossplane-examples] repo

- [xaws.crossplane.giantswarm.io](./crossplane.giantswarm.io/xaws)
  May offer wrapper compositions to provide multi-component compositions.
  - [RCCWithRegionLookup]
  - [RdsCacheCluster]
- [xcache.crossplane.giantswarm.io](./crossplane.giantswarm.io/xcache)
  An API group for working with cache clusters
  - [CacheBase](./crossplane.giantswarm.io/xcache/docs/cache-base.md)
    A base composition for building cache clusters
- [xdatabase.crossplane.giantswarm.io](./crossplane.giantswarm.io/xdatabase)
  An API group for working with databases
  - [RdsBase](./crossplane.giantswarm.io/xdatabase/docs/rds-base.md)
  A base composition for building RDS Databases.
- [xnetworks.crossplane.giantswarm.io](./crossplane.giantswarm.io/xnetworks/)
  - [PeeredVpcNetwork](./crossplane.giantswarm.io/xnetworks/docs/peeredvpc.md)
    Build a VPC with optional n-dimensional VPC peering
  - [SubnetSet](./crossplane.giantswarm.io/xnetworks/docs/subnetset.md)
    Create Sets of subnets which logically belong together across *n* subnets
  - VpcNetwork (definition only) [***deprecated***] Use PeeredVpcNetwork instead

# Building API documentation

This project uses crd-docs-generator to build the API spec

> [!NOTE]
> Currently requires a future version of crd-docs-generator

```bash
docker run \
    -v $(pwd)/apidocs:/opt/crd-docs-generator/output \
    -v $(pwd):/opt/crd-docs-generator/config \
    gsoci.azurecr.io/giantswarm/crd-docs-generator:0.12.0 \
      --config /opt/crd-docs-generator/config/doc-gen.yaml
```

## Building

To build the `go` code into consumable YAML, the fork of `crossbuilder` found
at [mproffitt/crossbuilder](https://github.com/mproffitt/crossbuilder) is
required.

Clone the crossbuilder repo first and run `docker build . -t xrdtools` inside it

Next, enter the directory you need to build compositions for.

In this example we will use [xnetworks](./crossplane.giantswarm.io/xnetworks/).

`cd` to this location and execute the following command

```bash
dir="$(basename $(pwd))"; apidir="$(pwd)/../../apis/$dir"; \
    [ ! -d $apidir ] && mkdir $apidir; \
    docker run -itv $(pwd):/crossbuilder/apis:rw -v \
        $apidir:/crossbuilder/apis/package/xrds:rw -v \
        $apidir:/crossbuilder/apis/package/compositions:rw xrdtools
```

You do not need to give a command to docker, just the name of the container.

This will run `go generate ./...` and then build any/all compositions under
[compositions](../compositions) folder by first compiling the `xrc-gen` command
and executing it which will in turn build any/all compositions as plugins and
execute them to generate the manifests.

Output from this command is written to the `package` folder.

### Example

```nohighlight
$ cd crossplane.giantswarm.io/xnetworks/
$ dir="$(basename $(pwd))"; apidir="$(pwd)/../../apis/$dir"; \
    [ ! -d $apidir ] && mkdir $apidir; \
    docker run -itv $(pwd):/crossbuilder/apis:rw -v \
        $apidir:/crossbuilder/apis/package/xrds:rw -v \
        $apidir:/crossbuilder/apis/package/compositions:rw xrdtools

go: downloading sigs.k8s.io/controller-tools v0.15.0
... <TRUNCATED>
copying go.mod and go.sum
generating definitions
generating compositions
/crossbuilder/apis
=====================================
2024/07/21 12:58:54 compiled plugin plugins/peeredvpc.so
2024/07/21 12:58:57 compiled plugin plugins/subnetsets.so
step: network-discovery
step: function-kcl-subnet-bits
step: function-cidr
step: function-kcl-create-resources
step: function-kcl-patch-xr
step: patch-and-transform
step: function-auto-ready
step: function-kcl-create-resources
step: function-auto-ready
```
