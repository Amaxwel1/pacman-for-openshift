#!/bin/bash

oc delete -n pacman -f security/rbac.yaml
oc delete -n pacman -f security/secret.yaml
oc delete -n pacman -f deployments/mongo-deployment.yaml
oc delete -n pacman -f deployments/pacman-deployment.yaml
oc delete -n pacman -f services/mongo-service.yaml
oc delete -n pacman -f services/pacman-service.yaml

if [[ $# -gt 0  && "$1" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    oc delete -n pacman -f persistentvolumeclaim/mongo-pvc.yaml
    oc delete project pacman
fi