#########################################################
# Data Resource details
#########################################################
data "aws_caller_identity" "vector_2_euw1" {
  provider = aws.vector2_euw1
}

data "aws_vpc" "veu_uat" {
  provider   = aws.vector2_euw1
  cidr_block = local.veu_uat_cidr
}

# veu-uat private route table
# hosted within the Vector 2 AWS Account - eu-west-1 region
# required to create routes from veu-uat VPC to cluster VPC
data "aws_route_table" "veu_uat_private" {
  provider = aws.vector2_euw1
  tags = {
    Name = "veu-uat-pri-rtb"
  }
}

# veu-uat-sql-05 Security Group
# hosted within the Vector 2 AWS Account - eu-west-1 region
# required to grant cluster access to Vector databases
data "aws_security_group" "sg_veu_uat_sql_05" {
  name     = "veu-uat-sql-05"
  provider = aws.vector2_euw1
}

# EKS VPC Id
# used to get the VPC details, mainly the CIDR 
data "aws_vpc" "eks_vpc" {
  id = var.eks_vpc_id
}