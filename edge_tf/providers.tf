provider "azurerm" {
    features {}
    skip_provider_registration = "true"
    subscription_id            = var.azure_subscription_id
    client_id                  = var.azure_client_id
    client_secret              = var.azure_client_secret
    tenant_id                  = var.azure_tenant_id
}

provider "aviatrix" {
    controller_ip = var.ctrl_ip
    username      = var.ctrl_username
    password      = var.ctrl_password
}

provider "aws" {
    profile = var.aws_profile
    region  = var.aws_region
}

