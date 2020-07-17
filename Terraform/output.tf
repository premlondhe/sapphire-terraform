/*
output "Test" {	
	value = module.eventhub.evth1ns
}
*/

output "app_id" {
  value = module.appinsights.app_id
}

output "instrumentation_key" {
  value = module.appinsights.instrumentation_key
}



