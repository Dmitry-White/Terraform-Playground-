resource "docker_image" "nginx-image" {
  name = var.docker_image_name
}

resource "docker_container" "nginx" {
  name  = var.docker_container_name
  image = docker_image.nginx-image.name

  ports {
    internal = 80
    external = var.docker_external_port
    protocol = "tcp"
  }
}
