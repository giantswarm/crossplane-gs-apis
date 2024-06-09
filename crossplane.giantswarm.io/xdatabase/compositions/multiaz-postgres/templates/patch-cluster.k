import regex

_oxr = option("params").oxr
_ocds = option("params").ocds
_dcds = option("params").dcds

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

_region = get(_oxr, "spec.region", "eu-central-1")
_ipgn = get(_oxr, "spec.dbParameterGroup.name", "") if get(_oxr, "spec.allowMajorVersionUpgrade", False) else ""
_regionedAzs = ["${_region}${az}" for az in get(_oxr, "spec.availabilityZones", ["a", "b", "c"])]
_restoreToPointInTime = {
    sourceDbClusterIdentifier = get(_oxr, "spec.restoreToPointInTime.sourceDbClusterIdentifier", None),
    restoreType = get(_oxr, "spec.restoreToPointInTime.restoreType", "full-copy"),
} | {
    restoreToTime = get(_oxr, "spec.restoreToPointInTime.restoreToTime", None),
} if get(_oxr, "spec.restoreToPointInTime.restoreToTime", False) else {
    useLatestRestorableTime = get(_oxr, "spec.restoreToPointInTime.useLatestRestorableTime", True),
}

_serverless = get(_oxr, "spec.engineMode", "provisioned") == "serverless"
_provisioned = get(_oxr, "spec.engineMode", "provisioned") == "provisioned"

_scalingConfiguration = get(_oxr, "spec.scalingConfiguration", None) if _serverless else None
_serverlessv2scaling = get(_oxr, "spec.serverlessv2scalingConfiguration", None) if _provisioned else None
_s3import = get(_oxr, "spec.s3Import", None)
_keyId = get(_oxr, "status.kmsKeyId", False)
_dcdsCluster = get(_dcds, "rds-cluster.Resource", False) # could be interesting...

{
    **_dcdsCluster
    **{
      "metadata": {
          annotations: {
              "krm.kcl.dev/composition-resource-name": "rds-cluster"
          }
      }
      "spec": {
            forProvider: {
                availabilityZones: _regionedAzs if get(_oxr, "spec.availabilityZones", False) else []
                restoreToPointInTime: [_restoreToPointInTime] if get(_oxr, "spec.restoreToPointInTime", False) else []
                s3Import: [_s3import] if _s3import != None else []
                scalingConfiguration: [_scalingConfiguration] if _scalingConfiguration != None else []
                serverlessv2ScalingConfiguration: [_serverlessv2scaling] if _serverlessv2scaling != None else []
            }
        }
    }
    **{
        "spec": {
            forProvider: {
                dbInstanceParameterGroupName: _ipgn
            }
        }
    } if _ipgn else {}
} if _dcdsCluster and _keyId else {
    **_dcdsCluster
    **{
        "metadata" = {
            annotations = {
                "krm.kcl.dev/composition-resource-name" = "rds-cluster"
            }
        }
        "spec" = {}
    }
}
