#!/usr/bin/env bash

set -x

KUBERNETES_VERSION="1.21.1"
CONTAINERD_VERSION="1.4.4"

pushd k8s-box
    KUBERNETES_VERSION=${KUBERNETES_VERSION} CONTAINERD_VERSION=${CONTAINERD_VERSION} ./build.sh
popd

pushd lb-box
    ./build.sh
popd