terraform{
 backend "azurerm"{
   storage_account_name = "tfstorage890"
    container_name = "terraform"
    key = "tfstate"
    access_key = "A9tArPyU9G8imIxeCFRRfc1pWYFozN3rBYKxi02BvLWIDmRtCxD8SHGsbWHILopu5o6PigTMZ3odtheWvmDuWg=="
  }
}

resource "azurerm_resource_group" "main" {
    name = "${var.azenv}-sap-paas-rg"
    location = var.location
    tags = {
    environment = var.azenv
  }
}


module "storage" {
  source 			   = "./modules/storage"
  location 		  	   = azurerm_resource_group.main.location
  resource_group_name 		   = azurerm_resource_group.main.name
  azenv 			   = var.azenv
  storageaccounts 		   = var.storageaccounts
  storagecontainers		   = var.storagecontainers
  storagetables			   = var.storagetables
}

module "storage-dataLake" {
   source                          ="./modules/storage-dataLake"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
}


module "eventhub" {
   source                          = "./modules/eventhub"
   azenv			   = var.azenv
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   eventhubns			   = var.eventhubns
   eventhubs			   = var.eventhubs
   eventhubs2			   = var.eventhubs2
}

module "servicebus" {
   source                          = "./modules/servicebus"
   azenv                           = var.azenv
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   sbqpartitionenable   	   = var.sbqpartitionenable
   sbqpartitiondisable	   	   = var.sbqpartitiondisable
   sbtopics			   = var.sbtopics
   sbtopicalertssubscription	   = var.sbtopicalertssubscription
   sbtopictankinventoriessubscription = var.sbtopictankinventoriessubscription
}


module "cosmosdb" {
   source                          ="./modules/cosmosdb"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv			   = var.azenv
   azure_subscription_id	   = var.azure_subscription_id
   azure_client_id		   = var.azure_client_id
   azure_tenant_id		   = var.azure_tenant_id
   azure_client_secret		   = var.azure_client_secret

}

module "iothub" {
   source                          ="./modules/iothub"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
   azure_subscription_id           = var.azure_subscription_id
   azure_client_id                 = var.azure_client_id
   azure_tenant_id                 = var.azure_tenant_id
   azure_client_secret             = var.azure_client_secret
   evth1ns			   = module.eventhub.evth1ns
}

module "rediscache" {
   source                          ="./modules/rediscache"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
   redisacc			   = var.redisacc
}

module "appinsights" {
   source                          ="./modules/appinsights"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
}

module "appconfig" {
   source                          ="./modules/appconfig"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
}

module "keyvault" {
    source                          = "./modules/keyvault"
    azenv                           = var.azenv
    resource_group_name             = azurerm_resource_group.main.name
    location                        = azurerm_resource_group.main.location
    azure_tenant_id                 = var.azure_tenant_id
}

module "signalr" {
   source                          ="./modules/signalr"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
}

module "databricks" {
   source                          ="./modules/databricks"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
   workspacename		   = var.workspacename
}

module "datawarehouse" {
   source                          ="./modules/datawarehouse"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
   start_ipadd_list	 	   = var.start_ipadd_list
   end_ipaddr_list		   = var.end_ipaddr_list
   firewall_rule_name		   = var.firewall_rule_name
   azure_subscription_id           = var.azure_subscription_id
   azure_client_id                 = var.azure_client_id
   azure_tenant_id                 = var.azure_tenant_id
   azure_client_secret             = var.azure_client_secret
}

module "datafactory" {
   source                          ="./modules/datafactory"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
   account_name			   = var.account_name
   branch_name			   = var.branch_name
   project_name			   = var.project_name
   repository_name		   = var.repository_name
   root_folder			   = var.root_folder
   azure_tenant_id		   = var.azure_tenant_id

}

