variable "resource_group_name" {
  description = "variable of the resource group"
}

variable "location" {
  description = "location of the resource group"
}

variable "azenv" {
    type=string
}

variable "eventhubns" {
  description = "These are the list of eventhub namespaces."
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



