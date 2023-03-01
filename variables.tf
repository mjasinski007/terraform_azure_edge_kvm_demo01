variable "azure_subscription_id" {
    type = string
}

variable "azure_client_id" {
    type = string
}

variable "azure_client_secret" {
    type = string
}

variable "azure_tenant_id" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "vnet_name" {
    type = string
}

variable "location" {
    type = string
}

variable "vnet_cidr" {
    type = string
}

variable "kvm_srv_pip_name" {
    type = string
}

variable "kvm_srv_mgmt_nic_name" {
    type = string
}

variable "kvm_srv_wan_nic_name" {
    type = string
}


variable "kvm_srv_vm_name" {
    type = string
}

variable "kvm_srv_instance_type" {
    type = string
}


variable "admin_username" {
    type = string
}

variable "admin_password" {
    type = string
}


/* variable "csr_hostname" {
    type = string
} */

/* variable "csr_mgmt_pip_name" {
    type = string
}

variable "csr_mgmt_nic_name" {
    type = string
} */
/* 
variable "csr_lan_nic_name" {
    type = string
}

variable "csr_instance_type" {
    type = string
}

variable "bastion_pip" {
    type = string
}

variable "bastion_host_name" {
    type = string
} */