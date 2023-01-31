module "vpc" {
  source = "./modules/vpc"
  region = var.region

  vpc_range    = "10.0.0.0/16"
  subnet_range = "10.0.1.0/24"
}

resource "aws_instance" "webserver" {
  ami           = module.vpc.ami_id
  subnet_id     = module.vpc.subnet_id
  instance_type = "t3x.micro"
}
