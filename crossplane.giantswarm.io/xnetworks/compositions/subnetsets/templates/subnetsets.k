import regex
oxr = option("params").oxr
dxr = option("params").dxr
ocds = option("params").ocds
dcds = option("params").dcds

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

exists = lambda x: any -> bool {
    """
    Check if a value exists.
    """
    x in list(ocds)
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    _x = None
    if get(ocds, "${x}.Resource.status.atProvider", False):
        _x = get(ocds, "${x}.Resource.status.atProvider.${y}", d)
    else:
        _x = get(ocds, "${x}.Resource.status.${y}", d)
    _x if _x else d
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditionsReady = all_true([
        get(c, "status", "False") == "True" for c in ocdsstatus(x, "conditions", [])
    ])

    ap = get(ocds, "${x}.Resource.status.atProvider", {})
    objectReady = any_true([
        ocdsstatus(x, "ready", False),
        len(list(ap)) > 0,
    ])

    all_true([
        any_true([exists(x), conditionsReady]),
        objectReady,
    ])
}


readystr = lambda y: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(y) else "False"
}

allReady = lambda -> bool {
    """
    Check if all managed resources are ready.
    """
    all_true([
        ready(x)
        for x in list(ocds)
    ])
}

appIndex = get(oxr, "spec.appIndex", "")
appName = get(oxr, "spec.claimRef.name", "") + "-" + appIndex
dp = get(oxr, "spec.deletionPolicy", "Delete")
labels = get(oxr, "metadata.labels", {})
mgmtPolicy = get(oxr, "spec.managementPolicies", [])
pcr = get(oxr, "spec.providerConfigRef", {})
publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})
region = get(oxr, "spec.region", "")
subnets = get(oxr, "spec.subnets", {})
tags = get(oxr, "spec.tags.all", {})
tpe = get(oxr, "spec.type", "")
vpcId = get(oxr, "spec.vpcId", "")

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
            "managementPolicies": mgmtPolicy,
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
            "managementPolicies": mgmtPolicy,
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
            "managementPolicies": mgmtPolicy,
            "providerConfigRef": pcr
        }
    }
    for zone, _ in subnets if zone
]

subnetIds = {
    get(item, "Resource.metadata.labels.availabilityZone", "") = get(item, "Resource.status.atProvider.id", "")
    for _, item in ocds
    if get(item, "Resource.kind", "") == "Subnet"
}

routeTableIds = {
    get(item, "Resource.metadata.labels.availabilityZone", "") = get(item, "Resource.status.atProvider.id", "")
    for _, item in ocds
    if get(item, "Resource.kind", "") == "RouteTable"
}

newdxr = {
    **dxr,
    **{
        "status": {
            if subnetIds:
                "subnets": {
                    "${k}": "${v}"
                    for k, v in subnetIds if k and v
                },

            if routeTableIds:
                "routeTables": {
                    "${k}": "${v}"
                    for k, v in routeTableIds if k and v
                },

            if vpcId:
                "vpcId": vpcId,

            "ready" = allReady(),
        }
    }
}

items = [
    i for r in [subnetsets, routeTables, associations, [newdxr]]
    for i in r if i
]