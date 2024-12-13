#########################################################
# Security Group Rules details
#########################################################

#########################################################
# sg_veu_fra_sql security group rules
#########################################################

resource "aws_security_group_rule" "sg_veu_fra_sql_ing_01" {
  cidr_blocks       = [data.aws_vpc.eks_vpc.cidr_block]
  description       = "MSSQL access from ${var.client}-${var.env}-${var.eks_region_id}"
  from_port         = 1433
  protocol          = "tcp"
  provider          = aws.vector2_euc1
  security_group_id = data.aws_security_group.sg_veu_fra_sql.id
  to_port           = 1433
  type              = "ingress"
}

#########################################################
# sg_veu_mte_sql_03 security group rules
#########################################################

resource "aws_security_group_rule" "sg_veu_mte_sql_03_ing_01" {
  cidr_blocks       = [data.aws_vpc.eks_vpc.cidr_block]
  description       = "MSSQL access from ${var.client}-${var.env}-${var.eks_region_id}"
  from_port         = 1433
  protocol          = "tcp"
  provider          = aws.vector2_euw1
  security_group_id = data.aws_security_group.sg_veu_mte_sql_03.id
  to_port           = 1433
  type              = "ingress"
}