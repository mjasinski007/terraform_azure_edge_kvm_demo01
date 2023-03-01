terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.0.0"
        }
        ssh = {
            source = "loafoe/ssh"
        }
    }
    required_version = ">= 1.0"
}