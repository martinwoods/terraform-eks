#########################################################
# S3 Bucket details
#########################################################

#########################################################
# private S3 bucket for storage microservice

# TFSec: Ignore and postpone encryption and versioning until discussed
# Agreed to ignore logging
# 'aws-s3-enable-bucket-encryption' still need to be here to avoid the TFSec notification despite the fact the s3 encryction is enable in the next block 

#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "s3_storage_private" {
  bucket = "${local.cluster_name}-storage-private"

  tags = {
    AppRole = "Storage"
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_storage_private" {
  bucket = aws_s3_bucket.s3_storage_private.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_storage_private" {
  bucket = aws_s3_bucket.s3_storage_private.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#########################################################
# public S3 bucket for storage microservice

# TFSec: Ignore and postpone encryption and versioning until discussed
# Agreed to ignore logging, public access is needed for the public bucket
# 'aws-s3-enable-bucket-encryption' still need to be here to avoid the TFSec notification despite the fact the s3 encryction is enable in the next block 

#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-specify-public-access-block
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "s3_storage_public" {
  bucket = "${local.cluster_name}-storage-public"

  tags = {
    AppRole = "Storage"
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_storage_public" {
  bucket = aws_s3_bucket.s3_storage_public.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "s3_storage_public_cors_rule" {
  bucket = aws_s3_bucket.s3_storage_public.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = split(",", var.storage_public_cors_allowed_origins)
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_storage_public" {
  bucket = aws_s3_bucket.s3_storage_public.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

#tfsec:ignore:aws-s3-no-public-access-with-acl
resource "aws_s3_bucket_acl" "s3_storage_public" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_storage_public,
  aws_s3_bucket_public_access_block.s3_storage_public]

  bucket = aws_s3_bucket.s3_storage_public.id
  acl    = "public-read-write"
}

# TFSec
# Ignore permanently all limitations publicly accessible buckets.
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-ignore-public-acls
#tfsec:ignore:aws-s3-no-public-buckets
resource "aws_s3_bucket_public_access_block" "s3_storage_public" {
  bucket = aws_s3_bucket.s3_storage_public.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#########################################################
# private S3 bucket for MongoDB backups

# TFSec
# Agreed to ignore logging
# Cannot do SSE-S3 encryption as mgob only supports SSE-KMS
# No need for versioning
# 'aws-s3-enable-bucket-encryption' still need to be here to avoid the TFSec notification despite the fact the s3 encryction is enable in the next block 

#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-bucket-encryption
resource "aws_s3_bucket" "s3_mongodb_backup" {
  bucket = "${local.cluster_name}-mongodb-backup"

  tags = {
    AppRole = "Storage"
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_mongodb_backup" {
  bucket = aws_s3_bucket.s3_mongodb_backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_mongodb_backup" {
  bucket = aws_s3_bucket.s3_mongodb_backup.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "mongo_backup_retention_policy" {
  bucket = aws_s3_bucket.s3_mongodb_backup.id

  rule {
    id = "archive_expire_mongodb_backup_buckets"

    filter {}

    transition {
      days          = 28
      storage_class = "GLACIER"
    }

    expiration {
      days = 366
    }

    status = "Enabled"
  }
}

#########################################################
# private S3 bucket for Elasticsearch backups

# Ignore all warning about the ES bucket, it's not used and should be cleaned up

#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-specify-public-access-block
#tfsec:ignore:aws-s3-block-public-acls
#tfsec:ignore:aws-s3-block-public-policy
#tfsec:ignore:aws-s3-no-public-buckets
#tfsec:ignore:aws-s3-encryption-customer-key
#tfsec:ignore:aws-s3-ignore-public-acls
resource "aws_s3_bucket" "s3_elasticsearch_backup" {
  bucket = "${local.cluster_name}-elasticsearch-backup"

  tags = {
    AppRole = "Storage"
  }
}
