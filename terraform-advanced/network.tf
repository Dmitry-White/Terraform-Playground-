module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "frontend-vpc"
  cidr   = var.vpc_cidr

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  # one_nat_gateway_per_az = true
}
