output "PrivateIP" {
  description = "Private IP of EC2 instance"
  value       = aws_instance.webserver.private_ip
}
