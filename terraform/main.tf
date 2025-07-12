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

resource "azurerm_linux_virtual_machine" "vm_richie" {
    name = var.vm_name
    resource_group_name = azurerm_resource_group.rg_richie.name
    location = azurerm_resource_group.rg_richie.location
    size = "Standard_B1s"
    admin_username = var.admin_username
    
    network_interface_ids = [
        azurerm_network_interface.nic_richie.id,
    ]

    # Conexión por SSH
    disable_password_authentication = true

    admin_ssh_key {
        username = var.admin_username
        public_key = file(var.ssh_public_key)
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-focal"
      sku = "20_04-lts"
      version = "latest"
   }  

   computer_name = var.vm_name
}



