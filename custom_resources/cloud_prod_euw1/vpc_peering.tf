##################################################################################################################
# VEU-UAT VPC Peering Connection details
##################################################################################################################

#########################################################
# VPC Peering Connection details - veu-fra
#########################################################

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "vpc_peer_veu_fra" {
  vpc_id        = var.eks_vpc_id
  peer_vpc_id   = data.aws_vpc.veu_fra.id
  peer_owner_id = data.aws_caller_identity.vector_2_euc1.account_id
  peer_region   = "eu-central-1"
  auto_accept   = false

  tags = {
    Name = "${var.client}-${var.env}-${var.eks_region_id}<-->veu-fra"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "veu_fra" {
  provider                  = aws.vector2_euc1
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_fra.id
  auto_accept               = true

  tags = {
    Name = "veu-fra<-->${var.client}-${var.env}-${var.eks_region_id}"
  }
}


#########################################################
# VPC Peering Connection details - veu-mte
#########################################################

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "vpc_peer_veu_mte" {
  vpc_id        = var.eks_vpc_id
  peer_vpc_id   = data.aws_vpc.veu_mte.id
  peer_owner_id = data.aws_caller_identity.vector_2_euw1.account_id
  peer_region   = "eu-west-1"
  auto_accept   = false

  tags = {
    Name = "${var.client}-${var.env}-${var.eks_region_id}<-->veu-mte"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "veu_mte" {
  provider                  = aws.vector2_euw1
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_mte.id
  auto_accept               = true

  tags = {
    Name = "veu-mte<-->${var.client}-${var.env}-${var.eks_region_id}"
  }
}