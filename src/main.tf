resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "k8s-cluster-iac-${random_string.suffix.result}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  #dns_prefix          = "exampleprefix"

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

  http_proxy_config {
    http_proxy = "http://40.118.0.94:8083/"
    trusted_ca = base64encode("-----BEGIN CERTIFICATE-----\nMIIDkDCCAngCCQDMQQLWwrOH5jANBgkqhkiG9w0BAQsFADCBiTELMAkGA1UEBhMCSVQxDjAMBgNVBAgMBU1pbGFuMQ0wCwYDVQQHDARDaXR5MRQwEgYDVQQKDAtDb21wYW55IEx0ZDEUMBIGA1UEAwwLNDAuMTE4LjAuOTQxLzAtBgkqhkiG9w0BCQEWIHJvYmVydG8uYW50b25pZWxsb0BjZXJ0aW1ldGVyLml0MB4XDTIzMDMwMjEwMDI1MFoXDTI0MDMwMTEwMDI1MFowgYkxCzAJBgNVBAYTAklUMQ4wDAYDVQQIDAVNaWxhbjENMAsGA1UEBwwEQ2l0eTEUMBIGA1UECgwLQ29tcGFueSBMdGQxFDASBgNVBAMMCzQwLjExOC4wLjk0MS8wLQYJKoZIhvcNAQkBFiByb2JlcnRvLmFudG9uaWVsbG9AY2VydGltZXRlci5pdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALUXjwLcT9nq/HwqqIgqOsZPyucfrRdH3WAKgL/xAXXUDjMnj7POmVul5mFLquhOKcUgmTstE8KL3F8RuIANA4NE/MnGlX+piE/nXRh+Qb0fjbbrfrC+4FGdqZjiTqLJAm08ZROFenC+5lmrT4vmTpMcoJl38KUAhlbLYfc1n8ssxSvvAypzXmSjoPunfP8gJ9OQ+6lvkizzI47Hqpnbh+PZhUO9x55SAnuQPTztwgxXWsCryLYiFD0GQtgBEQJw2ffbaYqUmFLGWFVttBWbZ/f/xK+LPHE41LYm/snUur0/9k9BLLGac/0nSXbFYQMSjLrLdYGob0ongmxcMSy4HTECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEABzncOiqVSVD537xaORz2iagm/gGtlKV0HFn4OnxdF1GystXQznfb5HJVQd7Use8J/x2xC2CBaC1sbxTrhmYRNgiJlJitlSH4ersVxHkZ9f6aCbJMSMTxVKJ2zEa93WTLfNx+OC0K4td/oksCzVGunCE05dO9tK3q0o/45v8YxOoz0hqhXYFXgEVFjffJ2oXEz6MYdGBDqucq99J+VbwnLdgdVkYGvBLjJI4FGkkeW/wk5lRCVVj8us00txGJSXgTE9NGWryjKXUSFsipQZg2/R0ST7JaAIO4QLFpvV7C40CK0cyKPUS1KtgXs+RvC4oLdtRROI9P5L2tI2AP4Tc3CQ==\n-----END CERTIFICATE-----")
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    random_string.suffix
  ]
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
