##################################################################################################################
# VEU-UAT VPC Peering Connection details
##################################################################################################################

#########################################################
# VPC Peering Connection details
#########################################################

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "vpc_peer_veu_uat" {
  vpc_id        = var.eks_vpc_id
  peer_vpc_id   = data.aws_vpc.veu_uat.id
  peer_owner_id = data.aws_caller_identity.vector_2_euw1.account_id
  peer_region   = "eu-west-1"
  auto_accept   = false

  tags = {
    Name = "${var.client}-${var.env}-${var.eks_region_id}<-->veu-uat"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "veu_uat" {
  provider                  = aws.vector2_euw1
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peer_veu_uat.id
  auto_accept               = true

  tags = {
    Name = "veu-uat<-->${var.client}-${var.env}-${var.eks_region_id}"
  }
}