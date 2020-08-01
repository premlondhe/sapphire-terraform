terraform{
 backend "azurerm"{
   storage_account_name = "csg10032000d2add750"
    container_name = "terraform"
    key = "tfstate"
    access_key = "QkPExemcig3sFIkTNd4YhSwidLsC0n00Zpr3FESgnclLVrnp/X3bjKAYvxVaez7vTsB8ZZdiyMdCVFu4ZEssBw=="
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

module "vm-sirml" {
   source                          ="./modules/vm-sirml"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv                           = var.azenv
   nsg-port-list		   = var.nsg-port-list
   nsg-priority-list		   = var.nsg-priority-list
   nsg-description-list	 	   = var.nsg-description-list
   nsg-destination-port-range-list = var.nsg-destination-port-range-list
   admin_username		   = var.admin_username
   azure_subscription_id           = var.azure_subscription_id
   azure_client_id                 = var.azure_client_id
   azure_tenant_id                 = var.azure_tenant_id
   azure_client_secret             = var.azure_client_secret

}

module "aks" {
  source                          = "./modules/aks"
  azenv				  = var.azenv
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  aks_admin_username              = var.aks_admin_username
  agents_size                     = var.agents_size
  agents_count                    = var.agents_count
  kubernetes_version              = var.kubernetes_version
  azure_client_id                 = var.azure_client_id
  azure_client_secret             = var.azure_client_secret
#  log_analytics_workspace_id      = module.log_analytics_workspace.id
}

module "streamanalytics" {
  source                          = "./modules/streamanalytics"
  azenv                           = var.azenv
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  eh_primarykey			  = module.eventhub.eh_primarykey
  sb_primarykey			  = module.servicebus.sb_primarykey
}

module "appservice" {
   source                          ="./modules/appservice"
   resource_group_name             = azurerm_resource_group.main.name
   location                        = azurerm_resource_group.main.location
   azenv			   = var.azenv 
   allowed_origins		   = var.allowed_origins
}

