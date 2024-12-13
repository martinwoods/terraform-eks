#########################################################
# IAM Access Policy details
#########################################################

#########################################################
# policies to allow the IAM Storage user read-write access
# to the public and private S3 buckets

resource "aws_iam_policy" "iam_policy_storage_access" {
  name        = "${local.cluster_name}-storage-s3-access"
  path        = "/"
  description = "Read Write access for ${aws_iam_user.iam_storage_user.name} IAM to ${aws_s3_bucket.s3_storage_public.id} and ${aws_s3_bucket.s3_storage_private.id} S3 buckets"

  policy = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:AbortMultipartUpload",
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:DeleteBucketWebsite",
                "s3:DeleteObject",
                "s3:DeleteObjectTagging",
                "s3:DeleteObjectVersion",
                "s3:DeleteObjectVersionTagging",
                "s3:GetAccelerateConfiguration",
                "s3:GetAnalyticsConfiguration",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:GetBucketLogging",
                "s3:GetBucketNotification",
                "s3:GetBucketPolicy",
                "s3:GetBucketPolicyStatus",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetInventoryConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetMetricsConfiguration",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetObjectTagging",
                "s3:GetObjectTorrent",
                "s3:GetObjectVersion",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectVersionForReplication",
                "s3:GetObjectVersionTagging",
                "s3:GetObjectVersionTorrent",
                "s3:GetReplicationConfiguration",
                "s3:ListBucket",
                "s3:ListBucketByTags",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:ListMultipartUploadParts",
                "s3:PutAccelerateConfiguration",
                "s3:PutAnalyticsConfiguration",
                "s3:PutBucketCORS",
                "s3:PutBucketLogging",
                "s3:PutBucketNotification",
                "s3:PutBucketRequestPayment",
                "s3:PutBucketTagging",
                "s3:PutBucketVersioning",
                "s3:PutBucketWebsite",
                "s3:PutEncryptionConfiguration",
                "s3:PutInventoryConfiguration",
                "s3:PutLifecycleConfiguration",
                "s3:PutMetricsConfiguration",
                "s3:PutObject",
                "s3:PutObjectTagging",
                "s3:PutObjectVersionTagging",
                "s3:PutReplicationConfiguration",
                "s3:ReplicateDelete",
                "s3:ReplicateObject",
                "s3:ReplicateTags",
                "s3:RestoreObject"
            ],
            "Resource": [
                "${aws_s3_bucket.s3_storage_private.arn}",
                "${aws_s3_bucket.s3_storage_private.arn}/*",
                "${aws_s3_bucket.s3_storage_public.arn}",
                "${aws_s3_bucket.s3_storage_public.arn}/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:GetAccountPublicAccessBlock",
            "Resource": "*"
        }
    ]
}
EOF

}


#########################################################
# policy to allow the IAM Backup user read-write access
# to the private backup S3 buckets

resource "aws_iam_policy" "iam_policy_backup_access" {
  name        = "${local.cluster_name}-backup-s3-access"
  path        = "/"
  description = "Read Write access for ${aws_iam_user.iam_backup_user.name} IAM to ${aws_s3_bucket.s3_mongodb_backup.id} and ${aws_s3_bucket.s3_elasticsearch_backup.id} S3 buckets"

  policy = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:AbortMultipartUpload",
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:DeleteBucketWebsite",
                "s3:DeleteObject",
                "s3:DeleteObjectTagging",
                "s3:DeleteObjectVersion",
                "s3:DeleteObjectVersionTagging",
                "s3:GetAccelerateConfiguration",
                "s3:GetAnalyticsConfiguration",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:GetBucketLogging",
                "s3:GetBucketNotification",
                "s3:GetBucketPolicy",
                "s3:GetBucketPolicyStatus",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetInventoryConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetMetricsConfiguration",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetObjectTagging",
                "s3:GetObjectTorrent",
                "s3:GetObjectVersion",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectVersionForReplication",
                "s3:GetObjectVersionTagging",
                "s3:GetObjectVersionTorrent",
                "s3:GetReplicationConfiguration",
                "s3:ListBucket",
                "s3:ListBucketByTags",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:ListMultipartUploadParts",
                "s3:PutAccelerateConfiguration",
                "s3:PutAnalyticsConfiguration",
                "s3:PutBucketCORS",
                "s3:PutBucketLogging",
                "s3:PutBucketNotification",
                "s3:PutBucketRequestPayment",
                "s3:PutBucketTagging",
                "s3:PutBucketVersioning",
                "s3:PutBucketWebsite",
                "s3:PutEncryptionConfiguration",
                "s3:PutInventoryConfiguration",
                "s3:PutLifecycleConfiguration",
                "s3:PutMetricsConfiguration",
                "s3:PutObject",
                "s3:PutObjectTagging",
                "s3:PutObjectVersionTagging",
                "s3:PutReplicationConfiguration",
                "s3:ReplicateDelete",
                "s3:ReplicateObject",
                "s3:ReplicateTags",
                "s3:RestoreObject"
            ],
            "Resource": [
                "${aws_s3_bucket.s3_mongodb_backup.arn}",
                "${aws_s3_bucket.s3_mongodb_backup.arn}/*",
                "${aws_s3_bucket.s3_elasticsearch_backup.arn}",
                "${aws_s3_bucket.s3_elasticsearch_backup.arn}/*"
            ]
        }
    ]
}
EOF


}

