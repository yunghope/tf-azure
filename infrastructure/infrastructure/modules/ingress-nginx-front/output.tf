output "public_ip" {
  value = azurerm_public_ip.ingress.ip_address
}

output "ingress_namespace" {
  value = kubernetes_namespace.ingress_nginx.metadata[0].name
}