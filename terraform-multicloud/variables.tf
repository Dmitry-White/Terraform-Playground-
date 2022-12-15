variable "enable_aws" {
  type        = bool
  description = "Enable/Disable AWS Deployment"
  default     = true
}

variable "enable_azure" {
  type        = bool
  description = "Enable/Disable Azure Deployment"
  default     = true
}

variable "instance_count" {
  type        = number
  description = "Number of Instances"
  default     = 2
}

variable "aws_instance_type" {
  type        = string
  description = "AWS Instance Type"
  default     = "t3.micro"
}

variable "azure_instance_type" {
  type        = string
  description = "Azure Instance Type"
  default     = "Standard_DS1_v2"
}
