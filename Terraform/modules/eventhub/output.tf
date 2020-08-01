output "evth1ns" {
	value = azurerm_eventhub_namespace.main.0.name
}

output "evth2ns" {
	value = azurerm_eventhub_namespace.main.1.name
}

output "eh_primarykey" {
        value = azurerm_eventhub_namespace.main.0.default_primary_key
}

