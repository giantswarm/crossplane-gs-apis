_oxr = option("params").oxr
_ocs = option("params").ocs
{
    **_oxr
    **{
        "status": {
            vpcs: {
                self: {
                    cidrBlock: _oxr.spec.subnetsets.cidrs[0].prefix
                    additionalCidrBlocks: [
                        s.prefix
                        for s in _oxr.spec.subnetsets.cidrs[1:]
                    ]
                }
            }
        }
    }
    **{
        "status": {
            vpcs: {
                self: {
                    privateRouteTables += [item.status.privateRouteTables]
                    publicRouteTables += [item.status.publicRouteTables]
                    privateSubnets += [item.status.privateSubnets]
                    publicSubnets += [item.status.publicSubnets]
                }
            }
        }
        for name, item in _ocs if item.kind == "SubnetSet"
    }
    **{
        "status":{
            vpcs: {
                self: {
                    natGateways: {
                        name: item.id
                    }
                }
            }
        }
        for name, item in _ocs if item.kind == "NATGateway"
    }
}