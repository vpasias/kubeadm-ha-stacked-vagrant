#!/bin/bash
# https://itnext.io/using-rook-on-a-k3s-cluster-8a97a75ba25e

sudo fdisk -l | grep 'Disk /dev/sd*'

git clone --branch v1.7.3 https://github.com/rook/rook.git && cd rook/cluster/examples/kubernetes/ceph

kubectl create -f crds.yaml -f common.yaml -f operator.yaml
kubectl create -f cluster.yaml

kubectl apply -f ./csi/rbd/storageclass.yaml

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl apply -f https://luc.run/rook/toolbox.yaml
