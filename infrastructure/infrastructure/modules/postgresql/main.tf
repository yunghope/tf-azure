resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = "${var.server_name}-${var.environment}"
  resource_group_name = var.resource_group
  location            = "francecentral"
  version             = "13"
  zone                = var.environment == "prod" ? "1" : "3"

  administrator_login    = var.admin_user
  administrator_password = var.admin_password

  # Configuration selon l'environnement
storage_mb = var.environment == "prod" ? 65536 : (
  var.environment == "recette" ? 32768 : 32768  # Minimum value for dev
)


  sku_name = var.environment == "prod" ? "GP_Standard_D4s_v3" : (
    var.environment == "recette" ? "GP_Standard_D2s_v3" : "B_Standard_B1ms"
  )

  backup_retention_days        = var.environment == "prod" ? 14 : 7
  geo_redundant_backup_enabled = var.environment == "prod" ? true : false

  # Haute disponibilité uniquement en prod
  dynamic "high_availability" {
    for_each = var.environment == "prod" ? [1] : []
    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = "2"
    }
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Backend Database"
  }
}

# Diagnostic settings pour tous les environnements
resource "azurerm_monitor_diagnostic_setting" "postgresql_diagnostics" {
  name                       = "diag-${var.environment}"
  target_resource_id         = azurerm_postgresql_flexible_server.postgres.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "audit"
  }

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

# Base de données - commentée car gérée par l'application
# resource "azurerm_postgresql_flexible_server_database" "db" {
#   name      = "${var.database_name}-${var.environment}"
#   server_id = azurerm_postgresql_flexible_server.postgres.id
#   charset   = "UTF8"
#   collation = "en_US.utf8"
# }
