resource "azurerm_network_security_group" "main" {
  name                = "${var.azenv}-sirmlmodel-server-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  }

locals {
  # These represent dynamic data we fetch from somewhere, such as firewall rule name, start ip and end ip.
        nsg-port-list=var.nsg-port-list
        nsg-priority-list=var.nsg-priority-list
        nsg-description-list=var.nsg-description-list
	nsg-destination-port-range-list=var.nsg-destination-port-range-list
}

/*
resource "azurerm_network_security_rule" "main" {
  count 			= length(local.nsg-priority-list)
  name                		= element(local.nsg-port-list, count.index)
  resource_group_name 		= var.resource_group_name
  network_security_group_name 	= azurerm_network_security_group.main.name
  description		  	= element(local.nsg-description-list, count.index)
  protocol                    	= "Tcp"
  source_port_range	 	= "0-65535"
  destination_port_range      	= element(local.nsg-destination-port-range-list, count.index)
  access                      	= "Allow"
  priority                    	= element(local.nsg-priority-list, count.index)
  direction                   	= "Inbound"

  depends_on=[azurerm_network_security_group.main]
}
*/
resource "azurerm_virtual_network" "main" {
  name                = "${var.azenv}-sirmlmodel-server-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "main" {
  name                 = "${var.azenv}-sirmlmodel-server-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/24"]

  depends_on=[azurerm_virtual_network.main]  
}

resource "azurerm_network_interface" "main" {
  name                		= "${var.azenv}-sirmlmodel-server-subnet-nic"
  location            		= var.location 
  resource_group_name 		= var.resource_group_name
  enable_accelerated_networking = "true"
  
  ip_configuration {
    name                          = "SirML-IP-Configuration"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id	  = azurerm_public_ip.main.id
    primary			  = "true"
  }
  
  depends_on=[azurerm_subnet.main]    
}

resource "azurerm_public_ip" "main" {
  name                			= "${var.azenv}-sirmlmodel-server-pip"
  resource_group_name 			= var.resource_group_name
  location            			= var.location
  allocation_method   			= "Static"
  
    tags = {
    environment = var.azenv
  }
  
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
  
  depends_on=[azurerm_subnet.main]    
}


resource "azurerm_virtual_machine" "main" {
  name                  		= "${var.azenv}-sirmlmodel-server"
  location              		= var.location
  resource_group_name   		= var.resource_group_name
  network_interface_ids			= [azurerm_network_interface.main.id]
  primary_network_interface_id 		= azurerm_network_interface.main.id
  vm_size               		= "Standard_DS4_v2"
# vm_size				= "Standard_DS1_v2"

# Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

# Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  
  storage_os_disk {
    name  	      = "${var.azenv}-sirmlmodel-server-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = "30"
    os_type	      = "Linux"
  }
  
  os_profile {
    computer_name  = "${var.azenv}-sirmlmodel-server"
    admin_username = var.admin_username
  }
  
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys  {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = file("./ssh/sirmlmodel.pub")
    }
  }
  
  depends_on=[azurerm_subnet_network_security_group_association.main]    
}


