#Definizione variabile per informazioni sul gruppo risorse, al posto di BU-MT inserire il proprio
variable "resource_group_name" {
  default     = "BU-MT"
  description = "Name of the default resource group"
}

#Definizione località geografica del gruppo risorse
variable "resource_group_location" {
  default     = "West Europe"
  description = "Geographic location of the default resource group"
}

#Definizione nome subnet per il cluster Kubernetes
variable "subnet_name" {
  default     = "mc-subnet"
  description = "Name of the subnet"
}

#Definizione nome della rete virtuale per il cluster Kubernetes
variable "network_name" {
  default     = "BU-MT-vnet-TF"
  description = "Name of the virtual network"
}
