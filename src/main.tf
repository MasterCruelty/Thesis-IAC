resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s-cluster-iac"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "exampleprefix"

  default_node_pool {
    name       = "agent"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
    max_pods   = 110
  }
  identity {
    type = "SystemAssigned"
  }
}

#Definizione autoscale Azure
resource "azurerm_kubernetes_cluster_node_pool" "autoscale" {
  name                  = "k8sautoscale"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = "Standard_DS2_v2"
  enable_auto_scaling   = true
  node_count            = 3
  min_count             = 3
  max_count             = 6
}
