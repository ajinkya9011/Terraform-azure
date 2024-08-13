# terraform.tfvars

resource_group_name       = "terraform"
location                  = "East US"
virtual_network_name      = "terraform-vnet"
address_space             = ["10.0.0.0/16"]
subnet_name               = "terraform-subnet"
address_prefix            = ["10.0.1.0/24"]
network_security_group_name = "terraform-sg"
network_interface_name    = "terraform-nic"
vm_name                   = "terraform-vm"
vm_size                   = "Standard_B1s"
admin_username            = "azureuser"
admin_password            = "P@ssw0rd1234"  # Ensure to use a secure password
disable_pass_authentication = "false"
os_disk_size              = 30
computer_name             = "terraform"
backend_storage_account_name = "ajinkyatfbackendstorage"

