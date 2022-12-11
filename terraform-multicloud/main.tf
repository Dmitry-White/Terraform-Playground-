module "aws_server" {
  source = "./modules/aws_instance"

  count = var.enable_aws ? 1 : 0

  instance_count = var.instance_count
  instance_type  = var.aws_instance_type
}

module "azure_server" {
  source = "./modules/azure_instance"

  count = var.enable_azure ? 1 : 0

  instance_count = var.instance_count
  instance_type  = var.azure_instance_type
}
