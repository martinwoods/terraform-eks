#########################################################
# Subnet details
#########################################################

# private subnets for nodes
resource "aws_subnet" "subnet_private_01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 3, 0)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    local.subnet_tags,
    {
      "Name"                            = "${local.cluster_name}-private-01 subnet"
      "kubernetes.io/role/internal-elb" = 1
    },
  )
}

resource "aws_subnet" "subnet_private_02" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 3, 1)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    local.subnet_tags,
    {
      "Name"                            = "${local.cluster_name}-private-02 subnet"
      "kubernetes.io/role/internal-elb" = 1
    },
  )
}

resource "aws_subnet" "subnet_private_03" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 3, 2)
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = merge(
    local.subnet_tags,
    {
      "Name"                            = "${local.cluster_name}-private-03 subnet"
      "kubernetes.io/role/internal-elb" = 1
    },
  )
}

# public subnets for ELBs
resource "aws_subnet" "subnet_public_01" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 8)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    local.subnet_tags,
    {
      "Name"                   = "${local.cluster_name}-public-01 subnet"
      "kubernetes.io/role/elb" = 1
    },
  )
}

resource "aws_subnet" "subnet_public_02" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 9)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    local.subnet_tags,
    {
      "Name"                   = "${local.cluster_name}-public-02 subnet"
      "kubernetes.io/role/elb" = 1
    },
  )
}

resource "aws_subnet" "subnet_public_03" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 4, 10)
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = merge(
    local.subnet_tags,
    {
      "Name"                   = "${local.cluster_name}-public-03 subnet"
      "kubernetes.io/role/elb" = 1
    },
  )
}

