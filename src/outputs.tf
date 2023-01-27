#Nome del cluster k8s
output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}
output "resource_group_name" {
  value = azurerm_kubernetes_cluster.k8s.resource_group_name
}
