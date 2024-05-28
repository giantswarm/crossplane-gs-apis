_oxr = option("params").oxr
m = lambda x: str -> int {
    """
    Get the mask as an integer value
    """
    ip_mask = x.split("/")
    int(ip_mask[1]) if len(ip_mask) == 2 else int(ip_mask[0])
}

cb = lambda x: str, size: int, c: int -> [] {
    """
    Create 3 subnet bits for each subnet group requested
    """
    [m(x) - size for _ in range(3) for _ in range(c) if c > 0 and x != ""]
}

_nb = [
    {
        _vpcSize = s.prefix.split("/")[1]
        _public = s.public.count
        _private = s.private.count
        _x = int(_vpcSize)

        prefix = s.prefix
        newBits = cb(s.public.mask, _x, s.public.count) + cb(s.private.mask, _x, s.private.count)
    }
    for s in _oxr.spec.subnetsets.cidrs
]

{
    **_oxr
    status.subnetBits = _nb
}
