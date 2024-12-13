#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "eks_cloudwatch_logs" {
  name              = "/aws/eks/${local.cluster_name}/cluster"
  retention_in_days = 7
  tags = {
    AppRole = "Logging"
    Name    = "${local.cluster_name}"
  }
}
