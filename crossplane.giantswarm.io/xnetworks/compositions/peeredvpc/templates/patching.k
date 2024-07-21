# kf = lambda w: any -> any {
#     keys = [k for k in w]
#     [
#         [w[keys[k]], w[keys[k+1]]]
#         for k in range(0, len(keys), 2)
#     ]
# }

_privateSubnetsetKeys = sorted([
      k for k in _ocs
      if all_true([
        _ocs,
        get(_ocs, "${k}.Resource.kind", "") == "SubnetSet",
        get(_ocs, "${k}.Resource.spec.type", "") == "private"
      ])
])

_publicSubnetsetKeys = sorted([
      k for k in _ocs
      if all_true([
        _ocs,
        get(_ocs, "${k}.Resource.kind", "") == "SubnetSet",
        get(_ocs, "${k}.Resource.spec.type", "") == "public"
      ])
])

_privateRouteTables = [
      {
          key = value
          for key, value in get(_ocs, "${k}.Resource.status.routeTables", {})
      }
      for _, k in _privateSubnetsetKeys
]
_privateSubnets = [
      {
          key = value
          for key, value in get(_ocs, "${k}.Resource.status.subnets", {})
      }
      for _, k in _privateSubnetsetKeys
]
_publicRouteTables = [
      {
          key = value
          for key, value in get(_ocs, "${k}.Resource.status.routeTables", {})
      }
      for _, k in _publicSubnetsetKeys
]
_publicSubnets = [
      {
          key = value
          for key, value in get(_ocs, "${k}.Resource.status.subnets", {})
      }
      for _, k in _publicSubnetsetKeys
]

{
    **_dxr
    **{
        "status": {
            vpcs: {
                self: {
                    cidrBlock: _oxr.spec.subnetsets.cidrs[0].prefix
                    additionalCidrBlocks = [
                        s.prefix
                        for s in _oxr.spec.subnetsets.cidrs[1:]
                    ]
                    publicRouteTables = _publicRouteTables
                    publicSubnets = _publicSubnets
                    privateRouteTables = _privateRouteTables
                    privateSubnets = _privateSubnets
                    natGateways = {
                        name: item.Resource.status.atProvider.id
                        for name, item in _ocs if _ocs and item.Resource.kind == "NATGateway"
                    }
                }
            }
        }
    } if any_true([
        _publicRouteTables,
        _publicSubnets,
        _privateRouteTables,
        _privateSubnets
    ]) else {}
}
