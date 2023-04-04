#Definizione della risorsa di tipo cluster Kubernetes
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s-cluster-iac-${random_string.suffix.result}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-dns"
  #sku_tier            = "Paid"

  default_node_pool {
    name                = "agent"
    node_count          = 3
    vm_size             = "Standard_DS2_v2"
    max_pods            = 30
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 6
    #vnet_subnet_id      = data.azurerm_subnet.my_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    random_string.suffix
  ]
}

#Definizione della subnet e rete virtuale entro cui collocare il cluster Kubernetes
data "azurerm_subnet" "my_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.network_name
  resource_group_name  = var.resource_group_name
}

#risorsa di tipo stringa per generare il suffisso di 3 caratteri casuali sul nome della risorsa
resource "random_string" "suffix" {
  length  = 3
  special = false
}
