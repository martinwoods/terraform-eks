#########################################################
# VPC Peering Acceptor Connection details
# Data resources required for VPC Peering with rim-bst-euw1
###########################################################
data "aws_vpc" "rim_bst_euw1" {
  provider   = aws.vector_eks_euw1
  cidr_block = local.rim_bst_euw1_cidr
}

# public subnet
data "aws_route_table" "rim_bst_euw1_public" {
  provider = aws.vector_eks_euw1
  vpc_id   = data.aws_vpc.rim_bst_euw1.id
  filter {
    name   = "tag:Name"
    values = ["rim-bst-euw1-public-rtb"]
  }
}

# private route to subnets
data "aws_route_table" "rim_bst_euw1_private_01" {
  provider = aws.vector_eks_euw1
  vpc_id   = data.aws_vpc.rim_bst_euw1.id

  filter {
    name   = "tag:Name"
    values = ["rim-bst-euw1-private-rtb-01"]
  }
}

data "aws_route_table" "rim_bst_euw1_private_02" {
  provider = aws.vector_eks_euw1
  vpc_id   = data.aws_vpc.rim_bst_euw1.id

  filter {
    name   = "tag:Name"
    values = ["rim-bst-euw1-private-rtb-02"]
  }
}

data "aws_route_table" "rim_bst_euw1_private_03" {
  provider = aws.vector_eks_euw1
  vpc_id   = data.aws_vpc.rim_bst_euw1.id

  filter {
    name   = "tag:Name"
    values = ["rim-bst-euw1-private-rtb-03"]
  }
}

# graylog security group
data "aws_security_group" "rim_bst_euw1_log_01" {
  name     = "rim-bst-euw1-log-01"
  provider = aws.vector_eks_euw1
  vpc_id   = data.aws_vpc.rim_bst_euw1.id
}

# alb security group
data "aws_security_group" "rim_bst_euw1_alb_01_eks" {
  name     = "rim-bst-euw1-alb-01-eks"
  provider = aws.vector_eks_euw1
  vpc_id   = data.aws_vpc.rim_bst_euw1.id
}


# Get the aws caller identity so that we can use the Account ID in SNS
data "aws_caller_identity" "current" {}

#########################################################
# Availability Zones Data Resource
#########################################################

# Declare the data source for AWS AZs in the current region
data "aws_availability_zones" "available" {
}

#########################################################
# EC2 AMI Data Resource
#########################################################

# see https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html

data "aws_ami" "eks_node" {
  most_recent = true
  name_regex  = "^amazon-eks-node-${var.eks_version}-v\\d{8}"

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

#########################################################
# Transit Gateway Data Resource in IT Dept AWS Account
#########################################################

# "Data" transit gateway
data "aws_ec2_transit_gateway" "tgw_mgt" {
  filter {
    name   = "tag:Name"
    values = ["tgw_mgt"]
  }
}

data "aws_ec2_transit_gateway_route_table" "rtb_mgt" {
  count    = var.region != "us-east-1" && var.region != "us-west-2" ? 1 : 0
  provider = aws.itdept
  filter {
    name   = "tag:Name"
    values = ["RIM-MGT-RTB"]
  }
}

data "aws_ec2_transit_gateway_route_table" "hub_mgt" {
  count    = var.region == "us-east-1" || var.region == "us-west-2" ? 1 : 0
  provider = aws.itdept
  filter {
    name   = "tag:Name"
    values = ["Hub"]
  }
}

data "aws_ec2_transit_gateway_route_table" "spoke_mgt" {
  count    = var.region == "us-east-1" || var.region == "us-west-2" ? 1 : 0
  provider = aws.itdept
  filter {
    name   = "tag:Name"
    values = ["Spoke"]
  }
}

#########################################################
# EKS OIDC Issuer data source to use at 
# aws_iam_openid_connect_provider resource creation
#########################################################

data "tls_certificate" "eks_tls_certificate" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

#############################################################################
# msk cluster configurtion data source
# used by the aws_msk_cluster resource within the configurtion_info attribute
#############################################################################
data "aws_msk_configuration" "msk_configuration" {
  count = var.msk_enabled ? 1 : 0
  name  = local.cluster_name

  depends_on = [aws_msk_configuration.msk_configuration]
}

##################################################################################################
# Retrieve information about a specific EKS add-on version compatible with an EKS cluster version.
##################################################################################################
data "aws_eks_addon_version" "addon_versions" {
  for_each           = { for addon in var.addons : addon.name => addon }
  addon_name         = each.key
  kubernetes_version = aws_eks_cluster.eks.version
  most_recent        = true
}

# IAM Role to grant Cloudwatch Logs permission to put records to Kinesis Firehose
# this IAM role is created and managed within the "RIM-DEV - VEU-BST" terraform code
# this IAM role is regional
data "aws_iam_role" "cloudwatch_logs_kinesis_firehose" {
  name = "cloudwatch_logs_kinesis_firehose-${local.region_id}"
}

# Kinesis Firehose used to forward Cloudwatch Logs to New Relic
# this Kinesis Firehose is created and managed within the "RIM-DEV - VEU-BST" terraform code
# this Kinesis Firehose is regional
data "aws_kinesis_firehose_delivery_stream" "newrelic_logs" {
  name = "newrelic-logs"
}