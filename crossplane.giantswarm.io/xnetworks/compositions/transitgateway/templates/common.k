import regex
oxr = option("params").oxr
ocds = option("params").ocds

exists = lambda x: any -> bool {
    """
    Check if a value exists.
    """
    x in list(ocds)
}

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

gpcr = lambda x: {:} -> {:} {
    """
    Get the ProviderConfigRef from the given object

    If this is not set it will attempt to return the ProviderConfigRef from
    the Observed Composite Resource, and if that isn't set, will return an
    object with an empty name.
    """
    get(x, "providerConfigRef", get(oxr, "spec.providerConfigRef", {name: ""}))
}

ocdsstatus = lambda x: str, y: str, d: any -> any {
    """
    Get an item from the status of an ocds resource.
    """
    get(ocds, "${x}.Resource.status.atProvider.${y}", d)
}

ready = lambda x: str -> bool {
    """
    Check if a value is ready.
    """
    conditions = get(ocds, "${x}.Resource.status.conditions", [])
    any_true([
        exists(x),
        all_true([
            get(c, "status", "False") == "True" for c in conditions
        ])
    ])
}

readystr = lambda x: str -> str {
    """
    Check if a value is ready.
    """
    "True" if ready(x) else "False"
}

appName = get(oxr, "spec.claimRef.name", "")
dp = get(oxr, "spec.deletionPolicy", "Delete")
labels = get(oxr, "metadata.labels", {})
localVpc = get(oxr, "spec.localVpc", {})
pcr = get(oxr, "spec.providerConfigRef", {"name": "default"})
region = get(oxr, "spec.localVpc.region", "eu-central-1")
tags = get(oxr, "spec.tags.common", {}) | {
    region: region,
}

localAttachmentIds = {
    "${appName}": ocdsstatus("tgwa-${appName}-${region}", "id", "")
    for _ in [True]
    if ocdsstatus("tgwa-${appName}-${region}", "id", False)
}

mgmtPolicy = get(oxr, "spec.managementPolicies", [])

publishConnection = get(oxr, "spec.publishConnectionDetailsTo", {})
tgwArn = ocdsstatus("transitgateway-${appName}-${region}", "arn", False)
tgwEnabled = get(oxr, "spec.enabled", False)
tgwId = ocdsstatus("transitgateway-${appName}-${region}", "id", False)
tgwRouteTableId = ocdsstatus("tgwrt-${appName}-${region}", "id", False)

remoteAttachementIds = {
    "${remoteVpc.name}": ocdsstatus("tgwa-${appName}-${region}-${remoteVpc.name}", "id", "")
    for _, remoteVpc in get(oxr, "spec.remoteVpcs", [])
    if ocdsstatus("tgwa-${appName}-${region}-${remoteVpc.name}", "id", False)
}

peerAttachmentIds = {
    "${peer.name}": ocdsstatus("tgwa-${appName}-${region}-${peer.name}", "id", "")
    for _, peer in get(oxr, "spec.peers", [])
    if ocdsstatus("tgwa-${appName}-${region}-${peer.name}", "id", False)
}