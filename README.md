# Alexandre Huynh

### Objectives done ✅

- Migration progressive du monolithique vers microservices
- Backend déplacé vers Kubernetes avec isolation par environnement
- VM Apache maintenue pour le frontend
- Ingress-nginx configuré pour la gestion du trafic

##### Configuration des environnements

DEV : Configuration légère pour tests (1 replica, PostgreSQL basique)

RECETTE : Configuration intermédiaire (2 replicas, PostgreSQL plus robuste)

PROD : Configuration haute disponibilité (3 replicas, PostgreSQL en HA)

PostgreSQL
DEV/RECETTE : Single server
PROD : Haute disponibilité avec 2 serveurs (ZoneRedundant)

Workspaces pour isoler les environnements
Variables adaptées par environnement
Modules réutilisables

##### Scalabilité

Tests progressifs (DEV → RECETTE → PROD)
Haute disponibilité en production
Isolation des environnements

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


##### Screenshots 

Malheureusement pas assez de quotas pour les IP Publics pour les VMs Apache mais le code est crée.

![alt text](<Screenshot 2025-01-23 at 3.23.16 PM.png>)

---

###### Resources groups

![alt text](<Screenshot 2025-01-23 at 3.23.43 PM.png>)

![`alt text`](<Screenshot 2025-01-23 at 3.24.56 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.25.11 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.25.54 PM.png>)

---

###### Azure Postgresql 

![alt text](<Screenshot 2025-01-23 at 3.26.37 PM.png>)

Exemple de log

![alt text](<Screenshot 2025-01-23 at 3.27.17 PM.png>)

---

##### Log Analytics

![alt text](<Screenshot 2025-01-23 at 3.27.41 PM.png>)

Exemple de logs

![alt text](<Screenshot 2025-01-23 at 3.28.40 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.29.03 PM.png>)


---

###### Storage Accounts

![alt text](<Screenshot 2025-01-23 at 3.29.18 PM.png>)

Exemple de log

![alt text](<Screenshot 2025-01-23 at 3.30.17 PM.png>)

---

###### AKS Cluster

Pas assez de quotas pour recette

![alt text](<Screenshot 2025-01-23 at 3.30.53 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.31.32 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.31.46 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.36.50 PM.png>)

---

###### VM

Pas assez de quotas pour le reste mais le code est crée.

![alt text](<Screenshot 2025-01-23 at 3.32.13 PM.png>)

![alt text](<Screenshot 2025-01-23 at 3.33.19 PM.png>)

---

###### Load Balancer

![alt text](<Screenshot 2025-01-23 at 3.33.49 PM.png>)


---

###### Virutal Network

![alt text](<Screenshot 2025-01-23 at 3.35.23 PM.png>)