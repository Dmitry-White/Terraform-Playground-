resource "kubernetes_deployment" "tf-k8s-deployment" {
  metadata {
    name = local.kubernetes_deployment_name
    labels = {
      name = local.kubernetes_deployment_label
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = local.kubernetes_deployment_label
      }
    }

    template {
      metadata {
        labels = {
          name = local.kubernetes_deployment_label
        }
      }

      spec {
        container {
          name  = var.container_name
          image = var.container_image_name
        }
      }
    }
  }
}

resource "kubernetes_service" "tf-k8s-service" {
  metadata {
    name = local.kubernetes_service_name
    labels = {
      name = local.kubernetes_service_label
    }
  }

  spec {
    type = "NodePort"
    port {
      port        = 80
      target_port = 80
      node_port   = 30080
    }
  }
}





