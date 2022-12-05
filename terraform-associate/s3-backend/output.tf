output "url" {
  description = "Browser URL for container site"
  value       = join(":", ["http://localhost", tostring(var.docker_external_port)])
}