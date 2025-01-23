# Alexandre Huynh

### Azure commands

- az login
- az account show
- az login --tenant ..
- az login --allow-no-subscriptions
- az account show
- az account set --subscription …

### TF commands

- terraform init
- t plan -var-file="tfvars/prod.tfvars"
- t apply -var-file="tfvars/prod.tfvars"

### test commands

- ssh -i ~/.ssh/id_rsa azureuser@IP_PUBLIC
- systemctl status apache2

#### Import if needed
t# Resource Group
terraform import -var-file="tfvars/prod.tfvars" module.resource_group.azurerm_resource_group.rg /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg

##### PostgreSQL
terraform import -var-file="tfvars/prod.tfvars" module.postgresql.azurerm_postgresql_flexible_server.postgres /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/postgresql-francecentral

##### AKS
terraform import -var-file="tfvars/prod.tfvars" module.aks.azurerm_kubernetes_cluster.aks /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.ContainerService/managedClusters/aks-luster

##### ACR
terraform import -var-file="tfvars/prod.tfvars" module.acr.azurerm_container_registry.acr /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.ContainerRegistry/registries/acrregistry07xyz

##### VM Apache
terraform import -var-file="tfvars/prod.tfvars" module.vm_apache.azurerm_linux_virtual_machine.vm /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Compute/virtualMachines/apache-vm

terraform import -var-file="tfvars/prod.tfvars" module.vm_apache.azurerm_network_interface.nic /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/apache-vm-nic

terraform import -var-file="tfvars/prod.tfvars" module.vm_apache.azurerm_public_ip.pip /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/publicIPAddresses/apache-vm-pip

terraform import -var-file="tfvars/prod.tfvars" module.vm_apache.azurerm_network_security_group.nsg /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/networkSecurityGroups/apache-vm-nsg

##### Network
terraform import -var-file="tfvars/prod.tfvars" module.network.azurerm_virtual_network.vnet /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet

terraform import -var-file="tfvars/prod.tfvars" 'module.network.azurerm_subnet.subnet[0]' /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1

terraform import -var-file="tfvars/prod.tfvars" 'module.network.azurerm_subnet.subnet[1]' /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet2

##### Log Analytics
terraform import -var-file="tfvars/prod.tfvars" module.log_analytics.azurerm_log_analytics_workspace.law /subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.OperationalInsights/workspaces/log-analytics-workspace

##### Application Insights
terraform import -var-file="tfvars/prod.tfvars" module.application_insights.azurerm_application_insights.main "/subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Insights/components/test-rg-appinsights"

##### Storage Account
terraform import -var-file="tfvars/prod.tfvars" module.storage.azurerm_storage_account.storage "/subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Storage/storageAccounts/storageacc98765xyz"

#### VM Apache Extension
terraform import -var-file="tfvars/prod.tfvars" module.vm_apache.azurerm_virtual_machine_extension.apache "/subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Compute/virtualMachines/apache-vm/extensions/apache-extension"

##### Network Interface Security Group Association
terraform import -var-file="tfvars/prod.tfvars" module.vm_apache.azurerm_network_interface_security_group_association.example "/subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/apache-vm-nic|/subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.Network/networkSecurityGroups/apache-vm-nsg"

##### PostgreSQL Diagnostic Settings
terraform import -var-file="tfvars/prod.tfvars" module.postgresql.azurerm_monitor_diagnostic_setting.postgresql_diagnostics "/subscriptions/8370cf9a-69e1-4433-ad62-e98e9326f9fa/resourceGroups/test-rg/providers/Microsoft.DBforPostgreSQL/flexibleServers/postgresql-francecentral|diag"

##### Kubernetes Backend Namespace, Deployment et Service
terraform import -var-file="tfvars/prod.tfvars" module.k8s_backend.kubernetes_namespace.backend backend
terraform import -var-file="tfvars/prod.tfvars" module.k8s_backend.kubernetes_deployment.backend backend/backend-deployment
terraform import -var-file="tfvars/prod.tfvars" module.k8s_backend.kubernetes_service.backend backend/backend-service
