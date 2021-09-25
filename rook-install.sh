#!/bin/bash
# https://itnext.io/using-rook-on-a-k3s-cluster-8a97a75ba25e
# Rook v1.7.3

sudo fdisk -l | grep 'Disk /dev/sd*'

git clone --branch v1.7.3 https://github.com/rook/rook.git && cd rook/cluster/examples/kubernetes/ceph

kubectl create -f crds.yaml -f common.yaml

kubectl create -f operator.yaml

sleep 60

kubectl create -f cluster.yaml

sleep 180

kubectl get pod -n rook-ceph

kubectl apply -f ./csi/rbd/storageclass.yaml

kubectl get sc

# kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

cat << EOF | tee toolbox.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rook-ceph-tools
  namespace: rook-ceph
  labels:
    app: rook-ceph-tools
spec:
  replicas: 1
  selector:
    matchLabels:
      app: rook-ceph-tools
  template:
    metadata:
      labels:
        app: rook-ceph-tools
    spec:
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      - name: rook-ceph-tools
        image: rook/ceph:v1.7.3
        command: ["/tini"]
        args: ["-g", "--", "/usr/local/bin/toolbox.sh"]
        imagePullPolicy: IfNotPresent
        env:
          - name: ROOK_CEPH_USERNAME
            valueFrom:
              secretKeyRef:
                name: rook-ceph-mon
                key: ceph-username
          - name: ROOK_CEPH_SECRET
            valueFrom:
              secretKeyRef:
                name: rook-ceph-mon
                key: ceph-secret
        volumeMounts:
          - mountPath: /etc/ceph
            name: ceph-config
          - name: mon-endpoint-volume
            mountPath: /etc/rook
      volumes:
        - name: mon-endpoint-volume
          configMap:
            name: rook-ceph-mon-endpoints
            items:
            - key: data
              path: mon-endpoints
        - name: ceph-config
          emptyDir: {}
      tolerations:
        - key: "node.kubernetes.io/unreachable"
          operator: "Exists"
          effect: "NoExecute"
          tolerationSeconds: 5
EOF

kubectl create -f toolbox.yaml

# Access Rook toolbox
# kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash
# ceph status
# ceph osd status
# ceph df

# Test Rook
# kubectl apply -f https://luc.run/ghost-with-pvc.yaml
# kubectl get pv,pvc
