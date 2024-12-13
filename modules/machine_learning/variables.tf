#########################################################
# VPC Configuration
#########################################################

# Client / ICAO Code / System 
# e.g. edw; nks; rim; mcabin; common (for a shared system)
# use lowercase
variable "client" {}

# Environment
# e.g prod; uat; test; dev; bst (bastian);
variable "env" {}

# The IP address range used for the VPC CIDR
# must be a valid IP CIDR range of the form x.x.x.x/x
variable "vpc_cidr" {}

# Region eg eu-west-1, us-east-2, etc
variable "region" {}

#########################################################
# EC2 Configuration
#########################################################

# KeyPair to use with EC2 instances when launched
# N.B. keypair MUST be exist in the region BEFORE deployment
# private key should be saved with IT Ops Team
variable "ec2_key_name" {}

variable "cluster_name" {
}

variable "eks_version" {
}

variable "asg_desired_size_ml" {
}

variable "asg_min_size_ml" {
}

variable "asg_max_size_ml" {
}

variable "asg_cron_ml_nodes_start_evening" {
}

variable "asg_cron_ml_nodes_stop_evening" {
}

variable "asg_cron_ml_nodes_start_night" {
}

variable "asg_cron_ml_nodes_stop_night" {
}

variable "ec2_instance_types_worker_node_ml" {
}

# eks_stack module variables
variable "eks_vpc_id" {
}

variable "eks_region_id" {
}

variable "eks_private_subnet_ids" {
}

variable "eks_private_route_table_01_id" {
}

variable "eks_private_route_table_02_id" {
}

variable "eks_private_route_table_03_id" {
}

variable "sg_worker_nodes" {
}

variable "aws_iam_role_eks_node_group_role_arn" {
}

