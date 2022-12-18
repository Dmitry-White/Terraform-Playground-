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

# Historically, the "null_data_source" was typically used to
# construct intermediate values to re-use elsewhere in configuration.
# The same can now be achieved using locals.
data "null_data_source" "ec2_values" {
  inputs = {
    ec2_instance_type = "t3.micro"
  }
}
