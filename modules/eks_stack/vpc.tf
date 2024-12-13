#########################################################
# VPC details
#########################################################
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  # see the following about VPC tagging for EKS
  # https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
  tags = local.vpc_tags
}

#########################################################
# Internet Gateway details
#########################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-igw"
  }
}

