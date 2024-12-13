resource "aws_msk_scram_secret_association" "msk_scram_secret_association" {
  count = var.msk_scram_enabled && var.msk_enabled ? 1 : 0

  cluster_arn     = aws_msk_cluster.msk[0].arn
  secret_arn_list = [aws_secretsmanager_secret.msk_secretsmanager_secret[0].arn]

  depends_on = [aws_secretsmanager_secret_version.msk_secretsmanager_secret_version]
}

# TFSec: Agreed to ignore logging as it would increase costs and the logs would not be used

#tfsec:ignore:aws-msk-enable-logging
resource "aws_msk_cluster" "msk" {
  count = var.msk_enabled ? 1 : 0

  cluster_name           = local.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type = var.msk_instance_type
    client_subnets = [
      aws_subnet.subnet_private_01.id,
      aws_subnet.subnet_private_02.id,
      aws_subnet.subnet_private_03.id,
    ]
    storage_info {
      ebs_storage_info {
        volume_size = var.msk_ebs_volume_size
      }
    }
    security_groups = [aws_security_group.sg_control_plane_01.id]
  }

  client_authentication {
    unauthenticated = false

    sasl {
      scram = var.msk_scram_enabled
      iam   = false
    }
  }

  lifecycle {
    ignore_changes = [
      # RiM Jira ticket - https://retailinmotion.atlassian.net/browse/DEVOPS-1546
      # Github issue can be found here - https://github.com/hashicorp/terraform-provider-aws/issues/24914
      client_authentication[0].tls
    ]
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
    }
  }

  configuration_info {
    arn      = data.aws_msk_configuration.msk_configuration[0].arn
    revision = data.aws_msk_configuration.msk_configuration[0].latest_revision
  }
}

resource "aws_secretsmanager_secret" "msk_secretsmanager_secret" {
  count = var.msk_scram_enabled && var.msk_enabled ? 1 : 0

  name        = "AmazonMSK_${local.cluster_name}_secret"
  description = "${local.cluster_name} MSK Secret Manager Secret"
  kms_key_id  = aws_kms_key.msk_kms_key[0].key_id

  tags = {
    Name = "${local.cluster_name}-msk-seretsmanager-secret"
  }

}

# TFSec: Agreed not to use kms rotation due to deployment complexity

#tfsec:ignore:aws-kms-auto-rotate-keys
resource "aws_kms_key" "msk_kms_key" {
  count = var.msk_scram_enabled && var.msk_enabled ? 1 : 0

  description             = "${local.cluster_name} MSK Secret Manager KMS Key"
  deletion_window_in_days = 30

  tags = {
    Name = "${local.cluster_name}-kms-key"
  }
}

resource "aws_kms_alias" "msk_kms_alias" {
  count = var.msk_scram_enabled && var.msk_enabled ? 1 : 0

  name          = "alias/${local.cluster_name}-kms-key-alias"
  target_key_id = aws_kms_key.msk_kms_key[0].key_id
}

resource "aws_secretsmanager_secret_version" "msk_secretsmanager_secret_version" {
  count = var.msk_scram_enabled && var.msk_enabled ? 1 : 0

  secret_id     = aws_secretsmanager_secret.msk_secretsmanager_secret[0].id
  secret_string = jsonencode({ username = var.msk_username, password = var.msk_password })
}

resource "aws_secretsmanager_secret_policy" "msk_secretsmanager_secret_policy" {
  count = var.msk_scram_enabled && var.msk_enabled ? 1 : 0

  secret_arn = aws_secretsmanager_secret.msk_secretsmanager_secret[0].arn
  policy     = <<POLICY
{
  "Version" : "2012-10-17",
  "Statement" : [ {
    "Sid": "AWSKafkaResourcePolicy",
    "Effect" : "Allow",
    "Principal" : {
      "Service" : "kafka.amazonaws.com"
    },
    "Action" : "secretsmanager:getSecretValue",
    "Resource" : "${aws_secretsmanager_secret.msk_secretsmanager_secret[0].arn}"
  } ]
}
POLICY
}

# this resource is referenced by a data with the same name aws_msk_configuration
# which is then used by the resource aws_msk_cluster via configurtion_info attribute
resource "aws_msk_configuration" "msk_configuration" {
  count = var.msk_enabled ? 1 : 0

  kafka_versions = ["2.2.1"]
  name           = local.cluster_name

  server_properties = <<PROPERTIES
auto.create.topics.enable = true
PROPERTIES
}