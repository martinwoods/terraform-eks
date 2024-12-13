#########################################################
# Terraform version settings
#########################################################
terraform {
  # setting minimum version of Terraform
  required_version = "~> 1.5.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.vector_eks_euw1]
    }
  }
}