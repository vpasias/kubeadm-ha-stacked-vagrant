#!/bin/bash
# https://opensource.com/article/20/9/vms-kubernetes-kubevirt
# http://kubevirt.io/user-guide/operations/installation/
# https://www.tigera.io/blog/using-kubernetes-to-orchestrate-vms/

sudo virt-host-validate qemu

export KUBEVIRT_VERSION="v0.45.0"

wget https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-operator.yaml
kubectl apply -f kubevirt-operator.yaml
kubectl create configmap kubevirt-config -n kubevirt --from-literal debug-useEmulation=true
wget https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-cr.yaml
kubectl apply -f kubevirt-cr.yaml
kubectl get pods -n kubevirt
