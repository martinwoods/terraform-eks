terraform {
  # setting minimum version of Terraform
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.vector2_euc1, aws.vector2_euw1]
    }
  }
}