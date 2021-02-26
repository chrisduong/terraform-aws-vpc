provider "aws" {
  region = "eu-west-1"
}

resource "aws_subnet" "test" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Test"
  }
}

// The purpose of `var.create_vpc` provide the no-op so that you can turn off this module, to test the module which depends on this module
module "vpc" {
  source     = "../../"
  create_vpc = false
  name       = "simple-example"

  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "euw1-az3"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = true

  enable_nat_gateway = false
  single_nat_gateway = true

  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true

  public_subnet_tags = {
    Name = "overridden-name-public"
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-name"
  }
}

