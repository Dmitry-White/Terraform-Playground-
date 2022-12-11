variable "instance_count" {
  type        = number
  description = "Number of VM instances to start"
  default     = 1
}

variable "instance_type" {
  type        = string
  description = "VM Instance size"
  default     = "Standard_DS1_v2"
}

locals {
  network = {
    full_cidr   = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
  }

  image = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  creds = {
    username     = "<VM_USER>"
    password     = "<VM_PASSWORD>"
    ssh_key_path = "~/.ssh/id_rsa.pub"
  }
  storage = {
    caching      = "ReadWrite"
    account_type = "Standard_LRS"
  }
  resources = {
    name     = "Terraform-SG"
    location = "centralus"
  }
}
