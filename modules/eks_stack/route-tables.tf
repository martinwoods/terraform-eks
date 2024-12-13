#########################################################
# Route Table details
#########################################################

# public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-public-rtb"
  }
}

# private route table
resource "aws_route_table" "private_route_table_01" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-private-rtb-01"
  }
}

resource "aws_route_table" "private_route_table_02" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-private-rtb-02"
  }
}

resource "aws_route_table" "private_route_table_03" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-private-rtb-03"
  }
}

