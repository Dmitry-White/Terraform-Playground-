variable "instance_ami" {
  description = "Value of the AMI used for the EC2 instance"
  type        = string
  default     = "ami-03b8c4c9d51a08999"
}

variable "subnet_id" {
  description = "Value of the subnet id used for the EC2 instance"
  type        = string
  default     = "subnet-09e0630e44b1125af"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "TheFastestManAlive"
}
