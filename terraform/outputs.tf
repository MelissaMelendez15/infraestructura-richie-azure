output "public_ip" {
    value = azurerm_public_ip.public_ip_richie.ip_address
}

output "vm_name" {
    value = azurerm_linux_virtual_machine.vm_richie.name
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.aks_richie.kube_config_raw
    sensitive = true
}

output "aks_name" {
    value = azurerm_kubernetes_cluster.aks_richie.name
}
