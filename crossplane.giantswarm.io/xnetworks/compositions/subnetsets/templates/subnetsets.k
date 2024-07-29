import regex
_oxr = option("params").oxr
_dxr = option("params").dxr
_ocds = option("params").ocds

get = lambda x: {:}, y: str, d: any -> any {
    """
    Get an item from a dictionary using a dot separated path.
    If the item is not found, return a default value.
    """
    p = regex.split(y, "\.")
    c = p[0]
    y = ".".join(p[1:])
    x[c] if len(p) == 1 and c in x else d if c not in x else get(x[c], y, d)
}

ready = lambda y: str -> bool {
    """
    Check if a value is ready.
    """
    conditions = get(_ocds, "${y}.Resource.status.conditions", [])
    all_true([
        get(c, "status", "False") == "True" for c in conditions
    ])
}

readystr = lambda y: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(y) else "False"
}


appIndex = get(_oxr, "spec.appIndex", "")
appName = get(_oxr, "spec.claimRef.name", "") + "-" + appIndex
dp = get(_oxr, "spec.deletionPolicy", "Delete")
labels = get(_oxr, "metadata.labels", {})
pcr = get(_oxr, "spec.providerConfigRef", {})
region = get(_oxr, "spec.region", "")
subnets = get(_oxr, "spec.subnets", {})
tags = get(_oxr, "spec.tags.all", {})
tpe = get(_oxr, "spec.type", "")
vpcId = get(_oxr, "spec.vpcId", "")

subnetsets = [
    {
        _az = "${region}${zone}"
        _resourceName = "subnet-${_az}"

        "apiVersion": "ec2.aws.upbound.io/v1beta1",
        "kind": "Subnet",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels" = labels | {
                "access": tpe
                "availabilityZone": _az
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "availabilityZone": _az
                "cidrBlock": cidrBlock
                "mapPublicIpOnLaunch": tpe == "public"
                "region": region
                "tags": tags | {
                    Name: "${appName}-${tpe}-${_az}"
                } | get(tags, "subnet", {})

                "vpcId": vpcId
            }
            "providerConfigRef": pcr
        }
    }
    for zone, cidrBlock in subnets if zone and cidrBlock
]

routeTables = [
    {
        _az = "${region}${zone}"
        _resourceName = "route-table-${_az}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1",
        "kind": "RouteTable",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
            "labels": labels | {
                "access": tpe
                "availabilityZone": _az
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "region": region
                "tags": tags | {
                    Name: "${appName}-${tpe}-${_az}"
                }
                "vpcId": vpcId
            }
            "providerConfigRef": pcr
        }
    }
    for zone, _ in subnets if zone
]

associations = [
    {
        _az = "${region}${zone}"
        _resourceName = "association-${_az}"
        "apiVersion": "ec2.aws.upbound.io/v1beta1",
        "kind": "RouteTableAssociation",
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name": _resourceName
                "krm.kcl.dev/ready": readystr(_resourceName)
            }
        }
        "spec": {
            "deletionPolicy": dp
            "forProvider": {
                "region": region
                "routeTableIdSelector": {
                    "matchControllerRef": True
                    "matchLabels": {
                        "availabilityZone": _az
                    }
                }
                "subnetIdSelector": {
                    "matchControllerRef": True
                    "matchLabels": {
                        "availabilityZone": _az
                    }
                }
            }
            "providerConfigRef": pcr
        }
    }
    for zone, _ in subnets if zone
]

subnetIds = {
    get(item, "Resource.metadata.labels.availabilityZone", "") = get(item, "Resource.status.atProvider.id", "")
    for _, item in _ocds
    if get(item, "Resource.kind", "") == "Subnet"
}

routeTableIds = {
    get(item, "Resource.metadata.labels.availabilityZone", "") = get(item, "Resource.status.atProvider.id", "")
    for _, item in _ocds
    if get(item, "Resource.kind", "") == "RouteTable"
}

newdxr = {
    **_oxr,
    **{
        "status": {
            "subnets": {
                "${k}": "${v}"
                for k, v in subnetIds if k and v
            }
            "routeTables": {
                "${k}": "${v}"
                for k, v in routeTableIds if k and v
            }
            "vpcId": vpcId
        } if routeTableIds and subnetIds else {}
    }
}

items = [
    i for r in [subnetsets, routeTables, associations, [newdxr]]
    for i in r if i
]