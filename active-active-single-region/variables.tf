# Terraform Variables

variable "prefix" {
  description = "Prefix for object creation"
  type        = string
  default     = "demo"
}

variable "region" {
  description = "AWS Gov Region"
  type        = string
  default     = "us-gov-east-1"
}

variable "az" {
  description = "AWS Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "ec2_key_name" {
  description = "AWS EC2 Key name for SSH access"
  type        = string
}


variable "admin_password" {
  description = "Password for the BIG-IP GUI/API"
  type        = string
  default     = "PleaseChangeM3!"
}

variable "mgmt_src_addr_prefixes" {
  description = "Allowed source IP prefixes for management access"
  type        = list(string)
}

variable "vpc_cidrs" {
  description = "VPC subnets (CIDR)"
  type        = map(string)
}

variable "app_vip" {
  description = "IP address of BIG-IP virtual server"
  type        = string
}
