_oxr = option("params").oxr
_ocs = option("params").ocds

{
    **_oxr
    **{
        "status": {
            vpcs: {
                self: {
                    cidrBlock: _oxr.spec.subnetsets.cidrs[0].prefix
                    additionalCidrBlocks = [
                        s.prefix
                        for s in _oxr.spec.subnetsets.cidrs[1:]
                    ]
                    publicRouteTables = []
                    publicSubnets = []
                    privateRouteTables = []
                    privateSubnets = []

                }
            }
        }
    }
    **{
        "status": {
            vpcs: {
                self: {
                    privateRouteTables +=  [item.Resource.status.routeTables]
                    privateSubnets += [item.Resource.status.subnets]
                }
            }
        }
        for _, item in _ocs
        if _ocs and item.Resource.kind == "SubnetSet" and item.Resource.spec.type == "private"
    }
    **{
        "status": {
            vpcs: {
                self: {
                    publicRouteTables +=  [item.Resource.status.routeTables]
                    publicSubnets += [item.Resource.status.subnets]
                }
            }
        }
        for _, item in _ocs
        if _ocs and item.Resource.kind == "SubnetSet" and item.Resource.spec.type == "private"
    }

    **{
        "status":{
            vpcs: {
                self: {
                    natGateways = {
                        name: item.Resource.status.atProvider.id
                    }
                }
            }
        }
    for name, item in _ocs if _ocs and item.Resource.kind == "NATGateway"
    }
}