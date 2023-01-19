module "web_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "VPC for web-server"
  cidr = "10.0.0.0/16"

  azs            = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Scope       = "Lab"
  }
}

module "web_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web_new"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.web_vpc.public_subnets[0]

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Scope       = "Lab"
  }
}
module "web_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "web-server-alb"

  load_balancer_type = "application"

  vpc_id          = module.web_vpc.vpc_id
  subnets         = module.web_vpc.public_subnets
  security_groups = [module.web_sg.security_group_id]

  target_groups = [
    {
      name_prefix      = "web-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Scope       = "Lab"
  }
}

module "web_autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.7.0"

  name     = "web"
  min_size = 1
  max_size = 2

  image_id      = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  vpc_zone_identifier = module.web_vpc.public_subnets
  target_group_arns   = module.web_alb.target_group_arns
  security_groups = [
    module.web_sg.security_group_id
  ]
}
