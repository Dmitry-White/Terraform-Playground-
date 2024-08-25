variable "region" {
  type        = string
  description = "Region to deploy to"
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to provision"
}

variable "ssh_key_path" {
  type        = string
  description = "Minecraft SSH Key Path"
}

variable "profile" {
  type        = string
  description = "AWS Profile to use"
}

locals {
  server_name       = "minecraft-server"
  sg_name           = "minecraft-server-sg"
  ssh_key           = "minecraft-server-key"
  node_user         = "ubuntu"
  home_path         = "/home/${local.node_user}"
  image_owner       = "amazon"
  image_filter_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  image_filter_type = "hvm"

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
