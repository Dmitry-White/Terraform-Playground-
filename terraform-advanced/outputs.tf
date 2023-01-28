output "instance-dns" {
  value = aws_instance.nodejs.public_dns
}

output "private-dns" {
  value = aws_instance.nodejs.private_dns
}
