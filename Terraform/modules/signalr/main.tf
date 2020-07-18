resource "azurerm_signalr_service" "main" {
  name                = "${var.azenv}-sap-signalr"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_S1"
    capacity = 1
  }

  features {
    flag  = "ServiceMode"
    value = "Default"
  }
}
