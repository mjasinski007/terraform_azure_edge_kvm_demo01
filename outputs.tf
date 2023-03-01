output "ssh_connection" {
    value = "ssh ubuntu@${azurerm_linux_virtual_machine.avx_edge_kvm_vm.public_ip_address}"
}



