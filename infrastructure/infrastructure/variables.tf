variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "rg_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "West Europe"
}

variable "vm_name" {
  type        = string
  description = "Name of the Apache VM"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
  default     = "azureuser"
}

variable "pg_server_name" {
  type        = string
  description = "Name of the PostgreSQL server"
}

variable "pg_db_name" {
  type        = string
  description = "Name of the PostgreSQL database"
}

variable "pg_admin_user" {
  type        = string
  description = "PostgreSQL admin username"
}

variable "pg_admin_password" {
  type        = string
  description = "PostgreSQL admin password"
  sensitive   = true
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM authentication"
}
