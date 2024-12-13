#########################################################
# Default provider details
#########################################################
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
  default_tags {
    tags = {
      AppID  = "Vector Cloud"
      Client = var.client
      Env    = var.env
    }
  }
}

# Additional provider configuration for eu-west-1 region
# required to access the rim-bst-euw1 VPC
provider "aws" {
  access_key = var.aws_access_key_octopus_agent
  secret_key = var.aws_secret_key_octopus_agent
  alias      = "vector_eks_euw1"
  region     = "eu-west-1"
  default_tags {
    tags = {
      AppID  = "Vector Cloud"
      Client = var.client
      Env    = var.env
    }
  }
}

# Additional provider configuration for eu-west-1 region
# required to access the veu-mte VPC in the "Vector" AWS account
provider "aws" {
  alias      = "veu_mte"
  access_key = var.vector2_aws_access_key
  secret_key = var.vector2_aws_secret_key
  region     = "eu-west-1"
  default_tags {
    tags = {
      AppID  = "Vector Cloud"
      Client = var.client
      Env    = var.env
    }
  }
}

# Additional provider configuration for eu-west-1 region
# required to access the veu-mte VPC in the "Vector" AWS account
# required to access the veu-uat VPC in the "Vector" AWS account
provider "aws" {
  alias      = "vector2_euw1"
  access_key = var.vector2_aws_access_key
  secret_key = var.vector2_aws_secret_key
  region     = "eu-west-1"
  default_tags {
    tags = {
      AppID  = "Vector Cloud"
      Client = var.client
      Env    = var.env
    }
  }
}

# Additional provider configuration for eu-central-1 region
# required to access the veu-fra VPC in the "Vector 2" AWS account
provider "aws" {
  alias      = "vector2_euc1"
  access_key = var.vector2_aws_access_key
  secret_key = var.vector2_aws_secret_key
  region     = "eu-central-1"
  default_tags {
    tags = {
      AppID  = "Vector Cloud"
      Client = var.client
      Env    = var.env
    }
  }
}

# AWS Provider for IT Dept account
# This is same region as the default providor
# This is used in relation to Transit Gateway
provider "aws" {
  access_key = var.vector2_aws_access_key
  alias      = "itdept"
  secret_key = var.vector2_aws_secret_key
  region     = var.region
  assume_role {
    role_arn = "arn:aws:iam::578172820906:role/Vector_CrossAccountSignin"
  }
  default_tags {
    tags = {
      AppID  = "Vector Cloud"
      Client = var.client
      Env    = var.env
    }
  }
}