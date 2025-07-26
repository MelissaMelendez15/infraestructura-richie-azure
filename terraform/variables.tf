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
}

variable "acr_name" {
    description = "Nombre del azure Container Registry"
    type = string
}

variable "vm_name" {
    description = "Nombre de la VM"
    type = string
    default = "vm-richie"
}

variable "admin_username" {
    description = "Usuario administrador"
    type = string
    default = "meli"
}

variable "admin_password" {
    description = "Contraseña de la VM"
    type = string
}

# Variable para clave pública
variable "ssh_public_key" {
    description = "Clave pública ssh para acceder a la VM"
    type = string
}

# Variable para AKS
variable "aks_name" {
    type = string
    description = "Nombre del clúster AKS"
    default = "aks-richie"
}