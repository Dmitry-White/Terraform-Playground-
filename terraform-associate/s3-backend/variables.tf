variable "docker_image_name" {
  type        = string
  description = "Docker Image Name"
  default     = "INVALID"
}

variable "docker_container_name" {
  type        = string
  description = "Docker Container Name"
  default     = "INVALID"
}

variable "docker_external_port" {
  type    = number
  default = 8080
  validation {
    condition     = can(regex("8080|80", var.docker_external_port))
    error_message = "Port values can only be 8080 or 80."
  }
}
