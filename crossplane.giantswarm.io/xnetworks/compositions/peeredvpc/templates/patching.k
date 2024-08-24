privateSubnetsetKeys = sorted([
      k for k in ocds
      if all_true([
        ocds,
        get(ocds, "${k}.Resource.kind", "") == "SubnetSet",
        get(ocds, "${k}.Resource.spec.type", "") == "private"
      ])
])

publicSubnetsetKeys = sorted([
      k for k in ocds
      if all_true([
        ocds,
        get(ocds, "${k}.Resource.kind", "") == "SubnetSet",
        get(ocds, "${k}.Resource.spec.type", "") == "public"
      ])
])

privateRouteTables = [
      {
          key = {"id": value}
          for key, value in get(ocds, "${k}.Resource.status.routeTables", {})
      }
      for _, k in privateSubnetsetKeys
]

privateSubnets = [
      {
          key = {"id": value}
          for key, value in get(ocds, "${k}.Resource.status.subnets", {})
      }
      for _, k in privateSubnetsetKeys
]

publicRouteTables = [
      {
          key = {"id": value}
          for key, value in get(ocds, "${k}.Resource.status.routeTables", {})
      }
      for _, k in publicSubnetsetKeys
]

publicSubnets = [
      {
          key = {"id": value}
          for key, value in get(ocds, "${k}.Resource.status.subnets", {})
      }
      for _, k in publicSubnetsetKeys
]

groupByPeer = get(oxr, "spec.peering.groupBy", False)
groupByTgw = get(oxr, "spec.transitGateway.groupBy", False)
if groupByPeer and groupByTgw and groupByPeer != groupByTgw:
    assert False, "peering.groupBy and transitGateway.groupBy must be the same if both set"

groupBy = groupByPeer if groupByPeer else groupByTgw if groupByTgw else "giantswarm.io/subnetset"

vpcLookup = {
    "groupBy": groupBy
    "enabled": any_true([
        get(oxr, "spec.transitGateway.enabled", False),
        get(oxr, "spec.peering.enabled", False)
    ])
    "remoteVpcs": [
        {
            "name": vpc.name,
            "providerConfigRef": get(vpc, "providerConfigRef", pcr)
            "region": get(vpc, "region", region),
        }
        for _, vpc in get(oxr, "spec.transitGateway.remoteVpcs", [])
        if get(oxr, "spec.transitGateway.enabled", False)
    ] + [
        {
            "name": vpc.name,
            "providerConfigRef": get(vpc, "providerConfigRef", pcr),
            "region": get(vpc, "region", region),
        }
        for _, vpc in get(oxr, "spec.peering.remoteVpcs", [])
        if get(oxr, "spec.peering.enabled", False)
    ]
}

ipamEnabled = any_true([
    get(s, "useIpam", False)
    for _, s in get(oxr, "spec.subnetsets.cidrs", [])
    if s
])

azl = len(get(oxr, "spec.availabilityZones", []))

igwId = ocdsstatus("internet-gateway", "id", False)

m = lambda x: str -> int {
    """
    Get the mask as an integer value
    """
    ip_mask = x.split("/")
    int(ip_mask[1]) if len(ip_mask) == 2 else int(ip_mask[0])
}

cb = lambda x: str, s: int, c: int -> [] {
    """
    Create 3 subnet bits for each subnet group requested

    :param x: The mask of the subnet
    :param s: The size of the vpc prefix
    :param c: The number of subnets requested
    """
    [m(x) - s for _ in range(azl) for _ in range(c) if c > 0 and x]
}

newdxr = {
    **dxr
    **{
        "status" = {
            "subnetBits" = [
                {
                    _vpcSize = s.prefix.split("/")[1]
                    _public = s.public.count
                    _private = s.private.count
                    _x = int(_vpcSize)
                    "prefix": s.prefix
                    "offset": m(s.offset) - _x if s.offset else 0
                    "newBits": cb(s.public.mask, _x, s.public.count) + cb(s.private.mask, _x, s.private.count)
                }
                for s in get(oxr, "spec.subnetsets.cidrs", {}) if s
            ],
            "vpcLookup" = vpcLookup,
            "vpcs" = {
                "self": {
                    if len(cidrs) > 1:
                        "additionalCidrBlocks" = cidrs[1:]
                    if cidrs:
                        "cidrBlock": cidrs[0]
                    if igwId:
                        "internetGateway" = igwId
                    if publicRouteTables:
                        "publicRouteTables" = publicRouteTables
                    if publicSubnets:
                        "publicSubnets" = publicSubnets
                    if privateRouteTables:
                        "privateRouteTables" = privateRouteTables
                    if privateSubnets:
                        "privateSubnets" = privateSubnets

                    if get(pcr, "name", False):
                        "providerConfig" = pcr.name

                    if region:
                        "region" = region

                    "natGateways" = {
                        name = get(item, "Resource.status.atProvider.id", "")
                        for name, item in ocds
                        if all_true([
                            ocds,
                            get(item, "Resource.kind", "") == "NATGateway"
                            get(item, "Resource.status.atProvider.id", False)
                        ])
                    }
                    "transitGateways" = {
                        name = {
                            "id": get(item, "Resource.status.tgwId", ""),
                        }
                        for name, item in ocds
                        if all_true([
                            ocds,
                            get(item, "Resource.kind", "") == "TransitGateway"
                            get(item, "Resource.apiVersion", "") == "xnetworks.crossplane.giantswarm.io/v1alpha1"
                            get(item, "Resource.status.tgwId", False)
                        ])
                    }

                    "vpcPeeringConnections" = {
                        name = {
                            "id": get(item, "Resource.status.peeringConnectionId", ""),
                            "arn": get(item, "Resource.status.peeringConnectionArn", ""),
                        }
                        for name, item in ocds
                        if all_true([
                            ocds,
                            get(item, "Resource.kind", "") == "Peering"
                            get(item, "Resource.apiVersion", "") == "xnetworks.crossplane.giantswarm.io/v1alpha1"
                            get(item, "Resource.status.peeringConnectionId", False)
                            get(item, "Resource.status.peeringConnectionArn", False)
                        ])
                    }
                }
            },

            "ready" = allReady(),
        }
    }
}

_items = [
    newdxr,
]
