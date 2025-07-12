output "public_ip" {
    value = azurerm_public_ip.public_ip_richie.ip_address
}

output "vm_name" {
    value = azurerm_linux_virtual_machine.vm_richie.name
}