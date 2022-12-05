variable "docker_image_name" {
  type        = string
  description = "Docker Image Name and Version"
  default     = "centos:7"
}

variable "docker_container_name" {
  type        = string
  description = "Docker Container Name"
  default     = "terraform-centos"
}

variable "docker_command" {
  type        = list(string)
  description = "Docker Command to Run"
  default     = ["/bin/sleep", "500"]
}
