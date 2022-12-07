variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_range" {
  type        = string
  description = "VPC IP Range"
  default     = "10.0.0.0/16"
}

variable "subnet_range" {
  type        = string
  description = "Subnet IP Range"
  default     = "10.0.1.0/24"
}

data "aws_ssm_parameter" "webserver-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}
