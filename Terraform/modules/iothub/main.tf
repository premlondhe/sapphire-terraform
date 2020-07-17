resource "azurerm_iothub" "main" {
  name                = "${var.azenv}-sap-ioth"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = "S1"
    capacity = "1"
  }
  event_hub_partition_count = 2
  event_hub_retention_in_days = 1
 }

