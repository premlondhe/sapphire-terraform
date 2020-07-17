resource "azurerm_servicebus_namespace" "main" {
  name                = "${var.azenv}-sap-svcb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags = {
    environment = var.azenv
  }
}

# Below RootManageSharedAccessKey is created bydefault by Azue.
/*
resource "azurerm_servicebus_namespace_authorization_rule" "root" {
  name                = "RootManageSharedAccessKey"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = var.resource_group_name
  send                = true
  listen              = true
  manage              = true
  depends_on=[azurerm_servicebus_namespace.main]
}
*/
resource "azurerm_servicebus_namespace_authorization_rule" "listen" {
  name                = "ListenAccessKey"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = var.resource_group_name
  listen              = true
  send		      = false
  manage	      = false
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_namespace_authorization_rule" "send" {
  name                = "SendPolicy"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = var.resource_group_name
  send                = true
  listen	      = false
  manage 	      = false
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_namespace_authorization_rule" "duplex" {
  name                = "DuplexPolicy"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = var.resource_group_name
  send                = true
  listen              = true
  manage	      = false
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_namespace_authorization_rule" "flow" {
  name                = "FlowConnection"
  namespace_name      = azurerm_servicebus_namespace.main.name
  resource_group_name = var.resource_group_name
  send                = true
  listen              = true
  manage              = true
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_queue" "partition-enabled" {
  count 	      	= length(var.sbqpartitionenable)
  name 		      	= var.sbqpartitionenable[count.index]
  resource_group_name 	= var.resource_group_name
  namespace_name      	= azurerm_servicebus_namespace.main.name
#  lock_duration 	= "PT30M"
  max_size_in_megabytes = "1024"
  default_message_ttl 	= "P3D"
  enable_partitioning 	= true
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_queue" "partition-disabled" {
  count 		= length(var.sbqpartitiondisable)
  name 			= var.sbqpartitiondisable[count.index]
  resource_group_name 	= var.resource_group_name
  namespace_name      	= azurerm_servicebus_namespace.main.name
#  lock_duration 	= "PT30M"
  max_size_in_megabytes = "1024"
  default_message_ttl 	= "P3D"
  enable_partitioning 	= false
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_topic" "main" {
  count 		= length(var.sbtopics)
  name 			= var.sbtopics[count.index]
  resource_group_name 	= var.resource_group_name
  namespace_name      	= azurerm_servicebus_namespace.main.name
  enable_partitioning 	= true
  status 		= "Active"
  default_message_ttl 	= "P14D"
  max_size_in_megabytes = "2048"
  depends_on=[azurerm_servicebus_namespace.main]
}

resource "azurerm_servicebus_subscription" "alerts-subscriptions" {
  count = length(var.sbtopicalertssubscription)
  name = var.sbtopicalertssubscription[count.index]
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.main.name
  topic_name          = azurerm_servicebus_topic.main.0.name
  max_delivery_count  = 10
  depends_on=[azurerm_servicebus_topic.main]
}

resource "azurerm_servicebus_subscription" "tankinventories-subscriptions" {
  count = length(var.sbtopictankinventoriessubscription)
  name = var.sbtopictankinventoriessubscription[count.index]
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.main.name
  topic_name          = azurerm_servicebus_topic.main.1.name
  max_delivery_count  = 10
  depends_on=[azurerm_servicebus_topic.main]
}

resource "azurerm_servicebus_subscription_rule" "alerts-subscriptions-rule" {
  count = length(var.sbtopicalertssubscription)
  name = "${var.sbtopicalertssubscription[count.index]}rule"
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_servicebus_namespace.main.name
  topic_name          = azurerm_servicebus_topic.main.0.name
  subscription_name   = var.sbtopicalertssubscription[count.index]
  filter_type         = "SqlFilter"
  sql_filter          = "sys.Label = ${var.sbtopicalertssubscription[count.index]}"
  depends_on=[azurerm_servicebus_topic.main]
}



