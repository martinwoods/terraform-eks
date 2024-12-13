#########################################################
# EKS Cluster details
#########################################################

# TFSec: Agreed not to enable EKS logging, public access is only allowed for the office IPs,
# encrypted secrets ignored and postponed until we decide on it
# eks-encrypt-secrets ignore 3 months. Test before apply on dummy-dev

#tfsec:ignore:aws-eks-enable-control-plane-logging
#tfsec:ignore:aws-eks-no-public-cluster-access
#tfsec:ignore:aws-eks-no-public-cluster-access-to-cidr
resource "aws_eks_cluster" "eks" {
  # see https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  enabled_cluster_log_types = ["api", "audit"]
  name                      = local.cluster_name
  role_arn                  = aws_iam_role.eks_service_role.arn
  version                   = var.eks_version

  tags = {
    Name = local.cluster_name
  }

  # see https://www.terraform.io/docs/providers/aws/r/eks_cluster.html#vpc_config
  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_private_01.id,
      aws_subnet.subnet_private_02.id,
      aws_subnet.subnet_private_03.id,
      aws_subnet.subnet_public_01.id,
      aws_subnet.subnet_public_02.id,
      aws_subnet.subnet_public_03.id,
    ]
    security_group_ids = [
      aws_security_group.sg_control_plane_01.id,
    ]
    endpoint_private_access = true
    public_access_cidrs = [
      local.ix_primary_wan,
      local.ix_primary_wan_2,
      local.ix_aws_direct_connect,
      "${aws_nat_gateway.ngw_01.public_ip}/32",
      "${aws_nat_gateway.ngw_02.public_ip}/32",
      "${aws_nat_gateway.ngw_03.public_ip}/32",
      (var.client == "vcom" && var.env == "dev") || (var.client == "galago" && var.env == "dev") || (var.client == "swift" && var.env == "dev") || (var.client == "cloud" && var.env == "test") ? local.aws_workspace_proxy_01 : local.ix_primary_wan,
      (var.client == "cloud" && var.env == "test") ? local.aws_workspace_proxy_02 : local.ix_primary_wan
    ]
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.k8s_secrets_encrypt_decrypt_key.arn
    }
  }

  depends_on = [aws_kms_key.k8s_secrets_encrypt_decrypt_key, aws_cloudwatch_log_group.eks_cloudwatch_logs]
}
