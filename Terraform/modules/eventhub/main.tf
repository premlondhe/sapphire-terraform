resource "azurerm_eventhub_namespace" "main" {
  count = length(var.eventhubns)
  name  = "${var.azenv}-${var.eventhubns[count.index]}"  
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
  auto_inflate_enabled = true
  maximum_throughput_units = 1
  tags = {
    environment = var.azenv
  }
}

# Below RootManageSharedAccessKey is created bydefault by Azue.
/*
 resource "azurerm_eventhub_namespace_authorization_rule" "root" {
   count = length(var.eventhubns)
   name                = "RootManageSharedAccessKey"
   namespace_name      = "${var.azenv}-${var.eventhubns[count.index]}"
   resource_group_name = var.resource_group_name

   listen = true
   send   = true
   manage = true
   depends_on=[azurerm_eventhub_namespace.main]
 }
*/

 resource "azurerm_eventhub_namespace_authorization_rule" "listen" {
   count = length(var.eventhubns)
   name                = "ListenAccessKey"
   namespace_name      = "${var.azenv}-${var.eventhubns[count.index]}"
   resource_group_name = var.resource_group_name

   listen = true
   send   = false
   manage = false
   depends_on=[azurerm_eventhub_namespace.main]
 }

 resource "azurerm_eventhub_namespace_authorization_rule" "send" {
   count = length(var.eventhubns)
   name                = "SendPolicy"
   namespace_name      = "${var.azenv}-${var.eventhubns[count.index]}"
   resource_group_name = var.resource_group_name
  
   listen = false
   send   = true
   manage = false
   depends_on=[azurerm_eventhub_namespace.main] 
}

 resource "azurerm_eventhub_namespace_authorization_rule" "duplex" {
   count = length(var.eventhubns)
   name                = "DuplexPolicy"
   namespace_name      = "${var.azenv}-${var.eventhubns[count.index]}"
   resource_group_name = var.resource_group_name

   listen = true
   send   = true
   manage = false
   depends_on=[azurerm_eventhub_namespace.main]
 }


resource "azurerm_eventhub" "evth1ns" {
  count = length(var.eventhubs)
  name = var.eventhubs[count.index]
  namespace_name      = azurerm_eventhub_namespace.main.0.name
  resource_group_name = var.resource_group_name
  partition_count     = 4
  message_retention   = 3
  depends_on=[azurerm_eventhub_namespace.main]
}

resource "azurerm_eventhub_consumer_group" "evth1ns-cg" {
  count = length(var.eventhubs)
  name = "${var.eventhubs[count.index]}processor"
  namespace_name      = azurerm_eventhub_namespace.main.0.name
  eventhub_name       = var.eventhubs[count.index]
  resource_group_name = var.resource_group_name
  depends_on=[azurerm_eventhub_namespace.main]
}


resource "azurerm_eventhub" "evth2ns" {
  count = length(var.eventhubs2)
  name = var.eventhubs2[count.index]
  namespace_name      = azurerm_eventhub_namespace.main.1.name
  resource_group_name = var.resource_group_name
  partition_count     = 4
  message_retention   = 3
  depends_on=[azurerm_eventhub_namespace.main]
}


resource "azurerm_eventhub_consumer_group" "evth2ns-cg" {
  count = length(var.eventhubs2)
  name = "${var.eventhubs2[count.index]}processor"
  namespace_name      = azurerm_eventhub_namespace.main.1.name
  eventhub_name       = var.eventhubs2[count.index]
  resource_group_name = var.resource_group_name
  depends_on=[azurerm_eventhub_namespace.main]
}


resource "azurerm_eventhub_consumer_group" "evth2ns-cg-rtmissingstock" {
  name = "real-time-rec-req-missingstock-sa"
  namespace_name      = azurerm_eventhub_namespace.main.1.name
  eventhub_name       = "real-time-rec-req"
  resource_group_name = var.resource_group_name
  depends_on=[azurerm_eventhub_namespace.main]
}

resource "azurerm_eventhub_consumer_group" "evth2ns-cg-rtmissingsales" {
  name = "real-time-rec-req-missingsales-sa"
  namespace_name      = azurerm_eventhub_namespace.main.1.name
  eventhub_name       = "real-time-rec-req"
  resource_group_name = var.resource_group_name
  depends_on=[azurerm_eventhub_namespace.main]
}


resource "azurerm_eventhub_consumer_group" "evth2ns-cg-alerts-notifications" {
  name = "notifications"
  namespace_name      = azurerm_eventhub_namespace.main.1.name
  eventhub_name       = "alerts"
  resource_group_name = var.resource_group_name
  depends_on=[azurerm_eventhub_namespace.main]
}



