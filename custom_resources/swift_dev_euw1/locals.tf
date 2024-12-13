# #########################################################
# # variables of IP addresses / CIDRs
# #########################################################

locals {
  rimdev_vecm_01 = "192.168.248.22/32"
  # RiM Corp vLANs
  ch_dev_vlan_202        = "192.168.202.0/24"
  ix_dev_vpn_vlan_240    = "192.168.240.0/24"
  ix_it_ops_vpn_vlan_243 = "192.168.243.0/24"
  ch_it_ops_vlan_250     = "192.168.250.0/24"
}

locals {
  broker_endpoints = toset(flatten(data.aws_msk_broker_nodes.msk_broker.node_info_list[*].endpoints))
}

