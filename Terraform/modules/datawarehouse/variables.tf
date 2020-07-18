variable "resource_group_name" {
  description = "variable of the resource group"
}

variable "location" {
  description = "location of the resource group"
}

variable "azenv" {
    type=string
}

variable "sql-admin-user" {
   description = "admin user name for sql datawarehouse server"
   default = "dfssa"
}
variable "sql-admin-password" {
   description = "admin password for sql datawarehouse server"
   default = "Ch@ng3M3"
}
variable "adadmin"{
	description = "admin user name for sql datawarehouse server"
	default="Sapphire Operations"
}
variable "adadminID"{
	description = "Active Directory Admin ID"
	default="c9b91080-425d-4e06-b432-f63cc5661435"
}

variable "start_ipadd_list" {
}				  

variable "end_ipaddr_list" {
}				  

variable "firewall_rule_name" {
}

variable "azure_client_id" {}

variable "azure_client_secret" {}

variable "azure_subscription_id" {}

variable "azure_tenant_id" {}

