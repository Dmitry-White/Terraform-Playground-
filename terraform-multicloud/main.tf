module "aws_server" {
  source = "./modules/aws_instance"

  count = var.enable_aws ? 1 : 0

  instance_count = var.instance_count
  subnet    = var.aws_subnet
}

module "azure_server" {
  source = "./modules/azure_instance"

  count = var.enable_azure ? 1 : 0

  instance_count               = var.instance_count
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}