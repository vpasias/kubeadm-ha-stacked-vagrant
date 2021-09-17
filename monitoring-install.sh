#!/bin/bash
# https://computingforgeeks.com/setup-prometheus-and-grafana-on-kubernetes/

git clone https://github.com/prometheus-operator/kube-prometheus.git && cd kube-prometheus

kubectl create -f manifests/setup

kubectl get ns monitoring

sleep 300

kubectl get pods -n monitoring

kubectl create -f manifests/

kubectl get pods -n monitoring

kubectl get svc -n monitoring

# kubectl delete --ignore-not-found=true -f manifests/ -f manifests/setup
