variable "network_name" {
  type        = string
  description = "Value of the Name for VPC resources"
}

variable "vpc_range" {
  type        = string
  description = "VPC IP Range"
}

variable "subnet_range" {
  type        = string
  description = "Subnet IP Range"
}
