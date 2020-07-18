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
  resource_group_name = azurerm_resource_group.main.name
  login               = var.adadmin
  tenant_id           = var.azure_tenant_id
  object_id           = var.adadminID
  
  depends_on=[azurerm_sql_server.main]
}

