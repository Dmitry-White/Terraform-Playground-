output "server_ip" {
  description = "Public IP address of the Minecraft server"
  value       = aws_instance.server
}
