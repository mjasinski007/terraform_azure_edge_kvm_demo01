### AWS Controller Location ###
aws_profile   = "169444603265"  #_!!! CHANGE ME !!!_#
aws_region    = "eu-west-2"


### Aviatrix Controller ###

ctrl_username         = "admin"
ctrl_password         = "Its@secret!23" #_!!! CHANGE ME !!!_#
ctrl_ip               = "3.10.92.20" #_!!! CHANGE ME !!!_#
aws_ctrl_account_name = "avtx_aws_account"

### Aviatrix Edge 2.0 ###

edge_gw_name                            = "avx-edge-kvm-gw01"
side_id                                 = "AzureNestedKVM"
management_interface_config             = "DHCP"
wan_interface_ip_prefix                 = "192.168.200.2/30"   # Assigned to Edge
wan_default_gateway_ip                  = "192.168.200.1"      # Assigned to upstream gateway
transit_gws_enable_over_private_network = false
#management_egress_ip_prefix             = "90.206.40.249/32"
lan_interface_prefix                    = "192.168.20.2/24"      # Assigned to Edge
edge_local_as_number                    = "64513"
enable_transitive_routing               = false
ztp_file_type                           = "iso"
ztp_file_download_path                  = "."
avx_transit_gw                          = "avx-aws-uk-transit-gw"
#avx_transit_gw_attached                = true # uncomment it when Edge gateway will be deployed