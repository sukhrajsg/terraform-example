// New mirror bucket
# Contains the new and updated mirror ofthe repository
# This has been mainly imported from existing architecture (hence the slightly odd formatting)

## The bucket
resource "aws_s3_bucket" "s3_new_mirror_bucket" {
  bucket              = var.bucket_names["new"]
  object_lock_enabled = false
  tags                = var.tags

  grant { # Deprecated, but left in because it works
    id = "EXAMPLE"
    permissions = [
      "FULL_CONTROL",
    ]
    type = "CanonicalUser"
  }
}

## The versioning
resource "aws_s3_bucket_versioning" "new_versioning_enabled" {
  bucket = aws_s3_bucket.s3_new_mirror_bucket.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

## The payment config
resource "aws_s3_bucket_request_payment_configuration" "new_payer_request" {
  bucket = aws_s3_bucket.s3_new_mirror_bucket.id
  payer  = "BucketOwner"
}

# The encryption config
resource "aws_s3_bucket_server_side_encryption_configuration" "new_server_side_encryption" {
  bucket = aws_s3_bucket.s3_new_mirror_bucket.id
  rule {
    bucket_key_enabled = true

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}