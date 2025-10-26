variable "aws_access_key" {
  type        = string
  description = "AWS access key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
  sensitive   = true
}

variable "aws_region" {
  type        = string
  description = "AWS aws_region"
  default     = "us-east-1"
}

variable "aws_vpc_id" {
  type        = string
  description = "vpc"
  default     = "vpc-0d1e1bc0837f6ac36"
}

variable "aws_public_subnet_id" {
  type        = string
  description = "AWS aws_region"
  default     = "subnet-04c762ea86aff0aa1"
}

variable "ubuntu_ami" {
  type        = string
  description = "AMI id for ubuntu machine"
  default     = "ami-020cba7c55df1f615"
  #  default = "ami-033c055cd246e8cdb"
}


variable "os_to_deploy" {
  type        = string
  description = "(Required: amazon_linux or ubuntu) OS where application needs to deploy"
  default     = "ubuntu"

  validation {
    condition     = contains(["amazon_linux", "ubuntu"], var.os_to_deploy)
    error_message = "The 'os_to_deploy' variable must be one of 'amazon_linux', 'ubuntu'"
  }
}


locals {
  OS_user = var.os_to_deploy == "ubuntu" ? "ubuntu" : "ec2-user"
}

locals {
  deploy_file = var.os_to_deploy == "ubuntu" ? "deploy_ubuntu.sh" : "deploy_amazon_linux.sh"
}

locals {
  install_jenkins = "install_jenkins.sh"
}