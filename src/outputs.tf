#File per definire i valori di output da tirare fuori dal file di configurazione di Terraform
#Una volta creata la risorsa, tramite questi campi è possibile con un comando stamparli su terminale.

#Nome del cluster k8s
output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}
#Nome del gruppo risorse
output "resource_group_name" {
  value = azurerm_kubernetes_cluster.k8s.resource_group_name
}
