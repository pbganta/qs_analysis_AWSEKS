terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

data "aws_availability_zones" "available" {}

locals {
  newbits = var.newbits
  netcount = var.netnum
  all_subnets = [for i in range(local.netcount) : cidrsubnet(var.vpc_cidr, local.newbits, i)]
  public_subnets  = slice(local.all_subnets, 0, 1)
  private_subnets = slice(local.all_subnets, 2, 3)
}

module "vpc_and_subnets" {
  # invoke public vpc module
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  azs = slice(data.aws_availability_zones.available.names, 0, 1)
  cidr = var.vpc_cidr
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  # tags for public, private subnets and vpc
  tags                = var.tags
  public_subnet_tags  = var.additional_public_subnet_tags
  private_subnet_tags = var.additional_private_subnet_tags

  # create internet gateway
  create_igw       = var.create_igw
  instance_tenancy = var.instance_tenancy
}
