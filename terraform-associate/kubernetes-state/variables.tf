variable "container_image_name" {
  type        = string
  description = "Container Image Name"
  default     = "nginx"
}

variable "container_name" {
  type        = string
  description = "Container Name"
  default     = "nginx"
}

locals {
  kubernetes_deployment_name  = "tf-k8s-deploy"
  kubernetes_deployment_label = "terraform-k8s-deployment"

  kubernetes_service_name  = "tf-k8s-service"
  kubernetes_service_label = "terraform-k8s-service"
}