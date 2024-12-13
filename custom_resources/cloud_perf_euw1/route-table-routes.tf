#########################################################
# Custom Routes
#########################################################
resource "aws_route" "private_01_to_rimperf_sql_01" {
  route_table_id         = var.eks_private_route_table_01_id
  destination_cidr_block = local.rimperf_sql_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_02_to_rimperf_sql_01" {
  route_table_id         = var.eks_private_route_table_02_id
  destination_cidr_block = local.rimperf_sql_01
  transit_gateway_id     = var.eks_transit_gateway_id
}

resource "aws_route" "private_03_to_rimperf_sql_01" {
  route_table_id         = var.eks_private_route_table_03_id
  destination_cidr_block = local.rimperf_sql_01
  transit_gateway_id     = var.eks_transit_gateway_id
}