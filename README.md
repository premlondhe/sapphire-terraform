# Sapphire

# Targeting TF resource
terraform plan -target="module.aks.azurerm_kubernetes_cluster.main"
terraform apply -target="module.aks.azurerm_kubernetes_cluster.main"
terraform destroy -target="module.aks.azurerm_kubernetes_cluster.main"

# Some useful commands
terraform refresh
terraform output

# Deleting specifc resource
terraform destroy -target RESOURCE_TYPE.NAME\n
module.signalr.azurerm_signalr_service.main

# Terraform Outputs Example:
https://medium.com/@jmarhee/outputs-with-terrmodule.signalr.azurerm_signalr_service.mainafmodule.signalr.azurerm_signalr_service.maimodule.signalr.azurerm_signalr_service.mainnorm-modules-ec0ce38ea1ad

#######################################################################################################################

Pending comparing resources with sapphire stg environment
Pending comparing various SKU, sizes eg. sirml vm size etc.

#######################################################################################################################
# PREREQUISITE:
1. az command must be installed on machine.
2. Use below terraform version, the version is downloaded in the root folder in repository.
        Terraform v0.12.28
        + provider.azurerm v2.19.0
        + provider.null v2.1.2
        
3. Executing Code:
        git clone {REPO}
        cd Terraform
        terraform init
        terraform plan
        terraform apply  (-auto-approve)

# KEEP IN MIND:
1. Whenever you see changes in any bash scripts in AzCLI folder than make changes in terrform accordingly.

# POST RUN:
1. Make sure you execute script "addKeyVaultSecrets.sh" manually to add the secrets in KeyVault.



