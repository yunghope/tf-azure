variable "rg_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}
variable "environment" {
  type        = string
  description = "Environment (dev, recette, prod)"
}
