provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg_richie" {
    name = var.azurerm_group_name
    location = var.location
}

resource "azurerm_container_registry" "acr_richie" {
    name = var.acr_name
    resource_group_name = azurerm_resource_group.rg_richie.name
    location = azurerm_resource_group.rg_richie.location
    sku = "Basic"
    admin_enabled = true
}