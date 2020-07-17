variable "resource_group_name" {
  description = "variable of the resource group"
}

variable "location" {
  description = "location of the resource group"
}

variable "azenv" {
    type=string
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

