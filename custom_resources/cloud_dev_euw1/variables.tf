# Variables to support passing information from other modules
# as input variables to this module

# Client / ICAO Code / System 
# e.g. edw; nks; rim; mcabin; common (for a shared system)
# use lowercase
variable "client" {}

# Environment
# e.g prod; uat; test; dev; bst (bastian);
variable "env" {}

variable "eks_private_route_table_01_id" {
}

variable "eks_private_route_table_02_id" {
}

variable "eks_private_route_table_03_id" {
}

variable "eks_transit_gateway_id" {
}

variable "sg_control_plane_01" {
}

variable "msk_cluster_arn" {
}