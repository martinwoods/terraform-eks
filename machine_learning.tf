#########################################################
# reference to the eks-stack module
#########################################################
module "machine_learning_stack" {
  count = var.isMLNodeEnabled == "true" ? 1 : 0
  source = "./modules/machine_learning"

  #######################################################
  # providers
  #######################################################
  providers = {
    aws.vector_eks_euw1 = aws.vector_eks_euw1
    aws.itdept          = aws.itdept
  }

  #######################################################
  # VPC variables
  #######################################################
  vpc_cidr = var.vpc_cidr
  client   = var.client
  env      = var.env
  region   = var.region

  #######################################################
  # EC2 instance variables
  #######################################################
  ec2_key_name                      = var.ec2_key_name
  ec2_instance_types_worker_node_ml = var.ec2_instance_types_worker_node_ml

  #########################################################
  # EKS Configuration
  #########################################################

  # This is to set the version of EKS Control Plane and Worker Nodes
  cluster_name                      = module.eks_stack.cluster_name
  eks_version                       = var.eks_version

  # EKS stack variables
  eks_vpc_id                        = module.eks_stack.vpc_id
  eks_region_id                     = module.eks_stack.region_id
  eks_private_subnet_ids            = module.eks_stack.private_subnet_ids
  eks_private_route_table_01_id     = module.eks_stack.private_route_table_01_id
  eks_private_route_table_02_id     = module.eks_stack.private_route_table_02_id
  eks_private_route_table_03_id     = module.eks_stack.private_route_table_03_id
  sg_worker_nodes                   = module.eks_stack.sg_worker_nodes_01_id

  aws_iam_role_eks_node_group_role_arn = module.eks_stack.aws_iam_role_eks_node_group_role_arn

  #######################################################
  # EC2 Auto Scaling Group variables
  #######################################################
  asg_min_size_ml                   = var.asg_min_size_ml
  asg_desired_size_ml               = var.asg_desired_size_ml
  asg_max_size_ml                   = var.asg_max_size_ml

  asg_cron_ml_nodes_start_evening   = var.asg_cron_ml_nodes_start_evening
  asg_cron_ml_nodes_stop_evening    = var.asg_cron_ml_nodes_stop_evening

  asg_cron_ml_nodes_start_night     = var.asg_cron_ml_nodes_start_night
  asg_cron_ml_nodes_stop_night      = var.asg_cron_ml_nodes_stop_night
}