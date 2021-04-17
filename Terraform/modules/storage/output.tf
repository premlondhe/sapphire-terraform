output "connection_string" {
  value = azurerm_storage_account.main.*.primary_connection_string
}

output "storage_acc_names" {
  value = azurerm_storage_account.main.*.name
}
