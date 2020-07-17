resource "azurerm_storage_account" "main" {
  name                     = "${var.azenv}sapdatalake"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  is_hns_enabled           = "true"
  tags = {
    environment = var.azenv
  }
}

resource "azurerm_storage_container" "main" {
  name                  = "wetstock"
  storage_account_name  = azurerm_storage_account.main.name
  depends_on            = [azurerm_storage_account.main]
}
