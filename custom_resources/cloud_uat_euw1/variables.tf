# Variables to support passing information from other modules
# as input variables to this module

# root module variables
variable "env" {
}

variable "client" {
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