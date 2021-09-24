#!/bin/bash
# https://www.civo.com/learn/kube-ception-kubernetes-within-kubernetes-within-kubernetes-using-harvester
# https://www.suse.com/c/meet-harvester-an-hci-solution-for-the-edge-src/
# https://github.com/harvester/harvester/tree/master/deploy/charts/harvester

git clone https://github.com/k8snetworkplumbingwg/multus-cni.git && cd multus-cni

cat ./images/multus-daemonset.yml | kubectl apply -f -

cd

git clone https://github.com/rancher/harvester && cd harvester/deploy/charts

kubectl create ns harvester-system

helm install harvester harvester --namespace harvester-system --set longhorn.enabled=true,minio.persistence.storageClass=longhorn,service.harvester.type=NodePort

cd

helm history harvester -n harvester-system

kubectl get deploy -n harvester-system

kubectl get svc -n harvester-system
