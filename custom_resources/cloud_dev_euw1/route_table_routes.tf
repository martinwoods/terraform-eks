#########################################################
# Custom Routes
#########################################################

# routes to rimvtr_sql_01
resource "aws_route" "private_01_to_rimvtr_sql_01" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.rimvtr_sql_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_rimvtr_sql_01" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.rimvtr_sql_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_rimvtr_sql_01" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.rimvtr_sql_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

# routes to rimvtr_web_01
resource "aws_route" "private_01_to_rimvtr_web_01" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.rimvtr_web_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_rimvtr_web_01" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.rimvtr_web_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_rimvtr_web_01" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.rimvtr_web_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

# routes to rimvtr_web_02
resource "aws_route" "private_01_to_rimvtr_web_02" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.rimvtr_web_02
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_rimvtr_web_02" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.rimvtr_web_02
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_rimvtr_web_02" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.rimvtr_web_02
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_01_to_ch_dev_vlan_202" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.ch_dev_vlan_202
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_ch_dev_vlan_202" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.ch_dev_vlan_202
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_ch_dev_vlan_202" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.ch_dev_vlan_202
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_01_to_ix_dev_vpn_vlan_240" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.ix_dev_vpn_vlan_240
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_ix_dev_vpn_vlan_240" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.ix_dev_vpn_vlan_240
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_ix_dev_vpn_vlan_240" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.ix_dev_vpn_vlan_240
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_01_to_ix_it_ops_vpn_vlan_243" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.ix_it_ops_vpn_vlan_243
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_ix_it_ops_vpn_vlan_243" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.ix_it_ops_vpn_vlan_243
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_ix_it_ops_vpn_vlan_243" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.ix_it_ops_vpn_vlan_243
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_01_to_ch_it_ops_vlan_250" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.ch_it_ops_vlan_250
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_ch_it_ops_vlan_250" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.ch_it_ops_vlan_250
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_ch_it_ops_vlan_250" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.ch_it_ops_vlan_250
  transit_gateway_id     = var.eks_transit_gateway_id
}