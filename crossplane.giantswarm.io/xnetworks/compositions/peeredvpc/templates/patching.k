import regex
_oxr = option("params").oxr
_dxr = option("params").dxr
_ocs = option("params").ocds

get = lambda x: any, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

kf = lambda w: any -> any {
    keys = [k for k in w]
    [
        [w[keys[k]], w[keys[k+1]]]
        for k in range(0, len(keys), 2)
    ]
}

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

print("===============================================================================================================")
print(_publicSubnetsetKeys)
print(_privateSubnetsetKeys)
print("===============================================================================================================")

_privateRouteTables = [
      {
          i[1]: i[0]
          for i in kf(get(_ocs, "${k}.Resource.status.routeTables", {}))
      }
      for _, k in _privateSubnetsetKeys
]
_privateSubnets = [
      {
          i[1]: i[0]
          for i in kf(get(_ocs, "${k}.Resource.status.subnets", {}))
      }
      for _, k in _privateSubnetsetKeys
]
_publicRouteTables = [
      {
          i[1]: i[0]
          for i in kf(get(_ocs, "${k}.Resource.status.routeTables", {}))
      }
      for _, k in _publicSubnetsetKeys
]
_publicSubnets = [
      {
          i[1]: i[0]
          for i in kf(get(_ocs, "${k}.Resource.status.subnets", {}))
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
    } if all_true([_publicRouteTables, _publicSubnets, _privateRouteTables, _privateSubnets]) else {}
}
