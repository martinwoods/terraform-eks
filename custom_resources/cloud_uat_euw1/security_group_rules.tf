#########################################################
# Security Group Rules details
#########################################################

#########################################################
# sg_veu_uat_sql_05 security group rules
#########################################################

resource "aws_security_group_rule" "sg_veu_fra_sql_05_ing_01" {
  cidr_blocks       = [data.aws_vpc.eks_vpc.cidr_block]
  description       = "MSSQL access from ${var.client}-${var.env}-${var.eks_region_id}"
  from_port         = 1433
  protocol          = "tcp"
  provider          = aws.vector2_euw1
  security_group_id = data.aws_security_group.sg_veu_uat_sql_05.id
  to_port           = 1433
  type              = "ingress"
}