resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s-cluster-iac-${random_string.suffix.result}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "exampleprefix"

  default_node_pool {
    name                = "agent"
    node_count          = 3
    vm_size             = "Standard_DS2_v2"
    max_pods            = 30
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 6
    vnet_subnet_id      = data.azurerm_subnet.my_subnet.id
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin = "azure"
    service_cidr = "10.2.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip = "10.2.0.10"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "random_string" "suffix" {
  length  = 3
  special = false
}

data "azurerm_subnet" "my_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.network_name
  resource_group_name  = var.resource_group_name
}
