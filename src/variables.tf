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

#Definizione service principal(i valori vanno settati in un file terraform.tfvars)
variable "aks_service_principal_app_id" {
  default = ""
}
variable "aks_service_principal_client_secret" {
  default = ""
}
