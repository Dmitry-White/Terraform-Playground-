variable "region" {
  type        = string
  description = "Region to deploy to"
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to provision"
}

variable "public_key_path" {
  type        = string
  description = "Minecraft Public SSH Key Path"
}

variable "profile" {
  type        = string
  description = "AWS Profile to use"
}

variable "server_bucket" {
  type        = string
  description = "AWS S3 Bucket to use as a server save location"
}

variable "server_bucket_game_folder" {
  type        = string
  description = "AWS S3 Bucket game folder to use as a server save location"
}

locals {
  scope = "minecraft"
  name = "${local.scope}-server"

  server = {
    name               = local.name
    memory             = "2G"
    bucket_role_name   = "${local.name}-role"
    bucket_role_policy = "${local.name}-role-policy"
    profile            = "${local.name}-profile"
    sg_name            = "${local.name}-sg"
    public_ssh_key     = "${local.name}-key"
  }

  image_filter = {
    owner = "amazon"
    name  = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    type  = "hvm"
  }

  user_data_file = "./scripts/user_data.sh"

  ingress_rules = [
    {
      port     = 22
      protocol = "tcp"
    },
    {
      port     = 25565
      protocol = "tcp"
    },
    {
      port     = 19132
      protocol = "udp"
    },
    {
      port     = 19133
      protocol = "udp"
    },
    {
      port     = 25565
      protocol = "udp"
    }
  ]
}
