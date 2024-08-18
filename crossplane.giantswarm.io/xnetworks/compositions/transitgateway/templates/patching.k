
ramShareArn = ocdsstatus("ram-${appName}-${region}", "arn", False)
ramShareId = ocdsstatus("ram-${appName}-${region}", "id", False)

_items = [
    {
        **dxr,
        **{
            "status": {
                if tgwId:
                    "tgwId" = tgwId,
                if tgwArn:
                    "tgwArn" = tgwArn,
                if tgwRouteTableId:
                    "tgwRouteTableId" = tgwRouteTableId,
                if localAttachmentIds:
                    "localAttachmentIds" = localAttachmentIds,
                if remoteAttachementIds:
                    "remoteAttachmentIds" = remoteAttachementIds,
                if ramShareId:
                    "ramShareId" = ramShareId,
                if ramShareArn:
                    "ramShareArn" = ramShareArn,

                "ready" = allReady(),
            }
        }
    }
]
