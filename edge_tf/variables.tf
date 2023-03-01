### Aviatrix Controller ###

variable "ctrl_username" {
  type = string
}

variable "ctrl_password" {
  type = string
}

variable "ctrl_ip" {
  type = string
}

variable "aws_ctrl_account_name" {
  type = string
}

### AWS ###

variable "aws_profile" {
  type = string
}

variable "aws_region" {
  type = string
}

### Aviatrix Edge ###

variable "side_id" {
  type = string
}

variable "edge_gw_name" {
  type = string
}

variable "lan_interface_prefix" {
  type = string
}

variable "wan_default_gateway_ip" {
  type = string
}

variable "wan_interface_ip_prefix" {
  type = string
}

variable "transit_gws_enable_over_private_network" {
  type = string
}

variable "management_interface_config" {
  type = string
}


variable "avx_transit_gw" {
  type = string
}

variable "avx_transit_gw_attached" {
  type    = bool
  default = false
}

variable "edge_local_as_number" {
  type = string
}

variable "ztp_file_type" {
  type = string
}

variable "ztp_file_download_path" {
  type = string
}

variable "enable_transitive_routing" {
  type = string
}