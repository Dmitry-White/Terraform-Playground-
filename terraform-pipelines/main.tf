module "vpc" {
  source = "./modules/vpc"
  region = var.region

  vpc_range    = var.vpc_range
  subnet_range = var.subnet_range
}

resource "aws_instance" "webserver" {
  ami           = module.vpc.ami_id
  subnet_id     = module.vpc.subnet_id
  instance_type = var.instance_type

  tags = {
    "Name"      = "Terraform-Webserver"
    Environment = var.environment
  }
}
