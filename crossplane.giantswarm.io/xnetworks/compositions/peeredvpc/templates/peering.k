peering = [
    {
        "apiVersion": "xnetworks.crossplane.giantswarm.io/v1alpha1"
        "kind": "Peering"
        "metadata": {
            "annotations": {
                "krm.kcl.dev/composition-resource-name" = "peering-${remoteVpc.name}"
                "krm.kcl.dev/ready" = ready(_ocs, "peering-${remoteVpc.name}")
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
                "name": get(_oxr, "spec.claimRef.name", "")
                "cidrBlocks": [
                    c for c in [
                        get(_oxr, "status.vpcs.self.cidrBlock", "")
                    ] + get(_oxr, "status.vpcs.self.additionalCidrBlocks", [])
                    if c
                ]
                "region": region
                "routeTableIds": [
                    i.id for r in get(_oxr, "status.vpcs.self.publicRouteTables", [])
                    for _, i in r
                    if get(_oxr, "spec.peering.allowPublic", True)
                ] + [
                    i.id for r in get(_oxr, "status.vpcs.self.privateRouteTables", [])
                    for _, i in r
                ]
                "vpcId": get(_oxr, "status.vpcs.self.id", "")
            }
            "peerVpcDetails": {
                "name": remoteVpc.name
                "cidrBlocks": [
                    c for c in [
                        get(_oxr, "status.vpcs.${remoteVpc.name}.cidrBlock", "")
                    ] + get(_oxr, "status.vpcs.${remoteVpc.name}.additionalCidrBlocks", [])
                    if c
                ]
                "region": remoteVpc.region
                "routeTableIds": [
                    i.id for r in get(_oxr, "status.vpcs.${remoteVpc.name}.publicRouteTables", [])
                    for _, i in r
                    if get(remoteVpc, "allowPublic", True)
                ] + [
                    i.id for r in get(_oxr, "status.vpcs.${remoteVpc.name}.privateRouteTables", [])
                    for _, i in r
                ]
                "vpcId": get(_oxr, "status.vpcs.${remoteVpc.name}.id", "")
            }
            "tags": {
                "Name": "${appName}-${region}-${remoteVpc.name}"
            } | tags
            providerConfigRef: pcr
        }
    }
    for _, remoteVpc in get(_oxr, "spec.peering.remoteVpcs", [])
    if all_true([
        peeringEnabled,
        get(_oxr, "status.vpcs.self.id", False),
        get(_oxr, "status.vpcs.${remoteVpc.name}.id", False),
    ])
]

_items = peering