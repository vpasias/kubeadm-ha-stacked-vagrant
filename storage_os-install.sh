#!/bin/bash
# https://docs.storageos.com/docs/install/kubernetes/

mkdir -p storageos && cd storageos

curl -s https://docs.storageos.com/sh/deploy-etcd.sh | bash

sleep 60

kubectl -n storageos-etcd get pod,svc

kubectl create -f https://github.com/storageos/cluster-operator/releases/download/v2.4.4/storageos-operator.yaml

kubectl -n storageos-operator get pod

sleep 60

kubectl -n storageos-operator get pod

cat << EOF | tee secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: "storageos-api"
  namespace: "storageos-operator"
  labels:
    app: "storageos"
type: "kubernetes.io/storageos"
data:
  # Username: echo -n 'administrator' | base64
  # Password: echo -n 'password' | base64
  apiUsername: YWRtaW5pc3RyYXRvcg==
  apiPassword: cGFzc3dvcmQ=
  # CSI Credentials
  csiProvisionUsername: YWRtaW5pc3RyYXRvcg==
  csiProvisionPassword: cGFzc3dvcmQ=
  csiControllerPublishUsername: YWRtaW5pc3RyYXRvcg==
  csiControllerPublishPassword: cGFzc3dvcmQ=
  csiNodePublishUsername: YWRtaW5pc3RyYXRvcg==
  csiNodePublishPassword: cGFzc3dvcmQ=
  csiControllerExpandUsername: YWRtaW5pc3RyYXRvcg==
  csiControllerExpandPassword: cGFzc3dvcmQ=
EOF

kubectl apply -f secret.yaml

cat << EOF | tee so_cluster.yaml
apiVersion: "storageos.com/v1"
kind: StorageOSCluster
metadata:
  name: "example-storageos"
  namespace: "storageos-operator"
spec:
  # StorageOS Pods are in kube-system by default
  secretRefName: "storageos-api" # Reference from the Secret created in the previous step
  secretRefNamespace: "storageos-operator"  # Namespace of the Secret
  k8sDistro: "upstream"
  images:
    nodeContainer: "storageos/node:v2.4.4" # StorageOS version
  kvBackend:
    address: 'storageos-etcd-client.storageos-etcd:2379'
#    address: '192.168.10.11:2479,192.168.10.12:2479,192.168.10.13:2479' # modified etcd ports for external,autonomous storageos etcd cluster
  resources:
    requests:
      memory: "512Mi"
      cpu: 1
#  nodeSelectorTerms:
#    - matchExpressions:
#      - key: "node-role.kubernetes.io/worker" # Compute node label will vary according to your installation
#        operator: In
#        values:
#        - "true"
EOF

kubectl apply -f so_cluster.yaml

sleep 120

kubectl -n kube-system get pods -w

# Install storageos CLI
# https://docs.storageos.com/docs/reference/cli/

curl -sSLo storageos \ 
    https://github.com/storageos/go-cli/releases/download/v2.4.4/storageos_linux_amd64 \
    && chmod +x storageos \
    && sudo mv storageos /usr/local/bin/

export STORAGEOS_USERNAME=storageos
export STORAGEOS_PASSWORD=storageos
export STORAGEOS_ENDPOINTS=192.168.10.10:5705

storageos get cluster

# Get or copy storageos license
# https://docs.storageos.com/docs/operations/licensing/

cat << EOF | tee storageos-licence.dat
clusterCapacityGiB: 5120
clusterID: 164237eb-f88a-4bb8-a7cf-a23d468e07c0
customerName: storageos
expiresAt: "2021-11-15T14:00:00Z"
features:
- nfs
kind: project

------------- LICENCE SIGNATURE -------------
KyjNleTcdmieZVLmZ/rg0SzdAM7I/CH0j22FIFJJSJaeB71OvQrTMtHGyL5TSFNMrEGbyh1HQlDgZb5A
V1HyjBlS3LjoB/MoagulTxIlZh/R8eRXCOQ46qNZ8Yb7+dHLdCVXBnRqZT11hLqZsMqIeO1y9f5dw65H
kvl6vWW7YIS9r655S25jMMU7brrGDQVdjvU7tSA74BrnzDFHu7/poopIuFqcxZc/NLrKp/akkvyZI5Ex
1wH7D4onjVG2pgi30Kia+mjbI1B9pxQyRppQQ4hNXy4qBUUNMFh0menh0wHdQoM1VLU4Il22PrkeICV0
NaalLsK/96bJov6tpbg96g==
EOF

storageos apply licence --from-file storageos-licence.dat

storageos get cluster

# Deploy kubevirt with storageos

git clone https://github.com/storageos/use-cases.git storageos-usecases && cd storageos-usecases/kubevirt

kubectl create -f ./kubevirt-install

kubectl get pods -w -n kubevirt

kubectl create -f ./cdi

kubectl get pods -n cdi

kubectl create -f ./vm-cirros.yaml

kubectl get vmi

kubectl virt console cirros
