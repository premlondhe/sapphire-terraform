variable "agents_size" {
  default     = "Standard_DS2_v2"
  description = "The default virtual machine size for the Kubernetes agents"
}

variable "agents_count" {
  default     = "1"
  description = "The default virtual machine size for the Kubernetes agents"
}

variable "aks_admin_username" {
  default     = "aksuser"
  description = "The username of the local administrator to be created on the Kubernetes cluster"
}

variable "azenv" {}
variable "location" {}
variable "resource_group_name" {}
variable "kubernetes_version" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}

