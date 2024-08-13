variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
  
}

variable "address_prefix" {
  type = list(string)
}

variable "network_security_group_name" {
  type = string 
  
}

variable "network_interface_name" {
  type = string
  
}

variable "vm_name" {
  type = string
  
}
 variable "vm_size" {
  type = string
   
 }

 variable "admin_username" {
  type = string
   
 }

 variable "admin_password" {
  type = string
  sensitive =  true 
   
 }
variable "disable_pass_authentication" {
  type = string
  
}
 variable "computer_name" {
  type = string
 }

variable "os_disk_size" {
  type = number
  
}

variable "backend_storage_account_name" {
  type = string
  
}
