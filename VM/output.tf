output "vm_name" {
    value = azurerm_linux_virtual_machine.terraform.name
  
}

output "azurerm_network_security_group" {
    value = azurerm_network_security_group.terraform.name
  
}

output "network_interface_ids" {
    value = azurerm_network_interface.terraform.id
  
}
