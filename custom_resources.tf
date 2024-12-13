
# Loading custom resources for clusters that require these
# Ideally, this would be a single module befind a "use_custom_resources" flag, 
# but module source paths must be known (cannot use variables)

###############################
# cloud-dev-euw1
###############################
module "cloud_dev_euw1_custom" {
  count  = var.client == "cloud" && var.env == "dev" ? 1 : 0
  source = "./custom_resources/cloud_dev_euw1"

  # Providers
  providers = {
    aws.vector_eks_euw1 = aws.vector_eks_euw1
  }

  # root module variables
  client = var.client
  env    = var.env

  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
  sg_control_plane_01           = module.eks_stack.sg_control_plane_01_id
  msk_cluster_arn               = module.eks_stack.msk_cluster_arn
}

###############################
# cloud-perf-euw1
###############################
module "cloud_perf_euw1_custom" {
  count  = var.client == "cloud" && var.env == "perf" ? 1 : 0
  source = "./custom_resources/cloud_perf_euw1"

  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
}

###############################
# cloud-test-euw1
###############################
module "cloud-test-euw1_custom" {
  count  = var.client == "cloud" && var.env == "test" ? 1 : 0
  source = "./custom_resources/cloud-test-euw1"

  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
}

###############################
# cloud-auto-euw1
###############################
module "cloud-auto-euw1_custom" {
  count  = var.client == "cloud" && var.env == "auto" ? 1 : 0
  source = "./custom_resources/cloud_auto_euw1"

  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
}

###############################
# cloud-uat-euw1
###############################
module "cloud_uat_euw1_custom" {
  count  = var.client == "cloud" && var.env == "uat" ? 1 : 0
  source = "./custom_resources/cloud_uat_euw1"

  # Providers
  providers = {
    aws.vector2_euw1 = aws.vector2_euw1
  }

  # General environment variables
  client = var.client
  env    = var.env

  # EKS stack variables
  eks_vpc_id                    = module.eks_stack.vpc_id
  eks_region_id                 = module.eks_stack.region_id
  eks_private_subnet_ids        = module.eks_stack.private_subnet_ids
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
}

###############################
# cloud-prod-euw1
###############################
module "cloud_prod_euw1_custom" {
  count  = var.client == "cloud" && var.env == "prod" ? 1 : 0
  source = "./custom_resources/cloud_prod_euw1"

  # Providers
  providers = {
    aws.vector2_euc1 = aws.vector2_euc1
    aws.vector2_euw1 = aws.vector2_euw1
  }

  # General environment variables
  client = var.client
  env    = var.env

  # EKS stack variables
  eks_vpc_id                    = module.eks_stack.vpc_id
  eks_region_id                 = module.eks_stack.region_id
  eks_private_subnet_ids        = module.eks_stack.private_subnet_ids
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
}

###############################
# galago-dev-euw1
###############################
module "galago_dev_euw1_custom" {
  count  = var.client == "galago" && var.env == "dev" ? 1 : 0
  source = "./custom_resources/galago_dev_euw1"
  providers = {
    aws.vector_eks_euw1 = aws.vector_eks_euw1
  }

  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
  sg_control_plane_01           = module.eks_stack.sg_control_plane_01_id
  msk_cluster_arn               = module.eks_stack.msk_cluster_arn
}

###############################
# swift-dev-euw1
###############################
module "swift_dev_euw1_custom" {
  count  = var.client == "swift" && var.env == "dev" ? 1 : 0
  source = "./custom_resources/swift_dev_euw1"
  providers = {
    aws.vector_eks_euw1 = aws.vector_eks_euw1
  }
  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
  sg_control_plane_01           = module.eks_stack.sg_control_plane_01_id
  msk_cluster_arn               = module.eks_stack.msk_cluster_arn
}

###############################
# sys-dev-euw1
###############################
module "sys_dev_euw1_custom" {
  count  = var.client == "sys" && var.env == "dev" ? 1 : 0
  source = "./custom_resources/sys_dev_euw1"
  providers = {
    aws.vector_eks_euw1 = aws.vector_eks_euw1
  }
  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
  sg_control_plane_01           = module.eks_stack.sg_control_plane_01_id
  msk_cluster_arn               = module.eks_stack.msk_cluster_arn
}

###############################
# teamrec-dev-euw1
###############################
module "teamrec_dev_euw1_custom" {
  count  = var.client == "teamrec" && var.env == "dev" ? 1 : 0
  source = "./custom_resources/teamrec_dev_euw1"

  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
}

###############################
# qa-fb-euw1
###############################
module "qa_fb_euw1_custom" {
  count  = var.client == "qa" && var.env == "fb" ? 1 : 0
  source = "./custom_resources/qa_fb_euw1"
  # EKS stack variables
  eks_private_route_table_01_id = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id = module.eks_stack.private_route_table_03_id
  eks_transit_gateway_id        = module.eks_stack.transit_gateway_id
}