variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Azure Region"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for Virtual Network"
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Subnet address prefixes"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "subnet_names" {
  type        = list(string)
  description = "Subnet names"
  default     = ["subnet1", "subnet2"]
}
