variable "primary_region" {
  type        = string
  description = "Primary Deployment Region"
  default     = "us-east-1"
}

variable "secondary_region" {
  type        = string
  description = "Secondary Deployment Region"
  default     = "us-west-1"
}

# Get Linux AMI ID using SSM Parameter endpoint
data "aws_ssm_parameter" "linuxAmi" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  state = "available"
}