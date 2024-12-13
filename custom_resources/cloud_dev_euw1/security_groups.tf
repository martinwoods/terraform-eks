# Allow Engineers VLANs & Dev Web servers to communicate with MSK Kafka cluster (Broker - SASL/SCRAM)
resource "aws_security_group_rule" "sg_control_plane_01_ing_05" {
  type              = "ingress"
  description       = "Allow Engineer VLANs & Dev Web servers to communicate with MSK Broker - SASL/SCRAM"
  from_port         = 9096
  to_port           = 9096
  protocol          = "tcp"
  cidr_blocks       = [local.ch_dev_vlan_202, local.ix_dev_vpn_vlan_240, local.ix_it_ops_vpn_vlan_243, local.ch_it_ops_vlan_250, local.rimvtr_web_01, local.rimvtr_web_02]
  security_group_id = var.sg_control_plane_01
}