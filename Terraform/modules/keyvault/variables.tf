variable "resource_group_name" {
  description = "variable of the resource group"
}

variable "location" {
  description = "location of the resource group"
}

variable "azure_tenant_id" {
  description = "(Required) The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "azenv" { }
