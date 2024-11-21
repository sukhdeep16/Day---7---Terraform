provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

# Backend Configuration - Tell Terraform to use Azure Blob Storage for the state file

terraform {
  backend "azurerm" {
    resource_group_name   = "Terraform"
    storage_account_name  = "mystorageaccountsukhi"
    container_name        = "ci-cd"
    key                   = "first-cicd.tfstate"
  }
}
