resource "azurerm_app_configuration" "main" {
  name                = "${var.azenv}-sap-appconfig"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "free"
}
