#########################################################
# S3 Bucket Policy details
#########################################################

#########################################################
# S3 Bucket policy for public storage policy
resource "aws_s3_bucket_policy" "s3_bucket_policy_storage_public" {
  bucket = aws_s3_bucket.s3_storage_public.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.s3_storage_public.arn}/*"
    }
  ]
}
POLICY

  depends_on = [
    aws_s3_bucket_public_access_block.s3_storage_public
  ]
}

#########################################################