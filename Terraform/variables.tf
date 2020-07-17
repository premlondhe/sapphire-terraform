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