#########################################################
# DLM Policy to manage automated snapshot backup

# TFSec: Volumes are created by services deployed to K8S, 
# cannot know their ARNs when applying TF

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_role_policy" "iam_policy_dlm_lifecycle" {
  name = "${local.cluster_name}-dlm-lifecycle-policy"
  role = aws_iam_role.dlm_lifecycle_role.id

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateSnapshot",
            "ec2:DeleteSnapshot",
            "ec2:DescribeVolumes",
            "ec2:DescribeSnapshots"
         ],
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": [
            "ec2:CreateTags"
         ],
         "Resource": "arn:aws:ec2:*::snapshot/*"
      }
   ]
}
EOF
}


#########################################################
# SQS Policy to allow queue management service

resource "aws_iam_policy" "iam_policy_sqs" {
  name        = "${local.cluster_name}-sqs"
  path        = "/"
  description = "Access for ${aws_iam_user.iam_sqs_user.name} IAM to SQS service"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "sqs:CreateQueue",
                "sqs:DeleteMessage",
                "sqs:DeleteMessageBatch",
                "sqs:DeleteQueue",
                "sqs:GetQueueAttributes",
                "sqs:GetQueueUrl",
                "sqs:ListQueues",
                "sqs:ReceiveMessage",
                "sqs:SendMessage",
                "sqs:SendMessageBatch",
                "sqs:SetQueueAttributes",
                "sqs:TagQueue"
            ],
            "Resource": "arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:*"
        }
    ]
}
EOF
}


#########################################################
# Policy to allow access to Secrets Manager

resource "aws_iam_policy" "iam_policy_secrets_manager" {
  name        = "${local.cluster_name}-secrets-manager"
  path        = "/"
  description = "Access for ${aws_iam_user.iam_secrets_manager_user.name} IAM & EC2 Worker Nodes to Secrets Manager"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecrets"
            ],
            "Resource": [
                "arn:aws:secretsmanager:${var.secrets_manager_region}:${data.aws_caller_identity.current.account_id}:secret:${local.cluster_name}/shared/*",
                "arn:aws:secretsmanager:${var.secrets_manager_region}:${data.aws_caller_identity.current.account_id}:secret:${local.cluster_name}/services/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:CreateSecret",
                "secretsmanager:DeleteSecret",
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetRandomPassword",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:ListSecretVersionIds",
                "secretsmanager:PutSecretValue",
                "secretsmanager:UpdateSecret"
            ],
            "Resource": "arn:aws:secretsmanager:${var.secrets_manager_region}:${data.aws_caller_identity.current.account_id}:secret:${local.cluster_name}/services/*"
        }
    ]
}
EOF
}

#########################################################
# Policy to allow CSI driver to encrypt the EBS drives

resource "aws_iam_policy" "csi_driver_encrypt_permissions" {
  name        = "${local.cluster_name}-ebs-csi-driver-encrypt-permissions"
  path        = "/"
  description = "Policy to allow CSI driver to encrypt the EBS drives"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:CreateGrant"
            ],
            "Resource": "arn:aws:kms:${var.secrets_manager_region}:${data.aws_caller_identity.current.account_id}:key/*"
        }
    ]
}
EOF
}
