provider "azurerm" {
  features {}
  
}

#Resource_group
resource "azurerm_resource_group" "terraform" {
  name = var.resource_group_name
  location = var.location
}

#virtual network
resource "azurerm_virtual_network" "terraform" {
  name = var.virtual_network_name
  location = var.location
  address_space = var.address_space
  resource_group_name = var.resource_group_name

  depends_on = [ azurerm_resource_group.terraform ]
  
}

#subnet

resource "azurerm_subnet" "terraform" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes = var.address_prefix
  depends_on = [ azurerm_resource_group.terraform, azurerm_virtual_network.terraform ]
  
}

resource "azurerm_network_security_group" "terraform" {
  name = var.network_security_group_name
  location = var.location
  resource_group_name = var.resource_group_name
  
  security_rule {
    name                       = "allow_ssh"
    priority                   =  1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [ azurerm_resource_group.terraform ]
}

#network interface

resource "azurerm_network_interface" "terraform" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
     name                          = "internal"
     subnet_id                     = azurerm_subnet.terraform.id
     private_ip_address_allocation = "Dynamic"
   }
  tags = {
     Name = "terraform-nic"
   }
   depends_on = [ azurerm_resource_group.terraform, azurerm_virtual_network.terraform ]
 }

# Virtual Machine
resource "azurerm_linux_virtual_machine" "terraform" {
  name = var.vm_name
  location = var.location
  resource_group_name = var.resource_group_name
  size = var.vm_size
  admin_username = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.terraform.id,
  ]
  admin_password = var.admin_password
  disable_password_authentication = var.disable_pass_authentication
  computer_name = var.computer_name
  tags = {
    name = "terraform-vm"
  }

os_disk{
  caching = "ReadWrite"
  storage_account_type = "Standard_LRS"
}
source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  depends_on = [ azurerm_resource_group.terraform ]
}

#its not required in azure devops pipeline as its add with init task:
// # Storage Account
// resource "azurerm_storage_account" "storage" {
//   name                     = var.backend_storage_account_name
//   resource_group_name      = var.resource_group_name
//   location                 = var.location
//   account_tier             = "Standard"
//   account_replication_type = "LRS"
//   enable_https_traffic_only = true
//   tags = {
//     name = "tf-backend"
//   }
//   depends_on = [ azurerm_resource_group.terraform ]
// }

// # Storage Container for Terraform State
// resource "azurerm_storage_container" "terraform" {
//   name                  = "terraform-state"
//   storage_account_name  = var.backend_storage_account_name
//   container_access_type = "private"
//   depends_on = [azurerm_storage_account.storage]
// }