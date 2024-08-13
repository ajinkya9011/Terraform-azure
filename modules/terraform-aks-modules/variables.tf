#variable.tf

variable "location" {
  type = string
}

variable "resource_group_name" {
  type =string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}
variable "address_prefixes" {
  type = list(string)
}

variable "kubernetes_cluster_name" {
  type = string
}
variable "kubernetes_version" {
  type = string
}

variable "dns_prefix" {
  type = string
}
variable "node_pool_name" {
  type = string
}

variable "node_count" {
  type = number
}
variable "vm_size" {
  type = string
}

variable "os_disk_size" {
  type = number
}

variable "pod_cidr" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
  
}

# variable "storage_account_name" {
#   type = string
# }