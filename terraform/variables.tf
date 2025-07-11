variable "azurerm_group_name" {
  description = "Nombre del grupo de recursos"
  type = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type = string
} 

variable "location" {
    description = "Ubicación de los recursos"
    type = string
    default = "westeurope"
}

variable "acr_name" {
    description = "Nombre del azure Container Registry"
    type = string
}

