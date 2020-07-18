resource "azurerm_template_deployment" "main" {
  name	= "${var.azenv}-${var.workspacename}"
  resource_group_name = var.resource_group_name
  parameters = {
    workspaceName="${var.azenv}-${var.workspacename}"
    location=var.location 
    tier=var.workspacetier
  }
  deployment_mode ="Incremental"
  template_body = <<DEPLOY
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string"
        },
        "workspaceName": {
            "type": "string"
        },
        "tier": {
            "defaultValue": "standard",
            "type": "string"
        }
    },
    "variables": {
        "managedResourceGroupName": "[concat('databricks-rg-', parameters('workspaceName'), '-', uniqueString(parameters('workspaceName'), resourceGroup().id))]",
        "managedResourceGroupId": "[concat(subscription().id, '/resourceGroups/', variables('managedResourceGroupName'))]"
    },
    "resources": [
        {
            "type": "Microsoft.Databricks/workspaces",
            "apiVersion": "2018-04-01",
            "name": "[parameters('workspaceName')]",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "sku": {
                "name": "[parameters('tier')]"
            },
            "properties": {
                "ManagedResourceGroupId": "[variables('managedResourceGroupId')]",
                "parameters": {}
            }
        }
    ]
}
DEPLOY

}

