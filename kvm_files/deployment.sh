#!/bin/bash

#set -x

echo ">>>> Download CSR Image <<<<"
#sudo wget https://pubstorage8899.s3.eu-west-2.amazonaws.com/csr1000v-universalk9.17.03.03-serial.qcow2 -P /var/lib/libvirt/images/

echo ">>>> Download Aviatrix Edge 2.0 Image <<<<"
sudo wget https://pubstorage8899.s3.eu-west-2.amazonaws.com/avx-edge-gateway-kvm-2022-10-26.qcow2 -P /var/lib/libvirt/images/

echo ">>>> Download Ubuntu Image <<<<"
#sudo wget https://pubstorage8899.s3.eu-west-2.amazonaws.com/bionic-server-cloudimg-amd64.img -P /var/lib/libvirt/images/


echo ">>>> Create CSR Bootstrap <<<<"
#sudo cd /home/ubuntu/kvm_files
#sudo mkisofs -l -o /var/lib/libvirt/images/csr_bootstrap.iso /home/ubuntu/kvm_files/csr_Initial_config.xml

echo ">>>> Deploy Cisco CSR Instance <<<<"
#sudo virsh define csr_kvm_vm.xml
#sudo virsh start vCSR-R01 && sudo virsh autostart vCSR-R01

# echo ">>> Deploy Ubuntu instance <<<<"
# sudo virsh define vcsr_kvm_vm.xml
# sudo virsh start vCSR-R01 && sudo virsh autostart vCSR-R01


echo ">>> Generate Aviatrix Edge Bootstrap Image (Terraform) <<<<"
cd /home/ubuntu/edge_tf
sudo terraform init && sudo terraform apply --auto-approve

echo ">>>> Rename Generated ZTP ISO file <<<<"
sudo find ./ -type f -name '*.iso' -exec mv {} ztp.iso \; && sudo mv ztp.iso /var/lib/libvirt/images

sleep 5

echo ">>>> Deploy Aviatrix Edge Instance <<<<"
cd /home/ubuntu/kvm_files
sudo virsh define avx-edge-gw01.xml
sudo virsh start avx-edge-kvm-gw01 && sudo virsh autostart avx-edge-kvm-gw01


exit 0