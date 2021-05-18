# kubeadm-ha-stacked-vagrant / Kubernetes v1.21.1

![](https://raw.githubusercontent.com/lwieske/kubeadm-ha-stacked-vagrant/controller/demo800x600.gif)

Kubernetes Cluster: kubeadm mgmt plane + (load balancer / 3 controller ctrl plane) + 3 executor data plane

## Vagrant Spin Up For 2 Load Balancers + 3 Masters + 3 Workers

![](https://github.com/lwieske/kubeadm-ha-stacked-vagrant/blob/controller/images/3x3-ha-stacked.png)

### K8S 1.21.1

```console
                            |
                            |
                            |
┌────────────┐              ▼               ┌───────────┐
│    lb01    |------------------------------│   lb02    │
└──────┬─────┘                              └─────┬─────┘
       |                                          |       
       ├────────────────────┬─────────────────────┤      
       │                    │                     │      
┌──────▼─────┐       ┌──────▼─────┐        ┌──────▼─────┐
│     m01    │       │     m02    │        │     m03    │
└──────┬─────┘       └──────┬─────┘        └──────┬─────┘
       │                    │                     │      
       ├────────────────────┼─────────────────────┤      
       │                    │                     │      
┌──────▼─────┐       ┌──────▼─────┐        ┌──────▼─────┐
│     w01    │       │     w02    │        │     w03    │
└────────────┘       └────────────┘        └────────────┘
```

```console
> ./rec.sh
+ rm -f demo.cast
+ asciinema rec -y -c 'bash -x run.sh' demo.cast
asciinema: recording asciicast to demo.cast
asciinema: exit opened program when you're done
+ KUBERNETES_VERSION=1.21.1
+ set -x
+ KUBERNETES_VERSION=1.21.1
+ vagrant up
Bringing machine 'lb01' up with 'virtualbox' provider...
Bringing machine 'lb02' up with 'virtualbox' provider...
Bringing machine 'c01' up with 'virtualbox' provider...
Bringing machine 'c02' up with 'virtualbox' provider...
Bringing machine 'c03' up with 'virtualbox' provider...
Bringing machine 'e01' up with 'virtualbox' provider...
Bringing machine 'e02' up with 'virtualbox' provider...
Bringing machine 'e03' up with 'virtualbox' provider...
==> lb01: Preparing master VM for linked clones...
    lb01: This is a one time operation. Once the master VM is prepared,
    lb01: it will be used as a base for linked clones, making the creation
    lb01: of new VMs take milliseconds on a modern system.
==> lb01: Importing base box 'lb'...
==> lb01: Cloning VM...
==> lb01: Matching MAC address for NAT networking...
==> lb01: Setting the name of the VM: kubeadm-ha-stacked-vagrant_lb01_1621334049224_66856
==> lb01: Clearing any previously set network interfaces...
==> lb01: Preparing network interfaces based on configuration...
    lb01: Adapter 1: nat
    lb01: Adapter 2: hostonly
==> lb01: Forwarding ports...
    lb01: 22 (guest) => 2222 (host) (adapter 1)
==> lb01: Running 'pre-boot' VM customizations...
==> lb01: Booting VM...
==> lb01: Waiting for machine to boot. This may take a few minutes...
    lb01: SSH address: 127.0.0.1:2222
    lb01: SSH username: vagrant
    lb01: SSH auth method: private key
==> lb01: Machine booted and ready!
==> lb01: Checking for guest additions in VM...
==> lb01: Setting hostname...
==> lb01: Configuring and enabling network interfaces...
==> lb01: Mounting shared folders...
    lb01: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> lb01: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> lb01: Running provisioner: shell...
    lb01: Running: inline script
==> lb02: Cloning VM...
==> lb02: Matching MAC address for NAT networking...
==> lb02: Setting the name of the VM: kubeadm-ha-stacked-vagrant_lb02_1621334074274_69094
==> lb02: Fixed port collision for 22 => 2222. Now on port 2200.
==> lb02: Clearing any previously set network interfaces...
==> lb02: Preparing network interfaces based on configuration...
    lb02: Adapter 1: nat
    lb02: Adapter 2: hostonly
==> lb02: Forwarding ports...
    lb02: 22 (guest) => 2200 (host) (adapter 1)
==> lb02: Running 'pre-boot' VM customizations...
==> lb02: Booting VM...
==> lb02: Waiting for machine to boot. This may take a few minutes...
    lb02: SSH address: 127.0.0.1:2200
    lb02: SSH username: vagrant
    lb02: SSH auth method: private key
==> lb02: Machine booted and ready!
==> lb02: Checking for guest additions in VM...
==> lb02: Setting hostname...
==> lb02: Configuring and enabling network interfaces...
==> lb02: Mounting shared folders...
    lb02: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> lb02: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> lb02: Running provisioner: shell...
    lb02: Running: inline script
==> c01: Preparing master VM for linked clones...
    c01: This is a one time operation. Once the master VM is prepared,
    c01: it will be used as a base for linked clones, making the creation
    c01: of new VMs take milliseconds on a modern system.
==> c01: Importing base box 'k8s-1.21.1'...
==> c01: Cloning VM...
==> c01: Matching MAC address for NAT networking...
==> c01: Setting the name of the VM: kubeadm-ha-stacked-vagrant_c01_1621334113222_56861
==> c01: Fixed port collision for 22 => 2222. Now on port 2201.
==> c01: Clearing any previously set network interfaces...
==> c01: Preparing network interfaces based on configuration...
    c01: Adapter 1: nat
    c01: Adapter 2: hostonly
==> c01: Forwarding ports...
    c01: 22 (guest) => 2201 (host) (adapter 1)
==> c01: Running 'pre-boot' VM customizations...
==> c01: Booting VM...
==> c01: Waiting for machine to boot. This may take a few minutes...
    c01: SSH address: 127.0.0.1:2201
    c01: SSH username: vagrant
    c01: SSH auth method: private key
==> c01: Machine booted and ready!
==> c01: Checking for guest additions in VM...
==> c01: Setting hostname...
==> c01: Configuring and enabling network interfaces...
==> c01: Mounting shared folders...
    c01: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> c01: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> c01: Running provisioner: shell...
    c01: Running: inline script
    c01: [init] Using Kubernetes version: v1.21.1
    c01: [preflight] Running pre-flight checks
    c01: [preflight] Pulling images required for setting up a Kubernetes cluster
    c01: [preflight] This might take a minute or two, depending on the speed of your internet connection
    c01: [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    c01: [certs] Using certificateDir folder "/etc/kubernetes/pki"
    c01: [certs] Generating "ca" certificate and key
    c01: [certs] Generating "apiserver" certificate and key
    c01: [certs] apiserver serving cert is signed for DNS names [c01 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.101 192.168.10.10]
    c01: [certs] Generating "apiserver-kubelet-client" certificate and key
    c01: [certs] Generating "front-proxy-ca" certificate and key
    c01: [certs] Generating "front-proxy-client" certificate and key
    c01: [certs] Generating "etcd/ca" certificate and key
    c01: [certs] Generating "etcd/server" certificate and key
    c01: [certs] etcd/server serving cert is signed for DNS names [c01 localhost] and IPs [192.168.10.101 127.0.0.1 ::1]
    c01: [certs] Generating "etcd/peer" certificate and key
    c01: [certs] etcd/peer serving cert is signed for DNS names [c01 localhost] and IPs [192.168.10.101 127.0.0.1 ::1]
    c01: [certs] Generating "etcd/healthcheck-client" certificate and key
    c01: [certs] Generating "apiserver-etcd-client" certificate and key
    c01: [certs] Generating "sa" key and public key
    c01: [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    c01: [kubeconfig] Writing "admin.conf" kubeconfig file
    c01: [kubeconfig] Writing "kubelet.conf" kubeconfig file
    c01: [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    c01: [kubeconfig] Writing "scheduler.conf" kubeconfig file
    c01: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    c01: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    c01: [kubelet-start] Starting the kubelet
    c01: [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    c01: [control-plane] Creating static Pod manifest for "kube-apiserver"
    c01: [control-plane] Creating static Pod manifest for "kube-controller-manager"
    c01: [control-plane] Creating static Pod manifest for "kube-scheduler"
    c01: [etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
    c01: [wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
    c01: [apiclient] All control plane components are healthy after 32.570199 seconds
    c01: [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    c01: [kubelet] Creating a ConfigMap "kubelet-config-1.21" in namespace kube-system with the configuration for the kubelets in the cluster
    c01: [upload-certs] Storing the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
    c01: [upload-certs] Using certificate key:
    c01: b46efef6f2e443e42224f75c2485216d3f69aa86dee16f90612c449af89b3d58
    c01: [mark-control-plane] Marking the node c01 as control-plane by adding the labels: [node-role.kubernetes.io/master(deprecated) node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
    c01: [mark-control-plane] Marking the node c01 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    c01: [bootstrap-token] Using token: abcdef.0123456789abcdef
    c01: [bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
    c01: [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to get nodes
    c01: [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
    c01: [bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
    c01: [bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
    c01: [bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
    c01: [kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
    c01: [addons] Applied essential addon: CoreDNS
    c01: [addons] Applied essential addon: kube-proxy
    c01:
    c01: Your Kubernetes control-plane has initialized successfully!
    c01:
    c01: To start using your cluster, you need to run the following as a regular user:
    c01:
    c01:   mkdir -p $HOME/.kube
    c01:   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    c01:   sudo chown $(id -u):$(id -g) $HOME/.kube/config
    c01:
    c01: Alternatively, if you are the root user, you can run:
    c01:
    c01:   export KUBECONFIG=/etc/kubernetes/admin.conf
    c01:
    c01: You should now deploy a pod network to the cluster.
    c01: Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
    c01:   https://kubernetes.io/docs/concepts/cluster-administration/addons/
    c01:
    c01: You can now join any number of the control-plane node running the following command on each as root:
    c01:
    c01:   kubeadm join 192.168.10.10:6443 --token abcdef.0123456789abcdef \
    c01: 	--discovery-token-ca-cert-hash sha256:5cf0c162ae135717a01e42b3d0c72720c1d8fc3c76c43dfbaecb5fb6fc6dccef \
    c01: 	--control-plane --certificate-key b46efef6f2e443e42224f75c2485216d3f69aa86dee16f90612c449af89b3d58
    c01:
    c01:
    c01: Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
    c01: As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
    c01: "kubeadm init phase upload-certs --upload-certs" to reload certs afterward.
    c01:
    c01: Then you can join any number of worker nodes by running the following on each as root:
    c01:
    c01: kubeadm join 192.168.10.10:6443 --token abcdef.0123456789abcdef \
    c01: 	--discovery-token-ca-cert-hash sha256:5cf0c162ae135717a01e42b3d0c72720c1d8fc3c76c43dfbaecb5fb6fc6dccef
    c01: Warning: policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
    c01: podsecuritypolicy.policy/psp.flannel.unprivileged created
    c01: clusterrole.rbac.authorization.k8s.io/flannel created
    c01: clusterrolebinding.rbac.authorization.k8s.io/flannel created
    c01: serviceaccount/flannel created
    c01: configmap/kube-flannel-cfg created
    c01: daemonset.apps/kube-flannel-ds created
    c01: namespace/kubernetes-dashboard created
    c01: serviceaccount/kubernetes-dashboard created
    c01: service/kubernetes-dashboard created
    c01: secret/kubernetes-dashboard-certs created
    c01: secret/kubernetes-dashboard-csrf created
    c01: secret/kubernetes-dashboard-key-holder created
    c01: configmap/kubernetes-dashboard-settings created
    c01: role.rbac.authorization.k8s.io/kubernetes-dashboard created
    c01: clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
    c01: rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
    c01: clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
    c01: deployment.apps/kubernetes-dashboard created
    c01: service/dashboard-metrics-scraper created
    c01: deployment.apps/dashboard-metrics-scraper created
==> c02: Cloning VM...
==> c02: Matching MAC address for NAT networking...
==> c02: Setting the name of the VM: kubeadm-ha-stacked-vagrant_c02_1621334186245_63057
==> c02: Fixed port collision for 22 => 2222. Now on port 2202.
==> c02: Clearing any previously set network interfaces...
==> c02: Preparing network interfaces based on configuration...
    c02: Adapter 1: nat
    c02: Adapter 2: hostonly
==> c02: Forwarding ports...
    c02: 22 (guest) => 2202 (host) (adapter 1)
==> c02: Running 'pre-boot' VM customizations...
==> c02: Booting VM...
==> c02: Waiting for machine to boot. This may take a few minutes...
    c02: SSH address: 127.0.0.1:2202
    c02: SSH username: vagrant
    c02: SSH auth method: private key
==> c02: Machine booted and ready!
==> c02: Checking for guest additions in VM...
==> c02: Setting hostname...
==> c02: Configuring and enabling network interfaces...
==> c02: Mounting shared folders...
    c02: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> c02: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> c02: Running provisioner: shell...
    c02: Running: inline script
    c02: [preflight] Running pre-flight checks
    c02: [preflight] Reading configuration from the cluster...
    c02: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
    c02: [preflight] Running pre-flight checks before initializing the new control plane instance
    c02: [preflight] Pulling images required for setting up a Kubernetes cluster
    c02: [preflight] This might take a minute or two, depending on the speed of your internet connection
    c02: [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    c02: [download-certs] Downloading the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
    c02: [certs] Using certificateDir folder "/etc/kubernetes/pki"
    c02: [certs] Generating "etcd/server" certificate and key
    c02: [certs] etcd/server serving cert is signed for DNS names [c02 localhost] and IPs [192.168.10.102 127.0.0.1 ::1]
    c02: [certs] Generating "etcd/peer" certificate and key
    c02: [certs] etcd/peer serving cert is signed for DNS names [c02 localhost] and IPs [192.168.10.102 127.0.0.1 ::1]
    c02: [certs] Generating "etcd/healthcheck-client" certificate and key
    c02: [certs] Generating "apiserver-etcd-client" certificate and key
    c02: [certs] Generating "apiserver" certificate and key
    c02: [certs] apiserver serving cert is signed for DNS names [c02 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.102 192.168.10.10]
    c02: [certs] Generating "apiserver-kubelet-client" certificate and key
    c02: [certs] Generating "front-proxy-client" certificate and key
    c02: [certs] Valid certificates and keys now exist in "/etc/kubernetes/pki"
    c02: [certs] Using the existing "sa" key
    c02: [kubeconfig] Generating kubeconfig files
    c02: [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    c02: [kubeconfig] Writing "admin.conf" kubeconfig file
    c02: [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    c02: [kubeconfig] Writing "scheduler.conf" kubeconfig file
    c02: [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    c02: [control-plane] Creating static Pod manifest for "kube-apiserver"
    c02: [control-plane] Creating static Pod manifest for "kube-controller-manager"
    c02: [control-plane] Creating static Pod manifest for "kube-scheduler"
    c02: [check-etcd] Checking that the etcd cluster is healthy
    c02: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    c02: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    c02: [kubelet-start] Starting the kubelet
    c02: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    c02: [etcd] Announced new etcd member joining to the existing etcd cluster
    c02: [etcd] Creating static Pod manifest for "etcd"
    c02: [etcd] Waiting for the new etcd member to join the cluster. This can take up to 40s
    c02: [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    c02: [mark-control-plane] Marking the node c02 as control-plane by adding the labels: [node-role.kubernetes.io/master(deprecated) node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
    c02: [mark-control-plane] Marking the node c02 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    c02:
    c02: This node has joined the cluster and a new control plane instance was created:
    c02:
    c02: * Certificate signing request was sent to apiserver and approval was received.
    c02: * The Kubelet was informed of the new secure connection details.
    c02: * Control plane (master) label and taint were applied to the new node.
    c02: * The Kubernetes control plane instances scaled up.
    c02: * A new etcd member was added to the local/stacked etcd cluster.
    c02:
    c02: To start administering your cluster from this node, you need to run the following as a regular user:
    c02:
    c02: 	mkdir -p $HOME/.kube
    c02: 	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    c02: 	sudo chown $(id -u):$(id -g) $HOME/.kube/config
    c02:
    c02: Run 'kubectl get nodes' to see this node join the cluster.
==> c03: Cloning VM...
==> c03: Matching MAC address for NAT networking...
==> c03: Setting the name of the VM: kubeadm-ha-stacked-vagrant_c03_1621334245080_55566
==> c03: Fixed port collision for 22 => 2222. Now on port 2203.
==> c03: Clearing any previously set network interfaces...
==> c03: Preparing network interfaces based on configuration...
    c03: Adapter 1: nat
    c03: Adapter 2: hostonly
==> c03: Forwarding ports...
    c03: 22 (guest) => 2203 (host) (adapter 1)
==> c03: Running 'pre-boot' VM customizations...
==> c03: Booting VM...
==> c03: Waiting for machine to boot. This may take a few minutes...
    c03: SSH address: 127.0.0.1:2203
    c03: SSH username: vagrant
    c03: SSH auth method: private key
==> c03: Machine booted and ready!
==> c03: Checking for guest additions in VM...
==> c03: Setting hostname...
==> c03: Configuring and enabling network interfaces...
==> c03: Mounting shared folders...
    c03: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> c03: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> c03: Running provisioner: shell...
    c03: Running: inline script
    c03: [preflight] Running pre-flight checks
    c03: [preflight] Reading configuration from the cluster...
    c03: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
    c03: [preflight] Running pre-flight checks before initializing the new control plane instance
    c03: [preflight] Pulling images required for setting up a Kubernetes cluster
    c03: [preflight] This might take a minute or two, depending on the speed of your internet connection
    c03: [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
    c03: [download-certs] Downloading the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
    c03: [certs] Using certificateDir folder "/etc/kubernetes/pki"
    c03: [certs] Generating "front-proxy-client" certificate and key
    c03: [certs] Generating "etcd/peer" certificate and key
    c03: [certs] etcd/peer serving cert is signed for DNS names [c03 localhost] and IPs [192.168.10.103 127.0.0.1 ::1]
    c03: [certs] Generating "etcd/healthcheck-client" certificate and key
    c03: [certs] Generating "apiserver-etcd-client" certificate and key
    c03: [certs] Generating "etcd/server" certificate and key
    c03: [certs] etcd/server serving cert is signed for DNS names [c03 localhost] and IPs [192.168.10.103 127.0.0.1 ::1]
    c03: [certs] Generating "apiserver" certificate and key
    c03: [certs] apiserver serving cert is signed for DNS names [c03 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.10.103 192.168.10.10]
    c03: [certs] Generating "apiserver-kubelet-client" certificate and key
    c03: [certs] Valid certificates and keys now exist in "/etc/kubernetes/pki"
    c03: [certs] Using the existing "sa" key
    c03: [kubeconfig] Generating kubeconfig files
    c03: [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
    c03: [kubeconfig] Writing "admin.conf" kubeconfig file
    c03: [kubeconfig] Writing "controller-manager.conf" kubeconfig file
    c03: [kubeconfig] Writing "scheduler.conf" kubeconfig file
    c03: [control-plane] Using manifest folder "/etc/kubernetes/manifests"
    c03: [control-plane] Creating static Pod manifest for "kube-apiserver"
    c03: [control-plane] Creating static Pod manifest for "kube-controller-manager"
    c03: [control-plane] Creating static Pod manifest for "kube-scheduler"
    c03: [check-etcd] Checking that the etcd cluster is healthy
    c03: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    c03: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    c03: [kubelet-start] Starting the kubelet
    c03: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    c03: [etcd] Announced new etcd member joining to the existing etcd cluster
    c03: [etcd] Creating static Pod manifest for "etcd"
    c03: [etcd] Waiting for the new etcd member to join the cluster. This can take up to 40s
    c03: [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
    c03: [mark-control-plane] Marking the node c03 as control-plane by adding the labels: [node-role.kubernetes.io/master(deprecated) node-role.kubernetes.io/control-plane node.kubernetes.io/exclude-from-external-load-balancers]
    c03: [mark-control-plane] Marking the node c03 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
    c03:
    c03: This node has joined the cluster and a new control plane instance was created:
    c03:
    c03: * Certificate signing request was sent to apiserver and approval was received.
    c03: * The Kubelet was informed of the new secure connection details.
    c03: * Control plane (master) label and taint were applied to the new node.
    c03: * The Kubernetes control plane instances scaled up.
    c03: * A new etcd member was added to the local/stacked etcd cluster.
    c03:
    c03: To start administering your cluster from this node, you need to run the following as a regular user:
    c03:
    c03: 	mkdir -p $HOME/.kube
    c03: 	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    c03: 	sudo chown $(id -u):$(id -g) $HOME/.kube/config
    c03:
    c03: Run 'kubectl get nodes' to see this node join the cluster.
==> e01: Cloning VM...
==> e01: Matching MAC address for NAT networking...
==> e01: Setting the name of the VM: kubeadm-ha-stacked-vagrant_e01_1621334294545_69035
==> e01: Fixed port collision for 22 => 2222. Now on port 2204.
==> e01: Clearing any previously set network interfaces...
==> e01: Preparing network interfaces based on configuration...
    e01: Adapter 1: nat
    e01: Adapter 2: hostonly
==> e01: Forwarding ports...
    e01: 22 (guest) => 2204 (host) (adapter 1)
==> e01: Running 'pre-boot' VM customizations...
==> e01: Booting VM...
==> e01: Waiting for machine to boot. This may take a few minutes...
    e01: SSH address: 127.0.0.1:2204
    e01: SSH username: vagrant
    e01: SSH auth method: private key
==> e01: Machine booted and ready!
==> e01: Checking for guest additions in VM...
==> e01: Setting hostname...
==> e01: Configuring and enabling network interfaces...
==> e01: Mounting shared folders...
    e01: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> e01: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> e01: Running provisioner: shell...
    e01: Running: inline script
    e01: [preflight] Running pre-flight checks
    e01: [preflight] Reading configuration from the cluster...
    e01: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
    e01: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    e01: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    e01: [kubelet-start] Starting the kubelet
    e01: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    e01:
    e01: This node has joined the cluster:
    e01: * Certificate signing request was sent to apiserver and a response was received.
    e01: * The Kubelet was informed of the new secure connection details.
    e01:
    e01: Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
==> e02: Cloning VM...
==> e02: Matching MAC address for NAT networking...
==> e02: Setting the name of the VM: kubeadm-ha-stacked-vagrant_e02_1621334337913_55725
==> e02: Fixed port collision for 22 => 2222. Now on port 2205.
==> e02: Clearing any previously set network interfaces...
==> e02: Preparing network interfaces based on configuration...
    e02: Adapter 1: nat
    e02: Adapter 2: hostonly
==> e02: Forwarding ports...
    e02: 22 (guest) => 2205 (host) (adapter 1)
==> e02: Running 'pre-boot' VM customizations...
==> e02: Booting VM...
==> e02: Waiting for machine to boot. This may take a few minutes...
    e02: SSH address: 127.0.0.1:2205
    e02: SSH username: vagrant
    e02: SSH auth method: private key
==> e02: Machine booted and ready!
==> e02: Checking for guest additions in VM...
==> e02: Setting hostname...
==> e02: Configuring and enabling network interfaces...
==> e02: Mounting shared folders...
    e02: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> e02: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> e02: Running provisioner: shell...
    e02: Running: inline script
    e02: [preflight] Running pre-flight checks
    e02: [preflight] Reading configuration from the cluster...
    e02: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
    e02: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    e02: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    e02: [kubelet-start] Starting the kubelet
    e02: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    e02:
    e02: This node has joined the cluster:
    e02: * Certificate signing request was sent to apiserver and a response was received.
    e02: * The Kubelet was informed of the new secure connection details.
    e02:
    e02: Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
==> e03: Cloning VM...
==> e03: Matching MAC address for NAT networking...
==> e03: Setting the name of the VM: kubeadm-ha-stacked-vagrant_e03_1621334375951_31396
==> e03: Fixed port collision for 22 => 2222. Now on port 2206.
==> e03: Clearing any previously set network interfaces...
==> e03: Preparing network interfaces based on configuration...
    e03: Adapter 1: nat
    e03: Adapter 2: hostonly
==> e03: Forwarding ports...
    e03: 22 (guest) => 2206 (host) (adapter 1)
==> e03: Running 'pre-boot' VM customizations...
==> e03: Booting VM...
==> e03: Waiting for machine to boot. This may take a few minutes...
    e03: SSH address: 127.0.0.1:2206
    e03: SSH username: vagrant
    e03: SSH auth method: private key
==> e03: Machine booted and ready!
==> e03: Checking for guest additions in VM...
==> e03: Setting hostname...
==> e03: Configuring and enabling network interfaces...
==> e03: Mounting shared folders...
    e03: /vagrant => /Users/lothar/GitHub/kubeadm-ha-stacked-vagrant
==> e03: [vagrant-hostmanager:guests] Updating hosts file on active guest virtual machines...
==> e03: Running provisioner: shell...
    e03: Running: inline script
    e03: [preflight] Running pre-flight checks
    e03: [preflight] Reading configuration from the cluster...
    e03: [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
    e03: [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
    e03: [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
    e03: [kubelet-start] Starting the kubelet
    e03: [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
    e03:
    e03: This node has joined the cluster:
    e03: * Certificate signing request was sent to apiserver and a response was received.
    e03: * The Kubelet was informed of the new secure connection details.
    e03:
    e03: Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
+ sleep 60
+ vagrant ssh c01 -c 'sudo kubectl get nodes'
NAME   STATUS   ROLES                  AGE     VERSION
c01    Ready    control-plane,master   4m52s   v1.21.1
c02    Ready    control-plane,master   4m9s    v1.21.1
c03    Ready    control-plane,master   3m10s   v1.21.1
e01    Ready    <none>                 2m18s   v1.21.1
e02    Ready    <none>                 100s    v1.21.1
e03    Ready    <none>                 63s     v1.21.1
Connection to 127.0.0.1 closed.
asciinema: recording finished
asciinema: asciicast saved to demo.cast
+ asciicast2gif demo.cast demo.gif
==> Loading demo.cast...
==> Spawning PhantomJS renderer...
==> Generating frame screenshots...
==> Combining 262 screenshots into GIF file...
gifsicle: warning: huge GIF, conserving memory (processing may take a while)
==> Done.
+ gifsicle --colors 8 --resize 800x600 demo.gif
gifsicle: warning: huge GIF, conserving memory (processing may take a while)
+ rm -f demo.cast demo.gif
> 
```
