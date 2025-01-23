# Création du namespace monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
    labels = {
      environment = "production"
    }
  }
}


# resource "helm_release" "elasticsearch" {
#   depends_on = [kubernetes_namespace.monitoring]
  
#   name       = "elasticsearch-test"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name
#   repository = "https://helm.elastic.co"
#   chart      = "elasticsearch"
#   version    = "7.17.3"
#   timeout    = 1200
#   atomic     = true # Rollback en cas d'échec
  
#   set {
#     name  = "volumeClaimTemplate.storageClassName"
#     value = "managed-premium"
#   }
  
#   set {
#     name  = "volumeClaimTemplate.resources.requests.storage"
#     value = "10Gi"
#   }

#   set {
#     name  = "minimumMasterNodes"
#     value = "1"
#   }

#   set {
#     name  = "replicas"
#     value = "1"
#   }

#   set {
#     name  = "resources.requests.cpu"
#     value = "500m"
#   }

#   set {
#     name  = "resources.requests.memory"
#     value = "512Mi"
#   }

#   set {
#     name  = "resources.limits.cpu"
#     value = "1000m"
#   }

#   set {
#     name  = "resources.limits.memory"
#     value = "1Gi"
#   }

#   set {
#     name  = "esJavaOpts"
#     value = "-Xmx1g -Xms1g"
#   }

#   set {
#     name  = "persistence.enabled"
#     value = "false"
#   }

#   set {
#     name  = "antiAffinity"
#     value = "soft"
#   }
# }


# # Déploiement de Prometheus via Helm
# resource "helm_release" "prometheus" {
#   depends_on = [kubernetes_namespace.monitoring]
  
#   name       = "prometheus"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-prometheus-stack"
#   version    = "36.2.0"

#   set {
#     name  = "grafana.enabled"
#     value = "true"
#   }

#   set {
#     name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.storageClassName"
#     value = "managed-premium"
#   }

#   set {
#     name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage"
#     value = "10Gi"
#   }
# }