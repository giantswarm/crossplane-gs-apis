_oxr = option("params").oxr
_ocs = option("params").ocds
_blank = {a: "", aName: "a", b: "", bName: "b", c: "", cName: "c"}
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
                    privateRouteTables +=  [
                        {
                            _i = item.Resource.status.routeTables or _blank
                            "${_i.aName}": "${_i.a}"
                            "${_i.bName}": "${_i.b}"
                            "${_i.cName}": "${_i.c}"
                        }
                    ]
                    privateSubnets += [
                        {
                            _i = item.Resource.status.subnets or _blank
                            "${_i.aName}": "${_i.a}"
                            "${_i.bName}": "${_i.b}"
                            "${_i.cName}": "${_i.c}"
                        }
                    ]
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
                    publicRouteTables +=  [
                        {
                            _i = item.Resource.status.routeTables or _blank
                            "${_i.aName}": "${_i.a}"
                            "${_i.bName}": "${_i.b}"
                            "${_i.cName}": "${_i.c}"
                        }
                    ]
                    publicSubnets += [
                        {
                            _i = item.Resource.status.subnets or _blank
                            "${_i.aName}": "${_i.a}"
                            "${_i.bName}": "${_i.b}"
                            "${_i.cName}": "${_i.c}"
                        }
                    ]
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