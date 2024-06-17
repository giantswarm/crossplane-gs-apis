#!/bin/bash

# This script will iterate over all VPC Peering Connections and print the
# route tables associated with each VPC Peering Connection.
#
# It does this by tracing back via the routes that have the VPC Peering
# Connection ID then looking up the route table associated with that route.
# It outputs the route table metadata name, the tag name and the route ID.
#
# This is done to confirm all route tables across VPCs are correctly peered

for p in $(kubectl get vpcpeeringconnections --no-headers -o jsonpath='{.items[*].metadata.name}'); do
    echo -n "$p=";
    id=$(kubectl get vpcpeeringconnection $p -o yaml | yq -r .status.atProvider.id);
    echo $id;

    routeTableIds=("$(
        kubectl get routes -o yaml | yq -r '.items[] | select(.spec.forProvider.vpcPeeringConnectionId == "'$id'") | .spec.forProvider.routeTableId + "_" + .status.atProvider.id'
    )")

    for ids in ${routeTableIds[@]}; do
        routeTableId=$(echo $ids | cut -d_ -f1)
        routeId=$(echo $ids | cut -d_ -f2)
        echo "    $(
            kubectl get routetables -o yaml | yq -r '.items[] | select(.status.atProvider.id == "'$routeTableId'") | .metadata.name + " " + .status.atProvider.tags.Name'
        ) $routeId"
    done
done
