# Image to be used by container
resource "docker_image" "terraform-image" {
  name         = var.docker_image_name
  keep_locally = true
}

# Create a container
resource "docker_container" "terraform-container" {
  image   = docker_image.terraform-image.name
  name    = var.docker_container_name
  start   = true
  command = var.docker_command
}