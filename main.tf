#########################################################
# reference to the eks-stack module
#########################################################
module "eks_stack" {
  source = "./modules/eks_stack"

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
  ec2_key_name                        = var.ec2_key_name
  ec2_instance_type_worker_node       = var.ec2_instance_type_worker_node
  ec2_instance_types_spot_node        = var.ec2_instance_types_spot_node
  ec2_default_instance_type_spot_node = var.ec2_default_instance_type_spot_node

  #######################################################
  # EC2 Auto Scaling Group variables
  #######################################################
  asg_desired_size = var.asg_desired_size
  asg_max_size     = var.asg_max_size
  asg_min_size     = var.asg_min_size

  asg_desired_size_spot = var.asg_desired_size_spot
  asg_max_size_spot     = var.asg_max_size_spot
  asg_min_size_spot     = var.asg_min_size_spot

  asg_cron_nodes_start = var.asg_cron_nodes_start
  asg_cron_nodes_stop  = var.asg_cron_nodes_stop

  #######################################################
  # EKS variables
  #######################################################
  eks_version = var.eks_version

  #########################################################
  # AWS MSK (Managed Streaming for Kafka) Config
  #########################################################
  msk_enabled         = var.msk_enabled
  msk_privateca_arn   = var.msk_privateca_arn
  msk_instance_type   = var.msk_instance_type
  msk_ebs_volume_size = var.msk_ebs_volume_size
  msk_scram_enabled   = var.msk_scram_enabled
  msk_username        = var.msk_username
  msk_password        = var.msk_password
  kafka_version       = var.kafka_version

  #########################################################
  # AWS DLM Configuration
  #########################################################
  dlm_interval        = var.dlm_interval
  dlm_times           = var.dlm_times
  dlm_retain_interval = var.dlm_retain_interval

  #########################################################
  # Misc config
  #########################################################
  storage_public_cors_allowed_origins = var.storage_public_cors_allowed_origins
  #tfsec:ignore:general-secrets-sensitive-in-attribute
  secrets_manager_region = var.secrets_manager_region
}
