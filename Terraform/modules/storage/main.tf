resource "azurerm_storage_account" "main" {
  count = length(var.storageaccounts)
  name  = "${var.azenv}${var.storageaccounts[count.index]}"
  location = var.location
  resource_group_name = var.resource_group_name
  account_tier = var.account_tier_name
  account_kind = var.storageaccounts[count.index] == "sapstorage" ? "Storage" : "StorageV2"
  account_replication_type = var.storageaccounts[count.index] == "sapstorage" ? "LRS" : "RAGRS"
}

resource "azurerm_storage_container" "main" {
  count = length(var.storagecontainers)
  name = var.storagecontainers[count.index]
  storage_account_name = azurerm_storage_account.main.1.name
  container_access_type = "private"
}
resource "azurerm_storage_table" "main" {
  count = length(var.storagetables)
  name = var.storagetables[count.index]
  storage_account_name = azurerm_storage_account.main.1.name
}
 
