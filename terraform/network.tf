# Creación de la red
resource "azurerm_virtual_network" "vnet_richie" {
    name = "vnet_richie"
    location = var.location
    resource_group_name = azurerm_resource_group.rg_richie.name
    address_space = ["10.0.0.0/16"]
}

# Creación de la subred
resource "azurerm_subnet" "subnet_richie" {
    name = "subnet_richie"
    resource_group_name = azurerm_resource_group.rg_richie.name
    virtual_network_name = azurerm_virtual_network.vnet_richie.name
    address_prefixes = ["10.0.1.0/24"]
}

# Creación de la IP pública
resource "azurerm_public_ip" "public_ip_richie" {
    name = "public_ip_richie"
    location = var.location
    resource_group_name = azurerm_resource_group.rg_richie.name
    allocation_method = "Static" #para que sea una ip fija. Aunque se apague/prenda la VM
    sku = "Standard" 
}

# Creación de la Interfaz de red
# Es el móden que conecta la VM a la red y le asigna la IP (pública y privada)

resource "azurerm_network_interface" "nic_richie" {
    name = "nic_richie"
    location = var.location
    resource_group_name = azurerm_resource_group.rg_richie.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.subnet_richie.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.public_ip_richie.id
    }
}

# Se crea el NSG con la regla de SSH(puerto 22)
resource "azurerm_network_security_group" "nsg_richie" {
    name = "nsg_richie"
    location = var.location
    resource_group_name = var.azurerm_group_name

   # Regla de SSH(puerto 22)
    security_rule {
        name = "Allow-SSH"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
    
    # Se agrega segunda regla para utilizar el puerto 8080:80
    security_rule {
        name = "Allow-SSH-8080"
        priority = 1002
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "8080"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
}

# Se asocia el NSG a la Subred
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_richie" {
    subnet_id = azurerm_subnet.subnet_richie.id
    network_security_group_id = azurerm_network_security_group.nsg_richie.id
}