resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = var.server_name
  resource_group_name = var.resource_group
  location            = "francesouth"
  version            = "13"

  administrator_login    = var.admin_user
  administrator_password = var.admin_password

  storage_mb = 32768
  sku_name   = "B_Standard_B1ms"

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  tags = {
    Environment = "Development"
  }
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.postgres.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
