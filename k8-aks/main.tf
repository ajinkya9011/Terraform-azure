#main.tf

provider "azurerm" {
    features {}
}

module "aks" {
  source = "../modules/terraform-aks-modules"

  resource_group_name        = "my-resource-group"
  location                   = "East US"
  virtual_network_name       = "my-vnet"
  subnet_name                = "my-subnet"
  address_space = [ "10.0.0.0/16" ]
  address_prefixes    = ["10.0.1.0/24"]
  kubernetes_cluster_name = "terraform-aks"
  dns_prefix                 = "myaks"
  kubernetes_version         = "1.29.7"
  node_count                 = 3
  node_pool_name = "aks"
  vm_size                    = "Standard_D4ds_v5"
  os_disk_size            = 30
  pod_cidr                   = "10.244.0.0/16"
  service_cidr               = "10.0.0.0/24"
  dns_service_ip = "10.0.0.10"
  #storage_account_name = "ajinkyatfbackendstorage"
}


