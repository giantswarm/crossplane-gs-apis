import regex
_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds

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

ready = lambda x: any, y: str -> str {
    """
    Check if a value is ready.
    """
    conditions = get(x, "${y}.Resource, status.conditions", [])
    "True" if all_true([
        get(c, "status", "False") == "True" for c in conditions
    ]) else "False"
}

xrReady = lambda x: any -> str {
    """
    Check if a resource is ready.
    """
    "True" if all_true([
        all_true([
            get(c, "status", "False") for c in get(y, "Resource.status.conditions", [])
        ]) for y in x
    ]) else "False"
}

_appIndex = get(_oxr, "spec.appIndex", "")
_appName = get(_oxr, "spec.claimRef.name", "") + "-" + _appIndex
_labels = get(_oxr, "metadata.labels", {})
_region = get(_oxr, "spec.region", "")
_subnets = get(_oxr, "spec.subnets", {})

_tags = get(_oxr, "spec.tags.all", {})
_type = get(_oxr, "spec.type", "")
_vpcId = get(_oxr, "spec.vpcId", "")

_subnetsets = [
    {
        _az = "${_region}${zone}"
        _resourceName = "subnet-${_az}"

        apiVersion: "ec2.aws.upbound.io/v1beta1",
        kind: "Subnet",
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready": ready(_ocds, _resourceName)
            }
            labels = _labels | {
                access: _type
                availabilityZone: _az
            }
        }
        spec: {
            forProvider: {
                "availabilityZone": _az
                "cidrBlock": cidrBlock
                "mapPublicIpOnLaunch": _type == "public"
                "region": _region
                "tags": _tags | {
                    Name: "${_appName}-${_type}-${_az}"
                } | {
                    "${k}": "${v}"
                    for k, v in get(_tags, "subnet", {})
                }
                "vpcId": _vpcId
            }
        }
    }
    for zone, cidrBlock in _subnets if zone and cidrBlock
]

_routeTables = [
    {
        _az = "${_region}${zone}"
        apiVersion: "ec2.aws.upbound.io/v1beta1",
        kind: "RouteTable",
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "route-table-${_az}"
            }
            labels = _labels | {
                access: _type
                availabilityZone: _az
            }
        }
        spec: {
            forProvider: {
                region: _region
                tags: _tags | {
                    Name: "${_appName}-${_type}-${_az}"
                }
                vpcId: _vpcId
            }
        }
    }
    for zone, _ in _subnets if zone
]

_associations = [
    {
        _az = "${_region}${zone}"
        apiVersion: "ec2.aws.upbound.io/v1beta1",
        kind: "RouteTableAssociation",
        metadata: {
            annotations: {
                "krm.kcl.dev/composition-resource-name" = "association-${_az}"
            }
        }
        spec: {
            forProvider: {
                region: _region
                routeTableIdSelector: {
                    matchControllerRef: True
                    matchLabels: {
                        availabilityZone: _az
                    }
                }
                subnetIdSelector: {
                    matchControllerRef: True
                    matchLabels: {
                        availabilityZone: _az
                    }
                }
            }
        }
    }
    for zone, _ in _subnets if zone
]

_subnetIds = {
    get(item, "Resource.metadata.labels.availabilityZone", "") = get(item, "Resource.status.atProvider.id", "")
    for _, item in _ocds
    if get(item, "Resource.kind", "") == "Subnet"
}

_routeTableIds = {
    get(item, "Resource.metadata.labels.availabilityZone", "") = get(item, "Resource.status.atProvider.id", "")
    for _, item in _ocds
    if get(item, "Resource.kind", "") == "RouteTable"
}

_newdxr = {
    **_oxr,
    **{
        "metadata": {
            "annotations": {
                "krm.kcl.dev/ready": xrReady(_ocds)
            }
        }
        "status": {
            "subnets": {
                "${k}": "${v}"
                for k, v in _subnetIds if k and v
            }
            "routeTables": {
                "${k}": "${v}"
                for k, v in _routeTableIds if k and v
            }
            "vpcId": _vpcId
        } if _routeTableIds and _subnetIds else {}
    }
}

items = [
    i for r in [_subnetsets, _routeTables, _associations, [_newdxr]]
    for i in r if i
]