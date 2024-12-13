#########################################################
# Custom Routes
#########################################################
resource "aws_route" "private_01_to_rimtest_sql_05" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.rimtest_sql_05
  transit_gateway_id     = var.eks_transit_gateway_id
}
resource "aws_route" "private_02_to_rimtest_sql_05" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.rimtest_sql_05
  transit_gateway_id     = var.eks_transit_gateway_id
}
resource "aws_route" "private_03_to_rimtest_sql_05" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.rimtest_sql_05
  transit_gateway_id     = var.eks_transit_gateway_id
}
resource "aws_route" "private_01_to_rimtest_sql_09" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.rimtest_sql_09
  transit_gateway_id     = var.eks_transit_gateway_id
}
resource "aws_route" "private_02_to_rimtest_sql_09" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.rimtest_sql_09
  transit_gateway_id     = var.eks_transit_gateway_id
}
resource "aws_route" "private_03_to_rimtest_sql_09" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.rimtest_sql_09
  transit_gateway_id     = var.eks_transit_gateway_id
}
