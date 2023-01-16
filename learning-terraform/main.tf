resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    module.web_sg.security_group_id
  ]

  tags = {
    Name = "Learning Terraform"
  }
}

module "web_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web_new"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = data.aws_vpc.default.id

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}
