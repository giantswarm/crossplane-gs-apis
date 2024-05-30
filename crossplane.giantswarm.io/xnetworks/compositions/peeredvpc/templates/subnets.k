_oxr = option("params").oxr
_azl = len(_oxr.spec.subnetsets.availabilityZones)

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
    [m(x) - s for _ in range(_azl) for _ in range(c) if c > 0 and x != ""]
}

{
    **_oxr
    status.subnetBits = [
        {
            _vpcSize = s.prefix.split("/")[1]
            _public = s.public.count
            _private = s.private.count
            _x = int(_vpcSize)

            prefix = s.prefix
            offset = m(s.offset) - _x
            newBits = cb(s.public.mask, _x, s.public.count) + cb(s.private.mask, _x, s.private.count)
        }
        for s in _oxr.spec.subnetsets.cidrs
    ]
}
