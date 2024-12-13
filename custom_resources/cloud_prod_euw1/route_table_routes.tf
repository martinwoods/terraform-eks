#########################################################
# VPC Peering Connection Routes - veu-fra
#########################################################

resource "aws_route" "private_01_to_veu_fra_cidr" {
  route_table_id            = var.eks_private_route_table_01_id
  destination_cidr_block    = data.aws_vpc.veu_fra.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_fra.id
}

resource "aws_route" "private_02_to_veu_fra_cidr" {
  route_table_id            = var.eks_private_route_table_02_id
  destination_cidr_block    = data.aws_vpc.veu_fra.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_fra.id
}

resource "aws_route" "private_03_to_veu_fra_cidr" {
  route_table_id            = var.eks_private_route_table_03_id
  destination_cidr_block    = data.aws_vpc.veu_fra.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_fra.id
}

#########################################################
# Vector 2 - route from veu-fra VPC
#########################################################

resource "aws_route" "veu_fra_private_to_eks_vpc" {
  destination_cidr_block    = data.aws_vpc.eks_vpc.cidr_block
  provider                  = aws.vector2_euc1
  route_table_id            = data.aws_route_table.veu_fra_private.id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_fra.id
}


#########################################################
# VPC Peering Connection Routes - veu-mte
#########################################################

resource "aws_route" "private_01_to_veu_mte_cidr" {
  route_table_id            = var.eks_private_route_table_01_id
  destination_cidr_block    = data.aws_vpc.veu_mte.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_mte.id
}

resource "aws_route" "private_02_to_veu_mte_cidr" {
  route_table_id            = var.eks_private_route_table_02_id
  destination_cidr_block    = data.aws_vpc.veu_mte.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_mte.id
}

resource "aws_route" "private_03_to_veu_mte_cidr" {
  route_table_id            = var.eks_private_route_table_03_id
  destination_cidr_block    = data.aws_vpc.veu_mte.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_mte.id
}

#########################################################
# Vector 2 - route from veu-mte VPC
#########################################################

resource "aws_route" "veu_mte_private_to_eks_vpc" {
  destination_cidr_block    = data.aws_vpc.eks_vpc.cidr_block
  provider                  = aws.vector2_euw1
  route_table_id            = data.aws_route_table.veu_mte_private.id
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_mte.id
}
