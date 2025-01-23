# 1. Création du namespace en premier
resource "kubernetes_namespace" "backend" {
  metadata {
    name = "backend"
    labels = {
      environment = "production"
      app         = "backend"
    }
  }
}

# 2. Deployment avec référence au namespace
resource "kubernetes_deployment" "backend" {
  depends_on = [kubernetes_namespace.backend]

  metadata {
    name      = "backend-deployment"
    namespace = kubernetes_namespace.backend.metadata[0].name
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image = "${var.acr_server}/backend:latest"
          name  = "backend"

          env {
            name  = "POSTGRES_HOST"
            value = var.pg_hostname
          }
          
          env {
            name  = "POSTGRES_USER"
            value = var.postgresql_server_admin_login
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.postgresql_server_admin_password
          }

          env {
            name  = "APPLICATIONINSIGHTS_CONNECTION_STRING"
            value = var.app_insights_connection_string
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 80
            }

            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}

# 3. Service avec référence au namespace
resource "kubernetes_service" "backend" {
  depends_on = [kubernetes_namespace.backend]

  metadata {
    name      = "backend-service"
    namespace = kubernetes_namespace.backend.metadata[0].name
  }
  spec {
    selector = {
      app = "backend"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}


# resource "azurerm_monitor_diagnostic_setting" "backend" {
#   depends_on = [kubernetes_deployment.backend]

#   name                       = "backend-diag"
#   target_resource_id         = kubernetes_deployment.backend.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   log_analytics_destination_type = "Dedicated"

#   metric {
#     category = "AllMetrics"
#     enabled  = true
#   }
# }
