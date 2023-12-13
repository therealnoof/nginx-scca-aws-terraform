# Terraform Variables

variable "prefix" {
  description = "Prefix for object creation"
  type        = string
  default     = "nginx-scca"
}

variable "region" {
  description = "AWS Gov Region"
  type        = string
  default     = "us-gov-east-1"
}

variable "az_1" {
  description = "AWS Availability Zone"
  type        = string
  default     = "us-gov-east-1a"
}

variable "az_2" {
  description = "AWS Availability Zone"
  type        = string
  default     = "us-gov-east-1b"
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
  description = "IP address of NLB listener"
  type        = string
}

variable "webapp_ami" {
  description = "Test web app AMI - Ubuntu Server 22.04 LTS running Docker with Juiceshop"
  type        = string
  default     = "ami-03f535c1f557d8eab"
}