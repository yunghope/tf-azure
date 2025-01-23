# modules/ingress-nginx/main.tf
# Création de l'IP publique statique
resource "azurerm_public_ip" "ingress" {
  name                = "ingress-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                = "Standard"

  tags = {
    environment = "Production"
  }
}

# Création du namespace
resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
    labels = {
      "app.kubernetes.io/name" = "ingress-nginx"
    }
  }
}

# Installation de ingress-nginx
resource "helm_release" "ingress_nginx" {
  depends_on = [kubernetes_namespace.ingress_nginx]
  
  name       = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.1"

  set {
    name  = "controller.replicaCount"
    value = "2"
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-ipv4"
    value = azurerm_public_ip.ingress.ip_address
  }

  set {
    name  = "controller.resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "controller.resources.requests.memory"
    value = "256Mi"
  }

  set {
    name  = "controller.resources.limits.cpu"
    value = "200m"
  }

  set {
    name  = "controller.resources.limits.memory"
    value = "512Mi"
  }
}
