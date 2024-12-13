#########################################################
# VPC outputs
#########################################################
output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of VPC."
}

output "region_id" {
  value       = local.region_id
  description = "The Region ID of the VPC."
}

output "private_subnet_ids" {
  value = join(",", [
    aws_subnet.subnet_private_01.id,
    aws_subnet.subnet_private_02.id,
    aws_subnet.subnet_private_03.id
    ]
  )
  description = "List of subnet IDs in the VPC."
}

output "transit_gateway_id" {
  value       = data.aws_ec2_transit_gateway.tgw_mgt.id
  description = "Transit Gateway in IT Dept AWS Account"
}

#########################################################
# Route Table outputs
#########################################################
output "public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "The ID of Public Route Table."
}

output "private_route_table_01_id" {
  value       = aws_route_table.private_route_table_01.id
  description = "The ID of Private Route Table 01."
}

output "private_route_table_02_id" {
  value       = aws_route_table.private_route_table_02.id
  description = "The ID of Private Route Table 02."
}

output "private_route_table_03_id" {
  value       = aws_route_table.private_route_table_03.id
  description = "The ID of Private Route Table 03."
}

#########################################################
# Security Group outputs
#########################################################
output "sg_control_plane_01_id" {
  value       = aws_security_group.sg_control_plane_01.id
  description = "The ID of Security Group for Control Plane."
}

output "sg_worker_nodes_01_id" {
  value       = aws_security_group.sg_worker_nodes_01.id
  description = "The ID of Security Group for Worker Nodes."
}

#########################################################
# EKS Cluster outputs
#########################################################
output "cluster_name" {
  value = local.cluster_name
}
output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig_certificate_authority_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "aws_iam_role_eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

#########################################################
# S3 Bucket outputs
#########################################################
output "storage_private_bucket" {
  value = aws_s3_bucket.s3_storage_private.id
}

output "storage_public_bucket" {
  value = aws_s3_bucket.s3_storage_public.id
}

output "mongodb_backup_bucket" {
  value = aws_s3_bucket.s3_mongodb_backup.id
}

output "elasticsearch_backup_bucket" {
  value = aws_s3_bucket.s3_elasticsearch_backup.id
}

#########################################################
# IAM outputs
#########################################################

# IAM storage user Access Key
output "iam_storage_key" {
  value = aws_iam_access_key.ak_iam_storage.id
}

# IAM storage user Access Secret
output "iam_storage_secret" {
  value     = aws_iam_access_key.ak_iam_storage.secret
  sensitive = true
}

# IAM backup user Access Key
output "iam_backup_key" {
  value = aws_iam_access_key.ak_iam_backup.id
}

# IAM backup user Access Secret
output "iam_backup_secret" {
  value     = aws_iam_access_key.ak_iam_backup.secret
  sensitive = true
}

# IAM role for cluster node group instance role
output "eks_node_group_role" {
  value = aws_iam_role.eks_node_group_role.arn
}

# IAM sqs user Access Key
output "iam_sqs_key" {
  value = aws_iam_access_key.ak_iam_sqs.id
}

# IAM sqs user Access Secret
output "iam_sqs_secret" {
  value     = aws_iam_access_key.ak_iam_sqs.secret
  sensitive = true
}

# Secrets Manager IAM user Access Key
output "iam_secrets_manager_key" {
  value = aws_iam_access_key.ak_iam_secrets_manager.id
}

# Secrets Manager IAM user Access Secret
output "iam_secrets_manager_secret" {
  value     = aws_iam_access_key.ak_iam_secrets_manager.secret
  sensitive = true
}

#########################################################
# MSK (Kafka) outputs
#########################################################
output "zookeeper_connect_string" {
  value = join(" ", aws_msk_cluster.msk.*.zookeeper_connect_string)
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = join(" ", aws_msk_cluster.msk.*.bootstrap_brokers_tls)
}

output "bootstrap_brokers_scram" {
  description = "TLS connection host:port pairs using SASL/SCRAM"
  value       = join(" ", aws_msk_cluster.msk.*.bootstrap_brokers_sasl_scram)
}

output "msk_cluster_arn" {
  value = try(aws_msk_cluster.msk[0].arn, null)
}
