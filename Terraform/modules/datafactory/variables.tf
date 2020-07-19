variable "resource_group_name" {
  description = "variable of the resource group"
}

variable "location" {
  description = "location of the resource group"
}

variable "azenv" {
    type=string
}

variable "account_name" {
    type=string
    description = "Azure DevOps Account Name"
}

variable "branch_name" {
    type=string
    description = "Azure DevOps Git Branch Name"
}

variable "root_folder" {
    type=string
    description = "Folder in Azure DevOps Git Branch"
}

variable "project_name" {
    type=string
    description = "Azure DevOps Proejct Name in Azure DevOps Account"
}

variable "repository_name" {
    type=string
    description = "Git Repository Name in Azure DevOps"
}

variable "azure_tenant_id" {
    type=string
}

