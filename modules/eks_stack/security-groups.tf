#########################################################
# Control Plane security group
#########################################################
resource "aws_security_group" "sg_control_plane_01" {
  name        = "${local.cluster_name}-control-plane-01"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-control-plane-01"
  }
}

#########################################################
# Control Plane security group rules
#########################################################

# Allow pods to communicate with the cluster API Server
resource "aws_security_group_rule" "sg_control_plane_01_ing_01" {
  type                     = "ingress"
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_worker_nodes_01.id
  security_group_id        = aws_security_group.sg_control_plane_01.id
}

# Allow pods to communicate with MSK Kafka cluster (Zookeeper)
resource "aws_security_group_rule" "sg_control_plane_01_ing_02" {
  count                    = var.msk_enabled ? 1 : 0
  type                     = "ingress"
  description              = "Allow pods to communicate with MSK Zookeeper"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_worker_nodes_01.id
  security_group_id        = aws_security_group.sg_control_plane_01.id
}

# Allow pods to communicate with MSK Kafka cluster (Broker)
resource "aws_security_group_rule" "sg_control_plane_01_ing_03" {
  count                    = var.msk_enabled ? 1 : 0
  type                     = "ingress"
  description              = "Allow pods to communicate with MSK Broker"
  from_port                = 9094
  to_port                  = 9094
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_worker_nodes_01.id
  security_group_id        = aws_security_group.sg_control_plane_01.id
}

# Allow pods to communicate with MSK Kafka cluster (Broker - SASL/SCRAM)
resource "aws_security_group_rule" "sg_control_plane_01_ing_04" {
  count                    = var.msk_scram_enabled && var.msk_enabled ? 1 : 0
  type                     = "ingress"
  description              = "Allow pods to communicate with MSK Broker - SASL/SCRAM"
  from_port                = 9096
  to_port                  = 9096
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_worker_nodes_01.id
  security_group_id        = aws_security_group.sg_control_plane_01.id
}

# Allow the cluster control plane to communicate with worker Kubelet and pods
resource "aws_security_group_rule" "sg_control_plane_01_eg_01" {
  type                     = "egress"
  description              = "Allow the cluster control plane to communicate with worker Kubelet and pods"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_worker_nodes_01.id
  security_group_id        = aws_security_group.sg_control_plane_01.id
}

# Allow the cluster control plane to communicate with pods running extension API servers on port 443
resource "aws_security_group_rule" "sg_control_plane_01_eg_02" {
  type                     = "egress"
  description              = "Allow the cluster control plane to communicate with pods running extension API servers on port 443"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_worker_nodes_01.id
  security_group_id        = aws_security_group.sg_control_plane_01.id
}



#########################################################
# Worker Nodes security group
#########################################################
resource "aws_security_group" "sg_worker_nodes_01" {
  name        = "${local.cluster_name}-worker-nodes-01"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${local.cluster_name}-worker-nodes-01"
  }
}

#########################################################
# Worker Nodes security group rules
#########################################################

# Allow node to communicate with each other
resource "aws_security_group_rule" "sg_worker_nodes_01_ing_01" {
  type              = "ingress"
  description       = "Allow node to communicate with each other"
  from_port         = -1
  to_port           = 65535
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.sg_worker_nodes_01.id
}

# Allow worker Kubelets and pods to receive communication from the cluster control plane
resource "aws_security_group_rule" "sg_worker_nodes_01_ing_02" {
  type                     = "ingress"
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_control_plane_01.id
  security_group_id        = aws_security_group.sg_worker_nodes_01.id
}

# Allow pods running extension API servers on port 443 to receive communication from cluster control plane
resource "aws_security_group_rule" "sg_worker_nodes_01_ing_03" {
  type                     = "ingress"
  description              = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_control_plane_01.id
  security_group_id        = aws_security_group.sg_worker_nodes_01.id
}

# any outbound

# TFSec: Agreed to ignore open egress warning due to maintenance complexity

#tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "sg_worker_nodes_01_eg_01" {
  type              = "egress"
  description       = "Any - Any"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_worker_nodes_01.id
}

##################################################################################################################
# VPC Peering Connection Security Group Rule details
##################################################################################################################
# this is the Security Group Rules for the peering request to the rim-bst-euw1 VPC
# this is the central management and logging VPC
#########################################################
# Security Group Rules
#########################################################

# Allow eks cluster CIDR to 5000 (Docker Repo)
resource "aws_security_group_rule" "rim_bst_euw1_sg_alb_01_eks_ing_01" {
  provider          = aws.vector_eks_euw1
  type              = "ingress"
  description       = "${local.cluster_name} to Docker Repo (Port 5000)"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
  security_group_id = data.aws_security_group.rim_bst_euw1_alb_01_eks.id
}

# Allow eks cluster CIDR to 5100 (Docker Repo)
resource "aws_security_group_rule" "rim_bst_euw1_sg_alb_01_eks_ing_02" {
  provider          = aws.vector_eks_euw1
  type              = "ingress"
  description       = "${local.cluster_name} to Docker Repo (Port 5100)"
  from_port         = 5100
  to_port           = 5100
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
  security_group_id = data.aws_security_group.rim_bst_euw1_alb_01_eks.id
}

# Allow eks CIDR to 12201 (Graylog Gelf UDP input)
resource "aws_security_group_rule" "rim_bst_euw1_sg_log_01_ing_01" {
  provider          = aws.vector_eks_euw1
  type              = "ingress"
  description       = "${local.cluster_name} to Graylog Gelf UDP Input"
  from_port         = 12201
  to_port           = 12201
  protocol          = "udp"
  cidr_blocks       = [aws_vpc.vpc.cidr_block]
  security_group_id = data.aws_security_group.rim_bst_euw1_log_01.id
}