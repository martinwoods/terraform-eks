#########################################################
# AWS Credentials
#########################################################

# AWS Account where your EKS cluster gets created(DEV/TEST/UAT/PROD)
variable "aws_access_key" {}
variable "aws_secret_key" {}

# Vector EKS Account
# required to access the rim-bst-euw1 VPC
# Using the "octopus.agent" IAM service account user
variable "aws_access_key_octopus_agent" {}
variable "aws_secret_key_octopus_agent" {}

# Vector 2 AWS Account
variable "vector2_aws_access_key" {}
variable "vector2_aws_secret_key" {}

#########################################################
# AWS Region to deploy VPC into
#########################################################

variable "region" {}

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

#########################################################
# EC2 Configuration
#########################################################

# KeyPair to use with EC2 instances when launched
# N.B. keypair MUST be exist in the region BEFORE deployment
# private key should be saved with IT Ops Team
variable "ec2_key_name" {}

# EC2 Instance types
# there are baseline default values within the ec2_instances module template
variable "ec2_instance_type_worker_node" {
  default = "m5.large"
}

variable "ec2_default_instance_type_spot_node" {
  default = "t3.large"
}

variable "ec2_instance_types_spot_node" {
  default = "m5.large,t3.large"
}

#########################################################
# EC2 Auto Scaling Group Configuration
#########################################################

# This is to set the number of Worker Nodes in the  Auto Scaling Group

variable "asg_desired_size" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group"
  default     = 6
}

variable "asg_min_size" {
  type        = number
  description = "The minimum size of the auto scale group"
  default     = 3
}

variable "asg_max_size" {
  type        = number
  description = "The maximum size of the auto scale group"
  default     = 6

}

# This is to set the number of Spot Worker Nodes in the Auto Scaling Group

variable "asg_desired_size_spot" {
  type        = number
  description = "The number of Amazon EC2 spot instances that should be running in the group"
  default     = 6
}

variable "asg_min_size_spot" {
  type        = number
  description = "The minimum size of the auto scale group"
  default     = 3
}

variable "asg_max_size_spot" {
  type        = number
  description = "The maximum size of the auto scale group"
  default     = 6

}

variable "asg_cron_nodes_stop" {
  type        = string
  description = "Europe/Dublin time zone is used to schedule auto scale group to scale down to 0 nodes"
  default     = "0 20 * * MON-FRI"
}

variable "asg_cron_nodes_start" {
  type        = string
  description = "Europe/Dublin time zone is used to schedule auto scale group to scale up to desired amount of nodes"
  default     = "30 6 * * MON-FRI"
}

#########################################################
# EKS Configuration
#########################################################

# This is to set the versin of EKS Control Plane and Worker Nodes
variable "eks_version" {
  type        = string
  description = "The version for EKS Control Plane & Worker Nodes AMI"
  default     = "1.22"
}

#########################################################
# AWS MSK (Managed Streaming for Kafka) Config
#########################################################

# AWS Kafka Version
variable "kafka_version" {
  type        = string
  description = "Kafka Version"
  default     = ""
}

variable "msk_enabled" {
  type        = bool
  description = "Set to true to enable creation of AWS MSK cluster for this system"
  default     = false
}
variable "msk_privateca_arn" {
  type        = string
  description = "ARN for the ACM Private CA used with MSK client authentication"
  default     = "arn:aws:acm-pca:eu-west-1:711487900668:certificate-authority/361a0b7e-d5ba-42b6-a583-caf572f450c7"
}

variable "msk_instance_type" {
  description = "Instance size for MSK Kafka brokers"
  default     = "kafka.m5.large"
}

variable "msk_ebs_volume_size" {
  description = "Storage volume size for MSK Kafka brokers, in GB"
  default     = "250"
}

# AWS MSK SASL/SCRAM authentication
variable "msk_username" {
  type        = string
  description = "MSK username"
  default     = ""
}

variable "msk_password" {
  type        = string
  description = "MSK password"
  #tfsec:ignore:general-secrets-sensitive-in-variable
  default = ""
}

variable "msk_scram_enabled" {
  type        = bool
  description = "Set to true to enable creation of AWS MSK cluster for this system with SASL Scram auth"
  default     = false
}

#########################################################
# AWS DLM Configuration
#########################################################
variable "dlm_interval" {
  description = "The number of hours between policy runs. Supported values 2, 3, 4, 6, 8, 12, 24."
  default     = 24
}

variable "dlm_times" {
  description = "The time at which the policy runs are scheduled to start."
  default     = "23:55"
}

variable "dlm_retain_interval" {
  description = "The amount of time to retain each snapshot. The maximum is 100 years."
  default     = 1
}

#########################################################
# Misc configuration
#########################################################

variable "storage_public_cors_allowed_origins" {
  type        = string
  description = "Comma separated list of domains to allow for cross origin requests for the public storage S3"
  default     = "https://*.flight-retail.com"
}

variable "secrets_manager_region" {
  type        = string
  description = "The AWS region where the secrets for this cluster will be placed"
  #tfsec:ignore:general-secrets-sensitive-in-variable
  default = "eu-west-1"
}

#########################################################
# Machine Learning configuration
#########################################################

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
  default = "m5.xlarge,r5.large"  
}

variable "isMLNodeEnabled" {
  type = string
  description = "Is need to spin up ML dedicated Node in the EKS cluster?"
  default = "false"
}