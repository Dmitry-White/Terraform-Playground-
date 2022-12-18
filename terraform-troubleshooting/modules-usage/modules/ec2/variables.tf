variable "instance_name" {
  type        = string
  description = "Value of the Name tag for the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "VPC IP Range"
}

locals {
  image = {
    ami_id = "<DUMMY_AMI>"
  }
}