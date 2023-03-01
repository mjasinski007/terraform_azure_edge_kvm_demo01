### Azure (KVM Server) ### 

azure_subscription_id = "46604b85-cf80-46e4-9117-10f9000797f9"
azure_client_id       = "b76ef98d-276e-4627-9c22-7136073d4d51"
azure_client_secret   = "A6f7Q~XRy4q4GBnOYaDZiBQDJtg5KmlLyZyun"
azure_tenant_id       = "4780055e-ce37-4f02-b33d-fdad8493a4b6"

resource_group_name   = "az-avx-edge-kvm-rg"
vnet_name             = "az-avx-edge-kvm-vnet"
location              = "uksouth"
vnet_cidr             = "10.210.0.0/16"
kvm_srv_pip_name      = "kvmsrv-pubip"
kvm_srv_mgmt_nic_name = "kvmsrv-mgmt-nic"
kvm_srv_wan_nic_name  = "kvmsrv-lan-nic"
kvm_srv_vm_name       = "kvm-srv01"
kvm_srv_instance_type = "Standard_D4s_v3"

admin_username        = "ubuntu"
admin_password        = "Itsasecret!23"
