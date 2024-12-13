#########################################################
# Data Resource details
#########################################################
data "aws_caller_identity" "vector_2_euc1" {
  provider = aws.vector2_euc1
}

data "aws_caller_identity" "vector_2_euw1" {
  provider = aws.vector2_euw1
}

data "aws_vpc" "veu_fra" {
  provider   = aws.vector2_euc1
  cidr_block = local.veu_fra_cidr
}

data "aws_vpc" "veu_mte" {
  provider   = aws.vector2_euw1
  cidr_block = local.veu_mte_cidr
}

# veu-fra private route table
# hosted within the Vector 2 AWS Account - eu-central-1 region
# required to create routes from veu-fra VPC to cluster VPC
data "aws_route_table" "veu_fra_private" {
  provider = aws.vector2_euc1
  tags = {
    Name = "veu-fra-pri-rtb"
  }
}

# veu-mte private route table
# hosted within the Vector 2 AWS Account - eu-west-1 region
# required to create routes from veu-mte VPC to cluster VPC
data "aws_route_table" "veu_mte_private" {
  provider = aws.vector2_euw1
  tags = {
    Name = "veu-mte-pri-rtb"
  }
}

# veu-fra-sql Security Group
# hosted within the Vector 2 AWS Account - eu-central-1 region
# required to grant cluster access to Vector databases
data "aws_security_group" "sg_veu_fra_sql" {
  name     = "veu-fra-sql"
  provider = aws.vector2_euc1
}

# veu-mte-sql-03 Security Group
# hosted within the Vector 2 AWS Account - eu-west-1 region
# required to grant cluster access to Vector databases
data "aws_security_group" "sg_veu_mte_sql_03" {
  name     = "veu-mte-sql-03"
  provider = aws.vector2_euw1
}

# EKS VPC Id
# used to get the VPC details, mainly the CIDR 
data "aws_vpc" "eks_vpc" {
  id = var.eks_vpc_id
}