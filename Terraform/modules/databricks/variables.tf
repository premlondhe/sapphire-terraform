variable "resource_group_name" {
  description = "variable of the resource group"
}

variable "location" {
  description = "location of the resource group"
}

variable "azenv" {
    type=string
}

variable "workspacetier" {
   description = "Workspace Tier for azure databricks service"
   default = "standard"
}

variable "workspacename" {
      description = "Databricks Workspace Name"
}

