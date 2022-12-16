variable "instance_name" {
  type        = string
  description = "Value of the Name tag for the EC2 instance"
  default     = "Terraform-Instance"
}

variable "subnet_id" {
  type        = string
  description = "EC2 VPC subnet"
  default     = "<DUMMY_SUBNET>"
}

locals {
  image = {
    ami_id = "<DUMMY_AMIs>"
  }
}