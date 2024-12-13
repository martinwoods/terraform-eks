
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.vector_eks_euw1, aws.itdept]

    }
    random = {
      source = "hashicorp/random"
    }
  }
}
