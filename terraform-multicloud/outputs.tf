output "aws_instances" {
  value = module.aws_server.*.instance_name
}

output "azure_instances" {
  value = module.azure_server.*.instance_name
}
