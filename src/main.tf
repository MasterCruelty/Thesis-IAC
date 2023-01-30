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
resource "null_resource" "enable_autoscale" {
  provisioner "local-exec" {
    command = "az aks update --name ${azurerm_kubernetes_cluster.k8s.name} --resource-group ${var.resource_group_name} --enable-cluster-autoscaler --min-count=3 --max-count=6"
  }
}
