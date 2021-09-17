#!/bin/bash

dnf install --assumeyes --nogpgcheck iscsi-initiator-utils
systemctl enable --now iscsid
systemctl status iscsid

kubectl create ns openebs

kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
