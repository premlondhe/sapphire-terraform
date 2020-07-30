resource "azurerm_virtual_network" "main" {
  name                = "${var.azenv}VNet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/8"]
}

resource "azurerm_subnet" "akssubnet" {
  name                 = "${var.azenv}AKSSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.240.0.0/16"]
}

resource "azurerm_subnet" "virtualnodesubnet" {
  name                 = "${var.azenv}VirtualNodeSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.241.0.0/16"]

  delegation {
    name = "acctestdelegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.azenv}-sap-k8s-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.azenv
  kubernetes_version  = var.kubernetes_version

  linux_profile {
    admin_username = var.aks_admin_username

    ssh_key {
      key_data = file("./ssh/sirmlmodel.pub")
    }
  }

  default_node_pool  {
    name            = "def${var.azenv}np"
    node_count      = var.agents_count
    vm_size         = var.agents_size
    os_disk_size_gb = 50
    type            = "VirtualMachineScaleSets"
    vnet_subnet_id  = azurerm_subnet.akssubnet.id
  }

  network_profile {
    dns_service_ip     = "10.0.0.10" 
    docker_bridge_cidr = "172.17.0.1/16" 
    load_balancer_sku  = "Standard" 
    network_plugin     = "azure" 
    network_policy     = "azure" 
    service_cidr       = "10.0.0.0/16" 
  }


  service_principal {
    client_id     = var.azure_client_id
    client_secret = var.azure_client_secret
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }

        aci_connector_linux {
          enabled = true
          subnet_name = azurerm_subnet.virtualnodesubnet.name
        }
  }

  tags = {
    environment = var.azenv
  }

}

