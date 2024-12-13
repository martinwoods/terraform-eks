#########################################################
# Availability Zones Data Resource
#########################################################

# Declare the data source for AWS AZs in the current region
data "aws_availability_zones" "available" {
}

#########################################################
# AWS Route 53 Data Resources from "Vector EKS" account
#########################################################

data "aws_route53_zone" "vector_cloud_com" {
  name     = "vector-cloud.com"
  provider = aws.vector_eks_euw1
}

data "aws_msk_broker_nodes" "msk_broker" {
  cluster_arn = var.msk_cluster_arn

}