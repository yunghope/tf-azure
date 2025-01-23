variable "name" {
  type        = string
  description = "Name of the Application Insights instance"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "workspace_id" {
  type        = string
  description = "Log Analytics Workspace ID"
}