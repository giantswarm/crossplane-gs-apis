peering = [
    {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "Peering"
        "metadata": {
            _resourceName = "peering-${remoteVpc.name}"
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = _resourceName
                "krm.kcl.dev/ready" = readystr(_resourceName)
            }
            "labels": labels | {
                "vpcName": remoteVpc.name
            }
        }
        "spec": {
            "claimRef": claimRef
            "deletionPolicy": dp
            "enabled": peeringEnabled
            "localVpcDetails": {
                "name": get(oxr, "spec.claimRef.name", "")
                "cidrBlocks": [
                    c for c in [
                        get(oxr, "status.vpcs.self.cidrBlock", "")
                    ] + get(oxr, "status.vpcs.self.additionalCidrBlocks", [])
                    if c
                ]
                "region": region
                "routeTableIds": [
                    i.id for r in get(oxr, "status.vpcs.self.publicRouteTables", [])
                    for _, i in r
                    if get(oxr, "spec.peering.allowPublic", True)
                ] + [
                    i.id for r in get(oxr, "status.vpcs.self.privateRouteTables", [])
                    for _, i in r
                ]
                "vpcId": get(oxr, "status.vpcs.self.id", "")
            }
            "managementPolicies": mgmtPolicy,
            "peerVpcDetails": {
                "name": remoteVpc.name
                "cidrBlocks": [
                    c for c in [
                        get(oxr, "status.vpcs.${remoteVpc.name}.cidrBlock", "")
                    ] + get(oxr, "status.vpcs.${remoteVpc.name}.additionalCidrBlocks", [])
                    if c
                ]
                "region": remoteVpc.region
                "routeTableIds": [
                    i.id for r in get(oxr, "status.vpcs.${remoteVpc.name}.publicRouteTables", [])
                    for _, i in r
                    if get(remoteVpc, "allowPublic", True)
                ] + [
                    i.id for r in get(oxr, "status.vpcs.${remoteVpc.name}.privateRouteTables", [])
                    for _, i in r
                ]
                "vpcId": get(oxr, "status.vpcs.${remoteVpc.name}.id", "")
            }
            "tags": {
                "Name": "${appName}-${region}-${remoteVpc.name}"
            } | tags
            providerConfigRef: pcr
        }
    }
    for _, remoteVpc in get(oxr, "spec.peering.remoteVpcs", [])
    if all_true([
        peeringEnabled,
        get(oxr, "status.vpcs.self.id", False),
        get(oxr, "status.vpcs.${remoteVpc.name}.id", False),
    ])
]

_items = peering