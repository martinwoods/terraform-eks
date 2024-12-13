#########################################################
# EKS Cluster outputs
#########################################################
output "Cluster_Endpoint" {
  value = module.eks_stack.cluster_endpoint
}

output "Cluster_NodeGroup_InstanceRole" {
  value = module.eks_stack.eks_node_group_role
}


#########################################################
# IAM outputs
#########################################################
output "Storage_Access_Key" {
  value = module.eks_stack.iam_storage_key
}

output "Storage_Secret_Key" {
  value     = module.eks_stack.iam_storage_secret
  sensitive = true
}

output "Backup_Access_Key" {
  value = module.eks_stack.iam_backup_key
}

output "Backup_Secret_Key" {
  value     = module.eks_stack.iam_backup_secret
  sensitive = true
}

output "Sqs_Access_Key" {
  value = module.eks_stack.iam_sqs_key
}

output "Sqs_Secret_Key" {
  value     = module.eks_stack.iam_sqs_secret
  sensitive = true
}


#########################################################
# S3 Bucket outputs
#########################################################
output "Storage_Private_Bucket" {
  value = module.eks_stack.storage_private_bucket
}

output "Storage_Public_Bucket" {
  value = module.eks_stack.storage_public_bucket
}

output "MongoDB_Backup_Bucket" {
  value = module.eks_stack.mongodb_backup_bucket
}

output "Elasticsearch_Backup_Bucket" {
  value = module.eks_stack.elasticsearch_backup_bucket
}


#########################################################
# AWS MSK (Managed Streaming for Kafka) cluster outputs
#########################################################
output "MSK_Zookeeper_Connect_String" {
  value = module.eks_stack.zookeeper_connect_string
}

output "MSK_Bootstrap_Brokers_TLS" {
  value = module.eks_stack.bootstrap_brokers_tls
}

output "MSK_Bootstrap_Brokers_SCRAM" {
  value = module.eks_stack.bootstrap_brokers_scram
}

output "MSK_ARN" {
  value = module.eks_stack.msk_cluster_arn
}

#########################################################
# AWS Secrets Manager outputs
#########################################################

output "Secrets_Manager_Access_Key" {
  value = module.eks_stack.iam_secrets_manager_key
}

output "Secrets_Manager_Secret_Key" {
  value     = module.eks_stack.iam_secrets_manager_secret
  sensitive = true
}
