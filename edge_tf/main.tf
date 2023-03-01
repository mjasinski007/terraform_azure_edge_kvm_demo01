data "http" "my_public_ip" {
    url = "http://ipv4.icanhazip.com"
}

resource "aviatrix_edge_spoke" "edge_esx_gw01" {
    gw_name                     = var.edge_gw_name
    site_id                     = var.side_id
    management_interface_config = "DHCP"
    wan_interface_ip_prefix     = var.wan_interface_ip_prefix                # Assigned to Edge GW
    wan_default_gateway_ip      = var.wan_default_gateway_ip
    wan_public_ip               = "${chomp(data.http.my_public_ip.body)}" # Assigned to WAN KVM Network
    management_egress_ip_prefix = "${chomp(data.http.my_public_ip.body)}/32" # my Public IP
    lan_interface_ip_prefix     = var.lan_interface_prefix                   # Assigned to Edge GW
    ztp_file_type               = var.ztp_file_type
    ztp_file_download_path      = var.ztp_file_download_path
    local_as_number             = var.edge_local_as_number
}
