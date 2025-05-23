provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "mlops-sonic-api-090922321"
    key    = "fastapi/tfstate"
    region = "us-east-1"
  }
}


# create VPC

module "vpc" {
  source = "./modules/vpc"

  name = "fast-api-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  tags = {
    Project = "fast-api"
  }
}