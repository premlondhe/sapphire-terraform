resource "azurerm_sql_server" "main" {
  name                         = "${var.azenv}-sap-azsql"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql-admin-user
  administrator_login_password = var.sql-admin-password
  tags = {
    environment = var.azenv
  }
}

resource "azurerm_sql_active_directory_administrator" "main" {
  server_name         = azurerm_sql_server.main.name
  resource_group_name = var.resource_group_name
  login               = var.adadmin
  tenant_id           = var.azure_tenant_id
  object_id           = var.adadminID
  
  depends_on=[azurerm_sql_server.main]
}

locals {
  # These represent dynamic data we fetch from somewhere, such as firewall rule name, start ip and end ip.
	start_ipadd_list=var.start_ipadd_list
	end_ipaddr_list=var.end_ipaddr_list
	firewall_rule_name=var.firewall_rule_name
}

resource "azurerm_sql_firewall_rule" "main" {
  count = length(local.firewall_rule_name)

  name                = element(local.firewall_rule_name, count.index)
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.main.name
  start_ip_address    = element(local.start_ipadd_list, count.index)
  end_ip_address      = element(local.end_ipaddr_list, count.index)

  depends_on=[azurerm_sql_server.main]

}

resource "null_resource" "sqldb" {

  triggers = {
    shell_hash = "${sha256(file("./DatawarehouseSQLDB.sh"))}"
  }

  provisioner "local-exec" {
    command = "az login --service-principal --username ${var.azure_client_id} --password ${var.azure_client_secret} --tenant ${var.azure_tenant_id}"
  }

  provisioner "local-exec" {
    command = "az account set --subscription='${var.azure_subscription_id}'"
  }

  provisioner "local-exec" {
      command = "./DatawarehouseSQLDB.sh ${azurerm_sql_server.main.resource_group_name} ${azurerm_sql_server.main.name} customersitedata "
        }

  provisioner "local-exec" {
      command = "az logout"
        }

        depends_on=[azurerm_sql_server.main]
}

