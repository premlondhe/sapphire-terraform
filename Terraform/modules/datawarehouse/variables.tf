variable "sql-admin-user" {
   description = "admin user name for sql datawarehouse server"
   default = "admin"
}
variable "sql-admin-password" {
   description = "admin password for sql datawarehouse server"
   default = "password@123"
}
variable "adadmin"{
	description = "admin user name for sql datawarehouse server"
	default="Sapphire Operations"
}
variable "adadminID"{
	description = "Active Directory Admin ID"
	default="c9b91080-425d-4e06-b432-f63cc5661435"
}

variable "azure_tenant_id" {
}

