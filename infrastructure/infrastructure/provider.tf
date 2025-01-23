terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  resource_provider_registrations = "none"
}

# provider "kubernetes" {
#   host                   = module.aks.host
#   client_certificate     = module.aks.client_certificate
#   client_key             = module.aks.client_key
#   cluster_ca_certificate = module.aks.cluster_ca_certificate
# }

# provider "helm" {
#   kubernetes {
#     host                   = module.aks.host
#     client_certificate     = module.aks.client_certificate
#     client_key             = module.aks.client_key
#     cluster_ca_certificate = module.aks.cluster_ca_certificate
#   }
# }