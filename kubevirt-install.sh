#!/bin/bash
# https://opensource.com/article/20/9/vms-kubernetes-kubevirt
# http://kubevirt.io/user-guide/operations/installation/
# https://www.tigera.io/blog/using-kubernetes-to-orchestrate-vms/

# sudo virt-host-validate qemu
cat /sys/module/kvm_intel/parameters/nested

mkdir -p kubevirt && cd kubevirt

export KUBEVIRT_VERSION="v0.45.0"

wget https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-operator.yaml
kubectl apply -f kubevirt-operator.yaml
kubectl create configmap kubevirt-config -n kubevirt --from-literal debug-useEmulation=true
wget https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-cr.yaml
kubectl apply -f kubevirt-cr.yaml
kubectl get pods -n kubevirt

VERSION=$(kubectl get kubevirt.kubevirt.io/kubevirt -n kubevirt -o=jsonpath="{.status.observedKubeVirtVersion}")
curl -L -o virtctl https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/virtctl-${VERSION}-linux-amd64
chmod +x virtctl
sudo install virtctl /usr/local/bin
virtctl version
