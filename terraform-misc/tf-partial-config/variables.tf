variable "region" {
  type        = string
  description = "Deployment Region"
  default     = "eu-central-1"
}

variable "instance_type" {
  type        = string
  description = "Deployment Instance Type"
  default     = "t3.micro"
}

variable "vpc_range" {
  type        = string
  description = "Deployment VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "subnet_range" {
  type        = string
  description = "Deployment Subnet CIDR"
  default     = "10.0.1.0/24"
}
