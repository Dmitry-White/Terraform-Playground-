variable "instance_name" {
  type        = string
  description = "Value of the Name tag for the EC2 instance"
  default     = "Terraform-EC2"
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

locals {
  image = {
    ami_id = "ami-0ab4d1e9cf9a1215a"
  }
}
