output "service_name" {
  value = kubernetes_service.backend.metadata[0].name
}

output "deployment_name" {
  value = kubernetes_deployment.backend.metadata[0].name
}

output "namespace" {
  value = kubernetes_namespace.backend.metadata[0].name
}
