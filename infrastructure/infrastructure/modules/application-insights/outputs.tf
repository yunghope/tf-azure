output "connection_string" {
  value     = azurerm_application_insights.main.connection_string
  sensitive = true
}

output "id" {
  value = azurerm_application_insights.main.id
}