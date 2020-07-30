variable "azure_client_id" {}

variable "azure_client_secret" {}

variable "azure_subscription_id" {}

variable "azure_tenant_id" {}

variable "azenv" {
    type=string
}

variable "location" {
   description = "location of the resource group"
   default = "eastus"
}

variable "storageaccounts" {
  description = "These are the list of storage accounts."
  type = list(string)
}

variable "storagecontainers" {
  description = "These are the list of storage accounts."
  type = list(string)
}

variable "storagetables" {
  description = "These are the list of storage accounts."
  type = list(string)
}

variable "eventhubns" {
  description = "These are the list of eventhub namespaces."
  type = list(string)
}

variable "sbqpartitionenable" {
  description = "These are the list of servicebus queues with partition enabled."
  type = list(string)
}

variable "sbqpartitiondisable" {
  description = "These are the list of servicebus queues with partition disabled."
  type = list(string)
}

variable "sbtopics" {
  description = "These are the list of servicebus topics."
  type = list(string)
}

variable "sbtopicalertssubscription" {
  description = "These are the list of servicebus alerts topic subscriptions."
  type = list(string)
}

variable "sbtopictankinventoriessubscription" {
  description = "These are the list of servicebus tankinventories topic subscription."
  type = list(string)
}

variable "eventhubs" {
  description = "This is the list of eventhubs in the first EH namespace."
  type = list(string)
}

variable "eventhubs2" {
  description = "This is the list of eventhubs in the second EH namespace."
  type = list(string)
}

variable "redisacc" {
   description = "Redis Cache Account Names"
}

variable "workspacename" {
      description = "Databricks Workspace Name"
}

variable "start_ipadd_list" {
}				  

variable "end_ipaddr_list" {
}				  

variable "firewall_rule_name" {
}

variable "account_name" {
    type=string
    description = "Azure DevOps Account Name"

}

variable "branch_name" {
    type=string
    description = "Azure DevOps Git Branch Name"
}

variable "root_folder" {
    type=string
    description = "Folder in Azure DevOps Git Branch"
}

variable "project_name" {
    type=string
    description = "Azure DevOps Proejct Name in Azure DevOps Account"
}

variable "repository_name" {
    type=string
    description = "Git Repository Name in Azure DevOps"
}

variable "admin_username" {
   description = "Sirml vm admin username"
}

variable "nsg-port-list" {}

variable "nsg-priority-list" {}

variable "nsg-description-list" {}

variable "nsg-destination-port-range-list" {}

variable "agents_size" {
  default     = "Standard_DS2_v2"
  description = "The default virtual machine size for the Kubernetes agents"
}

variable "agents_count" {
  default     = "15"
  description = "The default virtual machine size for the Kubernetes agents"
}

variable "aks_admin_username" {
  default     = "aksuser"
  description = "The username of the local administrator to be created on the Kubernetes cluster"
}

variable "kubernetes_version" {}

