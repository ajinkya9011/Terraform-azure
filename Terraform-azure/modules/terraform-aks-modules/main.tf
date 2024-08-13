#main.tf

provider "azurerm" {
    features {}
  
}

resource "azurerm_resource_group" "aks" {
    name = var.resource_group_name
    location = var.location
  
}

resource "azurerm_virtual_network" "aks" {
  name = var.virtual_network_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.address_space
  depends_on = [ azurerm_resource_group.aks ]
}

resource "azurerm_subnet" "aks" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes = var.address_prefixes
  depends_on = [ "azurerm_resource_group.aks", "azurerm_virtual_network.aks" ]
  
}

resource "azurerm_kubernetes_cluster" "aks" {
    name = var.kubernetes_cluster_name
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = var.dns_prefix
    role_based_access_control_enabled = true
    kubernetes_version = var.kubernetes_version

    default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
    os_disk_size_gb = var.os_disk_size
    max_pods   = 110
    type       = "VirtualMachineScaleSets"
  }
    identity {
      type = "SystemAssigned"
    }
    network_profile {
    network_plugin = "azure"
    network_plugin_mode = "overlay"
    network_policy = "azure"
    pod_cidr       = var.pod_cidr
    service_cidr = var.service_cidr
    dns_service_ip = var.dns_service_ip
    
  }

  depends_on = [ "azurerm_resource_group.aks", "azurerm_virtual_network.aks" ]

}
#its not required in azure devops pipeline as its add with init task:
# # Storage Account
# resource "azurerm_storage_account" "storage" {
#   name                     = "akstfajinkya"
#   resource_group_name      = var.resource_group_name
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   enable_https_traffic_only = true
#   tags = {
#     name = "tf-backend"
#   }
# }

# // # Storage Container for Terraform State
# // resource "azurerm_storage_container" "aks" {
# //   name                  = "terraform-aks"
# //   storage_account_name  = var.storage_account_name
# //   container_access_type = "private"
# // }
