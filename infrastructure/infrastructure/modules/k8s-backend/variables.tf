variable "environment" {
  type        = string
  description = "Environment (dev, recette, prod)"
}

variable "acr_server" {
  type        = string
  description = "ACR server URL"
}

variable "pg_hostname" {
  type        = string
  description = "PostgreSQL server hostname"
}

variable "postgresql_server_admin_login" {
  type        = string
  description = "PostgreSQL server admin login"
}

variable "postgresql_server_admin_password" {
  type        = string
  description = "PostgreSQL server admin password"
  sensitive   = true
}

variable "app_insights_connection_string" {
  type        = string
  description = "Application Insights connection string"
  sensitive   = true
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID"
}
