output "docker_id" {
  value       = docker_container.terraform-container.id
  description = "Docker Container ID"
}

output "docker_ip" {
  value       = docker_container.terraform-container.network_data[0].ip_address
  description = "Docker Container IP"
}