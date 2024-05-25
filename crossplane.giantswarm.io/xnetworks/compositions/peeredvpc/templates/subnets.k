_oxr = option("params").oxr
_vpcSize = _oxr.spec.parameters.cidrBlock.split("/")[1]
_public = _oxr.spec.parameters.subnetgroups.public
_private = _oxr.spec.parameters.subnetgroups.private
_newBits = []
_x = int(_vpcSize)

m = lambda x: str -> int {
    """
    Get the mask as an integer value
    """
    ip_mask = x.split("/")
    int(ip_mask[1]) if len(ip_mask) == 2 else int(ip_mask[0])
}

cb = lambda x: str, c: int -> [] {
    """
    Create 3 subnet bits for each subnet group requested
    """
    [m(x) - _x for _ in range(3) for _ in range(c) if c > 0 and x != ""]
}

_newBits += cb(_public.mask, _public.count)
_newBits += cb(_private.mask, _private.count)

{
    **_oxr
    status.subnetBits = _newBits
}