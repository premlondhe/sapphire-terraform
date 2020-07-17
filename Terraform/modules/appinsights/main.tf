resource "azurerm_application_insights" "main" {
  name                 = "${var.azenv}-sap-appinsights"
  location             = var.location
  resource_group_name  = var.resource_group_name
  application_type     = "web"
  tags = {
    environment = var.azenv
  }
}
