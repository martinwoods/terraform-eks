#########################################################
# VPC Peering Connection Routes - veu-uat
#########################################################

resource "aws_route" "private_01_vpc_peer_cidr" {
  route_table_id            = var.eks_private_route_table_01_id
  destination_cidr_block    = data.aws_vpc.veu_uat.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_uat.id
}

resource "aws_route" "private_02_vpc_peer_cidr" {
  route_table_id            = var.eks_private_route_table_02_id
  destination_cidr_block    = data.aws_vpc.veu_uat.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_uat.id
}

resource "aws_route" "private_03_vpc_peer_cidr" {
  route_table_id            = var.eks_private_route_table_03_id
  destination_cidr_block    = data.aws_vpc.veu_uat.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_uat.id
}

#########################################################
# Vector 2 - route from veu-uat VPC
#########################################################

resource "aws_route" "veu_uat_private_to_eks_vpc" {
  destination_cidr_block    = data.aws_vpc.eks_vpc.cidr_block
  provider                  = aws.vector2_euw1
  route_table_id            = data.aws_route_table.veu_uat_private.id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_uat.id
}