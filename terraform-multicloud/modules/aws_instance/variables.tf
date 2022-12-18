variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to start"
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance size"
  default     = "t3.micro"
}

locals {
  network = {
    full_cidr   = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
  }
  image = {
    ami_id = "<DUMMY_AMI>"
  }
  creds = {
    ssh_key_path = "~/.ssh/id_rsa.pub"
  }
}
