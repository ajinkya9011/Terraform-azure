output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0
}

# output "kube_config_raw" {
#   value = azurerm_kubernetes_cluster.aks.kube_config.0.raw_kube_config
# }
