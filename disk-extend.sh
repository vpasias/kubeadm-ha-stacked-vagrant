#!/bin/bash
# https://marcbrandner.com/blog/increasing-disk-space-of-a-linux-based-vagrant-box-on-provisioning/
echo "> Installing required tools for file system management"
if  [ -n "$(command -v dnf)" ]; then
    echo ">> Detected dnf-based Linux"
    sudo dnf makecache
    sudo dnf install --assumeyes --nogpgcheck util-linux
    sudo dnf install --assumeyes --nogpgcheck lvm2
    sudo dnf install --assumeyes --nogpgcheck e2fsprogs
fi
if [ -n "$(command -v apt-get)" ]; then
    echo ">> Detected apt-based Linux"
    sudo apt-get update -y
    sudo apt-get install -y fdisk
    sudo apt-get install -y lvm2
    sudo apt-get install -y e2fsprogs
fi
ROOT_DISK_DEVICE="/dev/sda"
ROOT_DISK_DEVICE_PART="/dev/sda1"
LV_PATH=`sudo lvdisplay -c | sed -n 1p | awk -F ":" '{print $1;}'`
FS_PATH=`df / | sed -n 2p | awk '{print $1;}'`
ROOT_FS_SIZE=`df -h / | sed -n 2p | awk '{print $2;}'`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
echo "> Increasing disk size of $ROOT_DISK_DEVICE to available maximum"
sudo fdisk $ROOT_DISK_DEVICE <<EOF
d 
2
n
p
2
2048

no
w
EOF
sudo pvresize $ROOT_DISK_DEVICE_PART
sudo lvextend -l +100%FREE $LV_PATH
sudo resize2fs -p $FS_PATH
ROOT_FS_SIZE=`df -h / | sed -n 2p | awk '{print $2;}'`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
sleep 10
exit 0
