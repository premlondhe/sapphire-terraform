resource "azurerm_iothub" "main" {
  name                = "${var.azenv}-sap-ioth"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = "S1"
    capacity = "1"
  }
  event_hub_partition_count = 2
  event_hub_retention_in_days = 1
 }

resource "null_resource" "iotHubEventSubscription" {

  triggers = {
    shell_hash = "${sha256(file("./iotHubEventSubscription-Deploy.sh"))}"
  }

  provisioner "local-exec" {
    command = "chmod +x ./iotHubEventSubscription-Deploy.sh"
  }

  provisioner "local-exec" {
    command = "az login --service-principal --username ${var.azure_client_id} --password ${var.azure_client_secret} --tenant ${var.azure_tenant_id}"
  }

  provisioner "local-exec" {
    command = "az account set --subscription='${var.azure_subscription_id}'"
  }

  provisioner "local-exec" {
      command = "./iotHubEventSubscription-Deploy.sh ${azurerm_iothub.main.resource_group_name} ${var.azenv} ${var.azure_subscription_id} ${azurerm_iothub.main.name} ${var.evth1ns}"
        }

  provisioner "local-exec" {
      command = "az logout"
        }

        depends_on=[azurerm_iothub.main]
}

