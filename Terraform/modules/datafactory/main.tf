resource "azurerm_data_factory" "main" {
  name                = "${var.azenv}-sap-adf"
  location            = var.location
  resource_group_name = var.resource_group_name
  
  identity {
	type = "SystemAssigned"
	}

  vsts_configuration {
	account_name = var.account_name
	branch_name = var.branch_name
	project_name = var.project_name
	repository_name  = var.repository_name
	root_folder = var.root_folder
	tenant_id = var.azure_tenant_id
  }

}

