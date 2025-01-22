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

  depends_on = [module.resource_group]

}

#############################################################
#module "aks" {
#  source              = "./modules/aks"
#  cluster_name        = var.aks_cluster_name
#  location            = var.location
#  resource_group_name = module.resource_group.resource_group_name
#  dns_prefix          = var.aks_dns_prefix
#  node_count          = var.aks_node_count
#  vm_size            = var.aks_vm_size
#
#  depends_on = [module.resource_group]
#}

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

