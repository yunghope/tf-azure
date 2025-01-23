resource "azurerm_application_insights" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  workspace_id        = var.workspace_id

  tags = {
    Environment = "Development"
  }
}