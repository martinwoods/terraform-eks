# #########################################################
# # CloudWatch Log Subscription 
# #########################################################

resource "aws_cloudwatch_log_subscription_filter" "eks_cluster_psp_logs" {
  name            = "${local.cluster_name}_eks_pod_violations"
  role_arn        = data.aws_iam_role.cloudwatch_logs_kinesis_firehose.arn
  log_group_name  = "/aws/eks/${local.cluster_name}/cluster"
  filter_pattern  = "violate PodSecurity"
  destination_arn = data.aws_kinesis_firehose_delivery_stream.newrelic_logs.arn
  distribution    = "ByLogStream"
}