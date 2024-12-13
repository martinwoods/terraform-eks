resource "aws_dlm_lifecycle_policy" "dlm_lifecycle_policy" {

  description        = "${local.cluster_name} DLM lifecycle policy"
  execution_role_arn = aws_iam_role.dlm_lifecycle_role.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "${local.cluster_name} Default Schedule"

      create_rule {
        interval      = var.dlm_interval
        interval_unit = "HOURS"
        times         = [var.dlm_times]
      }

      retain_rule {
        interval      = var.dlm_retain_interval
        interval_unit = "MONTHS"
      }

      tags_to_add = {
        SnapshotCreator = "${var.client}-${var.env}-DLM"
        Client          = var.client
        Env             = var.env
      }

      copy_tags = true
    }

    target_tags = {
      "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    }
  }
}