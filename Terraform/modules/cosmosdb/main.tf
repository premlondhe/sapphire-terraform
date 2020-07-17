resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "${var.azenv}-sap-cosdb-sql"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "Session"
  } 

  geo_location {
    prefix            = "cosmos-${var.azenv}"
    location          = var.location
    failover_priority = 0
  }

  tags = {
    environment = "${var.azenv}"
  }
}

resource "null_resource" "cosmosdbandcollections" {

  triggers = {
    shell_hash = "${sha256(file("./cosmosDb-Deploy.sh"))}"
  }

  provisioner "local-exec" {
    command = "chmod +x ./cosmosDb-Deploy.sh"
  } 
 
  provisioner "local-exec" {
    command = "az login --service-principal --username ${var.azure_client_id} --password ${var.azure_client_secret} --tenant ${var.azure_tenant_id}"
  }	

  provisioner "local-exec" {
    command = "az account set --subscription='${var.azure_subscription_id}'"
  }	
  
  provisioner "local-exec" {
      command = "./cosmosDb-Deploy.sh ${azurerm_cosmosdb_account.cosmosdb.resource_group_name} ${azurerm_cosmosdb_account.cosmosdb.name}"
	}

  provisioner "local-exec" {
      command = "az logout"
        }

	depends_on=[azurerm_cosmosdb_account.cosmosdb]
}

