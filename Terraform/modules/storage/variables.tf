variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
}

variable "azenv" {
  description = "The environment in which resource group will be created."
}

variable "resource_group_name" {
  description = "The resource group name in which all resources will be created."
}

variable "account_replication_name" {
  description = "Defines the type of replication to use for this storage account."
  default = "LRS"
}

variable "account_tier_name" {
  description = "Defines the Tier to use for this storage account."
  default = "Standard"
}

variable "storageaccounts" {
  description = "These are the list of storage accounts."
  type = list(string)
}

variable "storagecontainers" {
  description = "These are the list of storage containers."
  type = list(string)
}
 
variable "storagetables" {
  description = "These are the list of storage tables."
  type = list(string)
}
