#!/bin/bash

#sudo hostnamectl set-hostname "k"
sudo apt update -y


echo ">>>> Install KVM and Required Packages <<<<"

sudo apt-get -y install bridge-utils qemu-kvm libvirt-daemon-system libvirt-clients \
inetutils-traceroute netstat-nat python3 python3-googleapi \
python3-libvirt apt-transport-https \
unzip git wget curl iputils-ping net-tools \
cpu-checker genisoimage cloud-image-utils 

echo ">>>> Configure KVM Environment <<<<"
sudo bash
sudo echo "ubuntu ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ubuntu
sudo usermod -a -G libvirt ubuntu
sudo usermod -a -G kvm ubuntu
sudo echo 'unix_sock_group = "libvirt"' >> /etc/libvirt/libvirtd.conf
sudo sed -i "s/^#\?ON_SHUTDOWN.*$/ON_SHUTDOWN=shutdown/g" /etc/default/libvirt-guests
sudo systemctl restart libvirtd.service

echo ">>>> Download KVM Network Configurations <<<<"

# Download KVM MGMT networking configurations
sudo wget https://gist.githubusercontent.com/mjasinski007/44ab6b7e9728cc67f57bf4610e3488ba/raw/a9c8986b933511dc8650dbd938ed62d2d824c6cf/avx-br-mgmt.xml -P /home/ubuntu/kvm_initial

# Download KVM WAN networking configurations
sudo wget https://gist.githubusercontent.com/mjasinski007/1c51e97596294b536cb7a01d45861b47/raw/6aa593ee3fee05a65fd52f1a4dffd7a31f8972c1/avx-br-wan.xml -P /home/ubuntu/kvm_initial

# Download KVM LAN networking configurations
sudo wget https://gist.githubusercontent.com/mjasinski007/dfed17f41b2cd1034a63001345ab9b61/raw/ed52ee78448b8f5f8125229d6757bb09e42aa46c/avx-br-lan.xml -P /home/ubuntu/kvm_initial

echo ">>>> KVM Network Installation<<<<"
# add avx-br-mgmt virtual network to libvirt for Management network Edge VM eth2
sudo virsh net-define /home/ubuntu/kvm_initial/avx-br-mgmt.xml && sudo virsh net-start avx-br-mgmt && sudo virsh net-autostart avx-br-mgmt

# add avx-br-wan virtual network to libvirt for WAN network Edge VM eth0
sudo virsh net-define /home/ubuntu/kvm_initial/avx-br-wan.xml && sudo virsh net-start avx-br-wan && sudo virsh net-autostart avx-br-wan

# add br-lan virtual network to libvirt for LAN network Edge VM eth1
sudo virsh net-define /home/ubuntu/kvm_initial/avx-br-lan.xml && sudo virsh net-start avx-br-lan && sudo virsh net-autostart avx-br-lan



echo ">>>> Install Terraform <<<<"

TF_VERSION="1.3.9"
TF_FILE="terraform_${TF_VERSION}_linux_amd64.zip"
wget https://releases.hashicorp.com/terraform/1.3.9/$TF_FILE
unzip $TF_FILE -d /usr/local/bin/


echo ">>>> Enable IP Forwarding <<<<"
sudo echo net.ipv4.ip_forward=1 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf


echo ">>>> Install XFCE Desktop <<<<"

sudo DEBIAN_FRONTEND=noninteractive apt-get -y install xfce4
sudo apt-get -y install xfce4-session xrdp virt-manager

sleep 2

sudo systemctl enable xrdp
sudo adduser xrdp ssl-cert
echo xfce4-session >~/.xsession
sudo service xrdp restart


echo ">>>> Clean up <<<<"
sudo apt autoremove