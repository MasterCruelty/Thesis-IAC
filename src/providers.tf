#Questo file fornisce a Terraform informazioni essenziali sul provider.
#  In questo caso è Azure, quindi durante il comando init andrà a recuperare le componenti necessarie per Azure.
#  Dunque durante l'esecuzione del comando terraform init, verranno installate tutte quelle componenti necessarie
#  a compilare e eseguire il codice definito nel main.
#  Inoltre è stata definita un numero di versione minimo per Terraform per eseguire il codice.

terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}
