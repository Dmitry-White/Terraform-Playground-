module "vpc-module" {
  source = "./modules/vpc"

  network_name = "Terraform-Network"
  vpc_range    = "10.0.0.0/16"
  subnet_range = "10.0.1.0/24"
}

module "ec2-module" {
  source = "./modules/ec2"

  instance_name = "Terraform-EC2"
  subnet_id     = module.vpc-module.subnet_id
}
