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
  depends_on = [
    random_string.suffix
  ]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "k8s-iac-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "k8s-iac-ingress-rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = ["*"]
    destination_address_prefix = data.azurerm_subnet.my_subnet.address_prefix
  }
}


data "azurerm_subnet" "my_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.network_name
  resource_group_name  = var.resource_group_name
}

resource "random_string" "suffix" {
  length  = 3
  special = false
}
