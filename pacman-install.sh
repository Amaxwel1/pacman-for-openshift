#!/bin/sh

oc new-project pacman
oc create -n pacman -f security/rbac.yaml
oc create -n pacman -f security/secret.yaml
oc create -n pacman -f persistentvolumeclaim/mongo-pvc.yaml
oc create -n pacman -f deployments/mongo-deployment.yaml
while [ "$(oc get pods -l=name='mongo' -n pacman -o jsonpath='{.items[*].status.containerStatuses[0].ready}')" != "true" ]; do
   sleep 5
   echo "Waiting for mongo pod to change to running status"
done
oc create -n pacman -f deployments/pacman-deployment.yaml
oc create -n pacman -f services/mongo-service.yaml
oc create -n pacman -f services/pacman-service.yaml