resource "azurerm_stream_analytics_job" "main" {
  name                                     = "LateDataProcessor"
  resource_group_name                      = var.resource_group_name
  location                                 = var.location
  compatibility_level                      = "1.1"
  events_late_arrival_max_delay_in_seconds = 5
  events_out_of_order_max_delay_in_seconds = 0
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Stop"
  streaming_units                          = 1

  tags = {
    environment = var.azenv
  }

  transformation_query = <<QUERY
   SELECT A.siteId as siteId,A.businessDay as businessDay,A.businessDayEndTimeUtc as businessDayEndTimeUtc,A.timeWindow as timeWindow INTO rolluptasks From (SELECT COUNT(*),siteId,businessDay,businessDayEndTimeUtc,timeWindow FROM latedata GROUP BY siteId,businessDay,businessDayEndTimeUtc,timeWindow,TumblingWindow(second,10)) As A
  QUERY

}

resource "azurerm_stream_analytics_stream_input_eventhub" "ldinput" {
  name                         = "latedata"
  stream_analytics_job_name    = azurerm_stream_analytics_job.main.name
  resource_group_name          = var.resource_group_name
  servicebus_namespace         = "${var.azenv}-sap-evth"
  eventhub_name                = "latedata"
  eventhub_consumer_group_name = "latedataprocessor"
  shared_access_policy_key     = var.eh_primarykey
  shared_access_policy_name    = "RootManageSharedAccessKey"

  serialization {
    type     = "Json"
    encoding = "UTF8"
  }
}

resource "azurerm_stream_analytics_output_servicebus_queue" "ldoutput" {
  name                      = "rolluptasks"
  stream_analytics_job_name = azurerm_stream_analytics_job.main.name
  resource_group_name       = var.resource_group_name
  queue_name                = "rolluptasks"
  servicebus_namespace      = "${var.azenv}-sap-svcb"
  shared_access_policy_key  = var.sb_primarykey
  shared_access_policy_name = "RootManageSharedAccessKey"

  serialization {
    format   = "LineSeparated"
    type     = "Json"
    encoding = "UTF8"
  }

}

