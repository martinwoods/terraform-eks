#########################################################
# EC2 AMI Data Resource
#########################################################

# see https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html

data "aws_ami" "eks_node" {
  most_recent = true
  name_regex  = "^amazon-eks-node-${var.eks_version}-v\\d{8}"

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}