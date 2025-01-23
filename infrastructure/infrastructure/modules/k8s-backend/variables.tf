variable "replicas" {
  type    = number
  default = 2
}

variable "acr_server" {
  type = string
}

variable "pg_hostname" {
  type = string
}

variable "postgresql_server_admin_login" {
  type = string
}

variable "postgresql_server_admin_password" {
  type = string
}

variable "app_insights_connection_string" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}