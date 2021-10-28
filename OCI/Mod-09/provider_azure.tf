provider "azurerm" {
  features {}
}

variable "Azure_Location" {
    type = string
    default = "eastus"  
}

