#########################################################
# IAM User Account details
#########################################################

#########################################################
# IAM account for storage microservice
resource "aws_iam_user" "iam_storage_user" {
  name = "${local.cluster_name}-storage"
}

# policy attachment for iam_storage_user
resource "aws_iam_user_policy_attachment" "pa_iam_storage" {
  user       = aws_iam_user.iam_storage_user.name
  policy_arn = aws_iam_policy.iam_policy_storage_access.arn
}

# access key for iam_storage_user
resource "aws_iam_access_key" "ak_iam_storage" {
  user = aws_iam_user.iam_storage_user.name
}


#########################################################
# IAM account for backup process
resource "aws_iam_user" "iam_backup_user" {
  name = "${local.cluster_name}-backup"
}

# policy attachment for iam_backup_user
resource "aws_iam_user_policy_attachment" "pa_iam_backup" {
  user       = aws_iam_user.iam_backup_user.name
  policy_arn = aws_iam_policy.iam_policy_backup_access.arn
}

# access key for iam_backup_user
resource "aws_iam_access_key" "ak_iam_backup" {
  user = aws_iam_user.iam_backup_user.name
}


#########################################################
# IAM account for SQS queue management
resource "aws_iam_user" "iam_sqs_user" {
  name = "${local.cluster_name}-sqs-user"
}

# policy attachment for iam_sqs_user
resource "aws_iam_user_policy_attachment" "pa_iam_sqs" {
  user       = aws_iam_user.iam_sqs_user.name
  policy_arn = aws_iam_policy.iam_policy_sqs.arn
}

# access key for iam_sqs_user
resource "aws_iam_access_key" "ak_iam_sqs" {
  user = aws_iam_user.iam_sqs_user.name
}


#########################################################
# IAM account for Secrets Manager access
resource "aws_iam_user" "iam_secrets_manager_user" {
  name = "${local.cluster_name}-secrets-manager-user"
}

# Policy attachment for iam_secrets_manager_user
resource "aws_iam_user_policy_attachment" "pa_iam_secrets_manager" {
  user       = aws_iam_user.iam_secrets_manager_user.name
  policy_arn = aws_iam_policy.iam_policy_secrets_manager.arn
}

# access key for iam_secrets_manager_user
resource "aws_iam_access_key" "ak_iam_secrets_manager" {
  user = aws_iam_user.iam_secrets_manager_user.name
}
