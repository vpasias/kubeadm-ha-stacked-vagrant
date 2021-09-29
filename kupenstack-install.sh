#!/bin/bash
# https://github.com/Kupenstack/kupenstack/tree/main/config/demo

# See nodes names and change accordingly the relative Configmap fields at file: "kupenstack-controller-manager.yaml"
kubectl get nodes

kubectl apply -f https://raw.githubusercontent.com/vpasias/kubeadm-ha-stacked-vagrant/master/kupenstack-controller-manager.yaml

sleep 60

kubectl get pods -n kupenstack-control

sleep 600

kubectl get pods -n kupenstack

kubectl apply -f https://raw.githubusercontent.com/vpasias/kubeadm-ha-stacked-vagrant/master/vm-sample.yaml

kubectl get virtualmachines

kubectl get vm -o wide

kubectl get networks

kubectl get flavors

kubectl get images

kubectl get keypairs -o wide

kubectl describe ns default
