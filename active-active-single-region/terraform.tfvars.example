################################################################################
###                            EXAMPLE TFVARS FILE                           ###
################################################################################
### Copy this file to 'terraform.tfvars' and modify as required              ###
### The new terraform.tfvars file will be ignored in git commits.            ###
################################################################################

## Custom Variable Values

# Prefix for object creation
prefix = "nginx-scca"

# Name for AWS EC2 key
ec2_key_name = "nginx-scca-keypair"

# Source list for management security group
# !!! Add your own source IP and bitmask here to restrict access!!!
mgmt_src_addr_prefixes = ["0.0.0.0/0"]

# AWS location
region = "us-east-1"
az_1     = "us-east-1a"
az_2     = "us-east-1b"

# VPC subnets
vpc_cidrs = {
  vpc                 = "10.0.0.0/16"
  management_az1      = "10.0.1.0/24"
  management_az2      = "10.0.2.0/24"
  external_az1        = "10.0.3.0/24"
  external_az2        = "10.0.4.0/24"
  dmz_ingress_az1     = "10.0.5.0/24"
  dmz_ingress_az2     = "10.0.6.0/24"
  dmz_egress_az1      = "10.0.7.0/24"
  dmz_egress_az2      = "10.0.8.0/24"
  internal_az1        = "10.0.9.0/24"
  internal_az2        = "10.0.10.0/24"
  application         = "192.168.1.0/24"
}


# Nginx+ instance type
instance_type = "t3.large"


# AMI IDs (Region-specific)
inspection_ami = "ami-03f535c1f557d8eab" ### us-gov-east-1 ### Ubuntu Server 22.04 LTS 
webapp_ami     = "ami-03f535c1f557d8eab" ### us-gov-east-1 ### Ubuntu Server 22.04 LTS running Docker with Juiceshop

