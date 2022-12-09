output "instance_name" {
  value = aws_instance.instance.*.tags.Name
}