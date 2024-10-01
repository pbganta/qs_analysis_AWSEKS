module "vpc_with_subnets" {
    source = "../modules/vpc_and_subnets"
    name     = var.vpc_name
    vpc_cidr = var.vpc_cidr
    # natgate ways
    enable_nat_gateway = true
    single_nat_gateway = false
    one_nat_gateway_per_az = true
    # DNS Support
    enable_dns_hostnames = true
    enable_dns_support = true
    newbits = var.newbits
    netnum = var.netnum 
}

module "eks_with_node_group" {
    source = "../modules/eks"
    eks_cluster_name = "${var.cluster_name}-${var.env}"
    k8s_version      = var.eks_version
    vpc_id                     = module.vpc_with_subnets.vpc_id
    eks_node_groups_subnet_ids = module.vpc_with_subnets.private_subnets
    control_plane_subnet_ids   = module.vpc_with_subnets.private_subnets
}
