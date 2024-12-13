resource "aws_kms_key" "k8s_secrets_encrypt_decrypt_key" {
  is_enabled              = true
  description             = "${local.cluster_name} k8s Secrets symmetric KMS Key"
  deletion_window_in_days = 30

  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true
  multi_region             = true

  tags = {
    Name = "${local.cluster_name}-kms-k8s-secrets-symmetric-key"
  }
}