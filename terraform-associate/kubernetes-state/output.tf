output "kubernetes_service_hostname" {
  value       = kubernetes_service.tf-k8s-service.status[0].load_balancer[0].ingress[0].hostname
  description = "Kubernetes Service Hostname"
}