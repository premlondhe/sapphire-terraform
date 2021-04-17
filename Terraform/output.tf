output "all_storage_connection_string" {
 value = module.storage.connection_string[0]
}
  
output "first_storage_connection_string" {
 value = module.storage.connection_string[0]
}

output "storages" {
  value = module.storage.storage_acc_names
}

output "storages_1" {
  value = module.storage.storage_acc_names[1]
}


/*
output "app_id" {
  value = module.appinsights.app_id
}

output "instrumentation_key" {
  value = module.appinsights.instrumentation_key
}

output "evth1ns" {
        value = module.eventhub.evth1ns
}

output "eh_primarykey" {
     value =  module.eventhub.eh_primarykey
}

output "sb_primarykey" {
     value = module.servicebus.sb_primarykey
}
*/

