output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.subnet.id
}

output "ami_id" {
  description = "Webserver Instance AMI"
  value       = data.aws_ssm_parameter.webserver-ami.value
}