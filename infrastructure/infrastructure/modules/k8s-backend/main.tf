resource "kubernetes_namespace" "backend" {
  metadata {
    name = "backend-${var.environment}"
    labels = {
      environment = var.environment
      app         = "backend"
      managed-by  = "terraform"
    }
  }
}

resource "kubernetes_deployment" "backend" {
  depends_on = [kubernetes_namespace.backend]

  metadata {
    name      = "backend-deployment-${var.environment}"
    namespace = kubernetes_namespace.backend.metadata[0].name
    labels = {
      app         = "backend"
      environment = var.environment
      managed-by  = "terraform"
    }
  }

  spec {
    # Nombre de replicas selon l'environnement
    replicas = var.environment == "prod" ? 3 : (
      var.environment == "recette" ? 2 : 1
    )

    selector {
      match_labels = {
        app         = "backend"
        environment = var.environment
      }
    }

    template {
      metadata {
        labels = {
          app         = "backend"
          environment = var.environment
        }
      }

      spec {
        container {
          image = "${var.acr_server}/backend:${var.environment}"
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

          # Resources selon l'environnement
          resources {
            limits = {
              cpu    = var.environment == "prod" ? "2.0" : (
                var.environment == "recette" ? "1.0" : "0.5"
              )
              memory = var.environment == "prod" ? "2Gi" : (
                var.environment == "recette" ? "1Gi" : "512Mi"
              )
            }
            requests = {
              cpu    = var.environment == "prod" ? "1.0" : (
                var.environment == "recette" ? "500m" : "250m"
              )
              memory = var.environment == "prod" ? "1Gi" : (
                var.environment == "recette" ? "512Mi" : "256Mi"
              )
            }
          }

          # Healthcheck plus strict en prod
          liveness_probe {
            http_get {
              path = "/health"
              port = 80
            }

            initial_delay_seconds = var.environment == "prod" ? 20 : 30
            period_seconds        = var.environment == "prod" ? 5 : 10
            failure_threshold     = var.environment == "prod" ? 2 : 3
          }

          # Readiness probe pour prod et recette
          dynamic "readiness_probe" {
            for_each = var.environment != "dev" ? [1] : []
            content {
              http_get {
                path = "/ready"
                port = 80
              }
              initial_delay_seconds = 10
              period_seconds       = 5
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  depends_on = [kubernetes_namespace.backend]

  metadata {
    name      = "backend-service-${var.environment}"
    namespace = kubernetes_namespace.backend.metadata[0].name
    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }
  spec {
    selector = {
      app         = "backend"
      environment = var.environment
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
