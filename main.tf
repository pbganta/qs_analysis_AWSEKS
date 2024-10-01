terraform {
  backend "s3" {
      bucket = "statefiles-collection-eks"
      key = "terraform/statefile_qs_EC2_mod_sim.tfstate"
      region = "eu-central-1"
  }
}

provider "aws" {
  region = local.region
}

module "cluster" {
  source = "./cluster"
  # vpc details
  env = var.init.env
  vpc_name = var.init.vpc_name
  vpc_cidr = var.init.vpc_cidr
  # eks details
  cluster_name = var.init.cluster_name
  eks_version  = var.init.eks_version
}
