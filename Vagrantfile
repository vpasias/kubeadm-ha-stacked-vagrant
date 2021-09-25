KUBERNETES_VERSION = ENV["KUBERNETES_VERSION"]

BOX_IMAGE = "k8s-#{KUBERNETES_VERSION}"

CONTROL_PLANE_IP      = "192.168.10.10"
LB_COUNT              = 2
CONTROLLER_COUNT      = 3
EXECUTOR_COUNT        = 3
LB_IP_PREFIX          = "192.168.10.1"
CONTROLLER_IP_PREFIX  = "192.168.10.10"
EXECUTOR_IP_PREFIX    = "192.168.10.20"
STORAGE_IP_PREFIX     = "192.168.20.10"

POD_NW_CIDR = "10.244.0.0/16"

TOKEN = "abcdef.0123456789abcdef"

# To be able to add extra disks. To include: /dev/sdb with name: data
ENV['VAGRANT_EXPERIMENTAL'] = 'disks'

$common = <<EOF
lsblk
dnf -y install cloud-utils-growpart gdisk
growpart /dev/sda 2
lsblk
xfs_growfs /
df -hT | grep /dev/sda
EOF

$loadbalancer = <<EOF
sysctl -w net.ipv4.ip_forward=1       > /dev/null 2>&1
sysctl -w net.ipv4.ip_nonlocal_bind=1 > /dev/null 2>&1
cp /vagrant/lb/haproxy.cfg /etc/haproxy/haproxy.cfg
cp /vagrant/lb/keepalived.${HOSTNAME}.cfg /etc/keepalived/keepalived.conf
systemctl enable --now haproxy        > /dev/null 2>&1
systemctl enable --now keepalived     > /dev/null 2>&1
EOF

$initcontroller = <<EOF
# set -x
kubeadm init \
  --apiserver-advertise-address=192.168.10.101 \
  --control-plane-endpoint=#{CONTROL_PLANE_IP} \
  --pod-network-cidr=#{POD_NW_CIDR} \
  --token #{TOKEN} \
  --upload-certs \
  | tee /vagrant/params/kubeadm.log

kubeadm token list | grep authentication | awk '{print $1;}' >/vagrant/params/token
openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | \
  openssl rsa -pubin -outform DER 2>/dev/null | \ sha256sum | \
    cut -d' ' -f1 >/vagrant/params/discovery-token-ca-cert-hash
grep 'certificate-key' /vagrant/params/kubeadm.log | head -n1 | awk '{print $3}' >/vagrant/params/certificate-key

mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
#curl https://docs.projectcalico.org/manifests/calico-typha.yaml -o calico.yaml
#kubectl apply -f calico.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc5/aio/deploy/recommended.yaml

PATH=$PATH:/usr/local/bin
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "******** End of procedure ********"
EOF

$joincontroller = <<EOF
# set -x
TOKEN=`cat /vagrant/params/token`
DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/params/discovery-token-ca-cert-hash`
CERTIFICATE_KEY=`cat /vagrant/params/certificate-key`
kubeadm join #{CONTROL_PLANE_IP}:6443 \
  --control-plane \
  --apiserver-advertise-address $(/sbin/ip -o -4 addr list eth1 | awk '{print $4}' | cut -d/ -f1) \
  --token ${TOKEN} \
  --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH} \
  --certificate-key ${CERTIFICATE_KEY}

echo "******** End of procedure ********"
EOF

$joinexecutor = <<EOF
TOKEN=`cat /vagrant/params/token`
DISCOVERY_TOKEN_CA_CERT_HASH=`cat /vagrant/params/discovery-token-ca-cert-hash`
kubeadm join #{CONTROL_PLANE_IP}:6443 \
  --token ${TOKEN} \
  --discovery-token-ca-cert-hash sha256:${DISCOVERY_TOKEN_CA_CERT_HASH}

echo "******** End of procedure ********"
EOF

Vagrant.configure("2") do |config|

  config.vm.box               = BOX_IMAGE
  config.vm.box_check_update  = false
  config.vbguest.auto_update  = false

  config.vm.provider "virtualbox" do |vbox|
    vbox.cpus           = 2
    vbox.memory         = "8192"
    vbox.linked_clone   = true
    vbox.customize ["modifyvm", :id, "--chipset", "ich9"]
    vbox.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
    vbox.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.1", "1"]
    vbox.customize ["setextradata", :id, "VBoxInternal/CPUM/SSE4.2", "1"]
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_guest = true
  
  (1..LB_COUNT).each do |i|
    config.vm.define "lb0#{i}" do |lb|
      lb.vm.box      = "lb"
      lb.vm.hostname = "lb0#{i}"
      lb.vm.network :private_network, ip: LB_IP_PREFIX + "#{i}"
      lb.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 2
        vbox.memory = 8192             
      end
      lb.vm.provision :shell, inline: $loadbalancer
    end
  end

  (1..CONTROLLER_COUNT).each do |i|
    config.vm.define "c0#{i}" do |controller|
      controller.vm.hostname = "c0#{i}"
      controller.disksize.size = "120GB"	    
      controller.vm.network :private_network, ip: CONTROLLER_IP_PREFIX + "#{i}"
      controller.vm.disk :disk, size: "200GB", name: "data" 
      controller.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 4
        vbox.memory = 16384
      end
      controller.vm.provision :shell, inline: $common
      if i == 1
        controller.vm.provision :shell, inline: $initcontroller
      else
        controller.vm.provision :shell, inline: $joincontroller
      end	    
    end
  end
 
  (1..EXECUTOR_COUNT).each do |i|
    config.vm.define "e0#{i}" do |executor|
      executor.vm.hostname = "e0#{i}"
      executor.disksize.size = "120GB"	    
      executor.vm.network :private_network, ip: EXECUTOR_IP_PREFIX + "#{i}"
      executor.vm.network :private_network, ip: STORAGE_IP_PREFIX + "#{i}"
      executor.vm.disk :disk, size: "200GB", name: "data" 	    
      executor.vm.provider :virtualbox do |vbox|
        vbox.cpus   = 8
        vbox.memory = 32768
      end
      executor.vm.provision :shell, inline: $common      
      executor.vm.provision :shell, inline: $joinexecutor	    
    end
  end

# Additional functions/applications	
  (1..CONTROLLER_COUNT).each do |i|
    config.vm.define "c0#{i}" do |controller|
      if i == 1
      controller.vm.provision :shell, path: "monitoring-install.sh"	   
      #	controller.vm.provision :shell, path: "openebs-install.sh"
      # controller.vm.provision :shell, path: "rook-install.sh"
      # controller.vm.provision :shell, path: "harvester-install.sh"
      # controller.vm.provision :shell, path: "storage_os-install.sh"
      end	    
    end
  end
  
end
