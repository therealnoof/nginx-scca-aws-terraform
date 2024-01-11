## Set Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

## Configure the AWS Provider
provider "aws" {
  region = var.region
  shared_credentials_files = ["/home/noof/.aws/credentials"]
}
