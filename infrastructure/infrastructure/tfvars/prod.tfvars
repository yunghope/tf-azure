#############################################################
# Common

subscription_id = "8370cf9a-69e1-4433-ad62-e98e9326f9fa"
client_id       = "1ef865dc-c230-442c-be60-23483b42145b"
client_secret   = ".Tu8Q~pt5PsIj8QQgG~w-l1qJcA_Li_7C2ukHc7b"
tenant_id       = "b7b023b8-7c32-4c02-92a6-c8cdaa1d189c"
rg_name         = "test-rg"
location        = "francecentral"

#############################################################
# VM Apache

vm_name        = "apache-vm"
admin_username = "azureuser"
ssh_public_key = "KEYYYYYYYY"

#############################################################
# PostgreSQL

pg_server_name  = "postgresql-francecentral"
pg_db_name      = "mydatabase"
pg_admin_user   = "pgadmin"
pg_admin_password = "testPassword123"


#############################################################
# Acr

acr_name = "acrregistry07xyz"  

#############################################################
# Storage Account

storage_account_name = "storageacc98765xyz"

#############################################################
# Log Analytics

log_analytics_workspace_name = "log-analytics-workspace"

#############################################################
# AKS 

aks_cluster_name    = "aks-luster"
aks_dns_prefix      = "aks-dns"
aks_node_count      = 1
kubernetes_version  = "1.31.3"

#############################################################
# postgreSQL - backend
postgresql_server_admin_login    = "postgresadmin"
postgresql_server_admin_password = "Password123"

#############################################################
server_name    = "postgres-server"
database_name  = "DB-test"
resource_group = "test-rg"
admin_user     = "pgadmin"
admin_password = "testPassword123"
