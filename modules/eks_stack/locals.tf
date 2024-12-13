#########################################################
# variables of Retail inMotion IP addresses
#########################################################

locals {
  ix_primary_wan         = "149.14.148.72/29"
  ix_primary_wan_2       = "63.33.143.170/32" ## added in accordance with TGW changes: DEVOPSREQ-1467
  h57_dev_vlan_95        = "192.168.95.0/24"
  h57_it_ops_vlan_150    = "192.168.150.0/24"
  h57_corp_wifi_vlan_170 = "192.168.170.0/24"
  ix_servers_vlan_210    = "192.168.210.0/24"
  ix_aws_direct_connect  = "69.210.67.73/32"

  # Nagios IX
  rimdub_mon_06          = "192.168.210.8/32"
  ix_dev_vpn_vlan_240    = "192.168.240.0/24"
  ix_it_ops_vpn_vlan_243 = "192.168.243.0/24"
  ix_dev_vm_vlan_245     = "192.168.245.0/24"
  ix_qa_vlan_246         = "192.168.246.0/24"

  # Vector EKS rim-bst-euw1
  rim_bst_euw1_cidr = "10.100.0.0/16"
}

locals {
  aws_workspace_proxy_01 = "13.200.70.134/32"
  aws_workspace_proxy_02 = "3.109.82.115/32"
}

#########################################################
# VPC locals
#########################################################

locals {
  # Declare the local source for current AWS region ID - e.g. euw1; usw2
  region_id = split("-", data.aws_availability_zones.available.zone_ids[0])[0]
  # Declare a local variable for the cluster name which is used for naming resources
  cluster_name = "${var.client}-${var.env}-${local.region_id}"
}

# needed to use a map for VPC tags as using variables in tag name
# see https://blog.scottlowe.org/2018/06/11/using-variables-in-aws-tags-with-terraform/
locals {
  vpc_tags = {
    "Name"                                        = "${local.cluster_name} ${var.vpc_cidr}"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

#########################################################
# Subnet locals
#########################################################

# needed to use a map for VPC tags as using variables in tag name
# see https://blog.scottlowe.org/2018/06/11/using-variables-in-aws-tags-with-terraform/

# see the following about subnet tagging for EKS
# https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
locals {
  subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

#########################################################
# EC2 Launch Template details
#########################################################

locals {

  eks-spot-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${local.cluster_name} \
--kubelet-extra-args \
  '--node-labels=lifecycle=ec2spot,node.kubernetes.io/spot-worker \
   --kube-reserved cpu=150m,memory=0.4Gi,ephemeral-storage=1Gi \
   --system-reserved cpu=100m,memory=0.4Gi,ephemeral-storage=1Gi \
   --eviction-hard memory.available<800Mi,nodefs.available<10%'
USERDATA

}

locals {

  eks-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${local.cluster_name} \
--kubelet-extra-args \
  '--node-labels=lifecycle=on-demand,node.kubernetes.io/worker \
   --kube-reserved cpu=150m,memory=0.4Gi,ephemeral-storage=1Gi \
   --system-reserved cpu=100m,memory=0.4Gi,ephemeral-storage=1Gi \
   --eviction-hard memory.available<800Mi,nodefs.available<10% \
   --register-with-taints=on-demand=true:PreferNoSchedule'
USERDATA

}