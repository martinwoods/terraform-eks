#########################################################
# EIP details
#########################################################

# EIPs for each NAT gateway
# one NAT Gateway in each public subnet in each AZ
resource "aws_eip" "ngw_eip_01" {
  domain = "vpc"

  tags = {
    Name = "${local.cluster_name}-ngw-eip-01"
  }
}

resource "aws_eip" "ngw_eip_02" {
  domain = "vpc"

  tags = {
    Name = "${local.cluster_name}-ngw-eip-02"
  }
}

resource "aws_eip" "ngw_eip_03" {
  domain = "vpc"

  tags = {
    Name = "${local.cluster_name}-ngw-eip-03"
  }
}

