
resource "azurerm_resource_group" "az_avx_edge_kvm_rg" {
    name     = var.resource_group_name
    location = var.location
}

resource "azurerm_network_security_group" "avx_edge_kvm_nic0_nsg" {
    name                = "avx-edge-kvm-nsg"
    resource_group_name = azurerm_resource_group.az_avx_edge_kvm_rg.name
    location            = azurerm_resource_group.az_avx_edge_kvm_rg.location
    #depends_on          = [azurerm_network_interface.kvm_srv_nic]
}

resource "azurerm_network_security_rule" "avx_edge_kvm_nic0_ssh_rule" {
    access                      = "Allow"
    direction                   = "Inbound"
    name                        = "ssh_rule"
    priority                    = 110
    protocol                    = "Tcp"
    source_port_range           = "*"
    source_address_prefix       = "*"
    destination_port_range      = "22"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_security_group_name = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.name
}

resource "azurerm_network_security_rule" "avx_edge_kvm_nic0_https_rule" {
    access                      = "Allow"
    direction                   = "Inbound"
    name                        = "https_rule"
    priority                    = 120
    protocol                    = "Tcp"
    source_port_range           = "*"
    source_address_prefix       = "*"
    destination_port_range      = "443"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_security_group_name = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.name
}

resource "azurerm_network_security_rule" "avx_edge_kvm_nic0_dns_rule" {
    access                      = "Allow"
    direction                   = "Inbound"
    name                        = "dns_rule"
    priority                    = 130
    protocol                    = "Udp"
    source_port_range           = "*"
    source_address_prefix       = "*"
    destination_port_range      = "53"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_security_group_name = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.name
}

resource "azurerm_network_security_rule" "avx_edge_kvm_nic0_syslog_rule" {
    access                      = "Allow"
    direction                   = "Inbound"
    name                        = "syslog_rule"
    priority                    = 140
    protocol                    = "Udp"
    source_port_range           = "*"
    source_address_prefix       = "*"
    destination_port_range      = "5000"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_security_group_name = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.name
}

resource "azurerm_network_security_rule" "avx_edge_kvm_nic0_netflow_rule" {
    access                      = "Allow"
    direction                   = "Inbound"
    name                        = "netflow_rule"
    priority                    = 150
    protocol                    = "Udp"
    source_port_range           = "*"
    source_address_prefix       = "*"
    destination_port_range      = "31283"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_security_group_name = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.name
}

resource "azurerm_network_security_rule" "avx_edge_kvm_nic0_rdp_rule" {
    access                      = "Allow"
    direction                   = "Inbound"
    name                        = "rdp_rule"
    priority                    = 160
    protocol                    = "Tcp"
    source_port_range           = "*"
    source_address_prefix       = "*"
    destination_port_range      = "3389"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_security_group_name = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.name
}



resource "azurerm_virtual_network" "avx_edge_kvm_vnet" {
    name                = var.vnet_name
    location            = azurerm_resource_group.az_avx_edge_kvm_rg.location
    resource_group_name = azurerm_resource_group.az_avx_edge_kvm_rg.name
    address_space       = [var.vnet_cidr]
}


resource "azurerm_subnet" "avx_edge_kvm_public_subnet" {
    name                 = "kvm_public_subnet"
    resource_group_name  = azurerm_resource_group.az_avx_edge_kvm_rg.name
    virtual_network_name = azurerm_virtual_network.avx_edge_kvm_vnet.name
    address_prefixes     = ["10.210.1.0/24"]
}


/* 
resource "azurerm_subnet" "bastion_subnet" {
    name                 = "AzureBastionSubnet"
    resource_group_name  = azurerm_resource_group.az_kvm_avx_edge_rg.name
    virtual_network_name = azurerm_virtual_network.az_kvm_avx_edge_vnet.name
    address_prefixes     = ["10.210.2.0/24"]
} */


resource "azurerm_public_ip" "avx_edge_kvm_pip"   {
    name                = var.kvm_srv_pip_name
    location            = azurerm_resource_group.az_avx_edge_kvm_rg.location
    resource_group_name = azurerm_resource_group.az_avx_edge_kvm_rg.name
    sku                 = "Standard"
    allocation_method   = "Static"
}

resource "azurerm_network_interface" "avx_edge_kvm_nic0"   {
    name                =   var.kvm_srv_mgmt_nic_name
    location            =   azurerm_resource_group.az_avx_edge_kvm_rg.location
    resource_group_name =   azurerm_resource_group.az_avx_edge_kvm_rg.name

    ip_configuration   {
        name                          = "avx_edge_kvm_ipconfig"
        subnet_id                     = azurerm_subnet.avx_edge_kvm_public_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.avx_edge_kvm_pip.id
    }

    #depends_on                      = [azurerm_public_ip.kvm_srv_pip]
}


