# Resource group
module "resource_group" {
  source   = "./modules/resource_group"
  rg_name  = var.rg_name
  location = var.location
}

#############################################################
# Network
module "network" {
  source              = "./modules/network"
  vnet_name           = "test-vnet"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["subnet1", "subnet2"]
}

#############################################################
# Virtual Machine
module "vm_apache" {
  source              = "./modules/vm_apache"
  vm_name             = var.vm_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  subnet_id           = module.network.subnet_ids[0]
  admin_username      = var.admin_username
  ssh_public_key      = file("~/.ssh/id_rsa.pub")

  depends_on = [module.network]
}

#############################################################
# PostgreSQL
module "postgresql" {
  source         = "./modules/postgresql"
  server_name    = var.pg_server_name
  database_name  = var.pg_db_name
  resource_group = module.resource_group.resource_group_name
  admin_user     = var.pg_admin_user
  admin_password = var.pg_admin_password
  log_analytics_workspace_id = module.log_analytics.workspace_id 

  depends_on = [module.resource_group]

}


#############################################################
# Azure Container Registry
module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  aks_principal_id    =  "" #module.cluster_identity_principal_id #si il y a aks alors on ajoute module.aks

  depends_on = [module.resource_group, module.storage] #si il y a aks alors on ajoute module.aks
}


#############################################################
# Storage Account
module "storage" {
  source               = "./modules/storage-account"
  storage_account_name = var.storage_account_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  depends_on = [module.resource_group]
}

#############################################################
# Log Analytics
module "log_analytics" {
  source              = "./modules/log-analytics"
  workspace_name      = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name

  depends_on = [module.resource_group]
}
#############################################################
# AKS
module "aks" {
  source                     = "./modules/aks"
  cluster_name               = var.aks_cluster_name
  location                   = var.location
  resource_group_name        = module.resource_group.resource_group_name
  dns_prefix                 = var.aks_dns_prefix
  node_count                 = var.aks_node_count
  kubernetes_version         = var.kubernetes_version
  log_analytics_workspace_id = module.log_analytics.workspace_id

  depends_on = [module.resource_group, module.log_analytics]
}

#############################################################
# Kubernetes Backend
module "k8s_backend" {
  source = "./modules/k8s-backend"

  acr_server                        = module.acr.login_server
  pg_hostname                       = module.postgresql.server_name
  postgresql_server_admin_login     = var.postgresql_server_admin_login
  postgresql_server_admin_password  = var.postgresql_server_admin_password
  app_insights_connection_string    = module.application_insights.connection_string
  log_analytics_workspace_id        = module.log_analytics.workspace_id

  depends_on = [
    module.postgresql,
    module.acr,
    module.log_analytics
  ]
}

module "application_insights" {
  source              = "./modules/application-insights"
  name                = "test-rg-appinsights"  # Based on your existing resource group name
  location            = var.location
  resource_group_name = "test-rg"  # Your existing resource group name
  workspace_id        = module.log_analytics.workspace_id
}

#############################################################
module "monitoring" {
  source = "./modules/monitoring"
  
  depends_on = [module.aks]
}

#############################################################

module "ingress_nginx" {
  source = "./modules/ingress-nginx-front"
  
  resource_group_name = module.resource_group.name
  location           = var.location

  depends_on = [module.aks]
}