resource "azurerm_linux_virtual_machine" "avx_edge_kvm_vm"   {
    name                            = var.kvm_srv_vm_name
    location                        = azurerm_resource_group.az_avx_edge_kvm_rg.location
    resource_group_name             = azurerm_resource_group.az_avx_edge_kvm_rg.name
    network_interface_ids           = [ azurerm_network_interface.avx_edge_kvm_nic0.id ]
    size                            = var.kvm_srv_instance_type
    computer_name                   = "AvxEdgeKVM"
    admin_username                  = var.admin_username
    admin_password                  = var.admin_password
    disable_password_authentication = false
    #depends_on                      = [azurerm_network_interface.kvm_srv_nic]

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    os_disk   {
        caching              =   "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    connection {
        #host     = "${azurerm_public_ip.avx_edge_kvm_pip.ip_address}"
        host     = "${azurerm_linux_virtual_machine.avx_edge_kvm_vm.public_ip_address}"
        type     = "ssh"
        user     = var.admin_username
        password = var.admin_password
        agent    = "false"
    }

    provisioner "file" {
        source      = "/Users/vmario/vDEVNET_Projects/14.AVIATRIX/01.AVIATRIX_GITHUB/02.Practice_Lab_Scenarios/terraform_azure_edge_kvm_demo01/edge_tf"
        destination = "/home/ubuntu/edge_tf"
    }

    provisioner "file" {
        source      = "/Users/vmario/vDEVNET_Projects/14.AVIATRIX/01.AVIATRIX_GITHUB/02.Practice_Lab_Scenarios/terraform_azure_edge_kvm_demo01/kvm_files"
        destination = "/home/ubuntu/kvm_files"
    }

    #custom_data = base64encode(data.template_file.intial_cloud_init.rendered)
    custom_data = base64encode(data.template_file.initial_kvm_bootstrap.rendered)
}


resource "null_resource" "execute_script" {

    provisioner "remote-exec" {
        inline = [
            "cd /home/ubuntu/kvm_files",
            "sudo chmod +x deployment.sh",
            #"./initial_kvm_setup.sh",
        ]
        connection {
            #host     = "${azurerm_public_ip.avx_edge_kvm_pip.ip_address}"
            host     = "${azurerm_linux_virtual_machine.avx_edge_kvm_vm.public_ip_address}"
            type     = "ssh"
            user     = var.admin_username
            password = var.admin_password
            agent    = "false"
        }
    }
    depends_on = [azurerm_linux_virtual_machine.avx_edge_kvm_vm]
}




#







    /* provisioner "remote-exec" {
        inline = [
            "cd /home/ubuntu",
            "sudo mkdir myData",
            "sudo mkdir myData/kvm_files",
            "sudo mkdir myData/edge_tf",
            "sudo chown -R ubuntu myData"
        ]
        connection {
            #host     = "${azurerm_public_ip.avx_edge_kvm_pip.ip_address}"
            host     = "${azurerm_linux_virtual_machine.avx_edge_kvm_vm.public_ip_address}"
            type     = "ssh"
            user     = var.admin_username
            password = var.admin_password
            agent    = "false"
        }
    } */


   
/* resource "tls_private_key" "my_pub_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}




resource "ssh_resource" "init" {
    when         = "create"
    host         = "${azurerm_linux_virtual_machine.avx_edge_kvm_vm.public_ip_address}"
    user         = var.admin_username
    password     = var.admin_password
    private_key  = tls_private_key.my_pub_key.id
    agent        = false

    commands = [
        "/home/ubuntu/myData/initial_kvm_setup.sh"
    ]
    depends_on  = [azurerm_linux_virtual_machine.avx_edge_kvm_vm, tls_private_key.my_pub_key]
}
 */











resource "azurerm_network_interface_security_group_association" "avx_edge_kvm_nic0_nsg_assoc" {
    network_interface_id      = azurerm_network_interface.avx_edge_kvm_nic0.id
    network_security_group_id = azurerm_network_security_group.avx_edge_kvm_nic0_nsg.id
    #depends_on                = [azurerm_network_interface.kvm_mgmt_nic]
}



/* resource "null_resource" "copy_txt_file" {

  provisioner "file" {
    source      = "test.txt"
    destination = "/home/ubuntu/kvm/test_copied.txt"
  }

  connection {
    host     = azurerm_public_ip.avx_edge_kvm_pip.ip_address
    #host     = "${azurerm_linux_virtual_machine.avx_edge_kvm_vm.public_ip_address}"
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    agent    = "false"
  }
} */
