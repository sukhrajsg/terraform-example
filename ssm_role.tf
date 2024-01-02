// SSM service role 
# Allows full s3, EC2 access and the chance to access the EC2 through the session manaager

## The policy for the bucket control
resource "aws_iam_policy" "EXAMPLE_mirror_policy" {
  name = "EXAMPLE_mirror_policy"
  tags = var.tags

  # Allowing s3/ s3 lambda for my buckets only
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*",
            "s3-object-lambda:*"
          ],
          "Resource" : [
            "${aws_s3_bucket.s3_diffs_mirror_bucket.arn}",
            "${aws_s3_bucket.s3_diffs_mirror_bucket.arn}/*",
            "${aws_s3_bucket.s3_new_mirror_bucket.arn}",
            "${aws_s3_bucket.s3_new_mirror_bucket.arn}/*",
            "${aws_s3_bucket.s3_old_mirror_bucket.arn}",
            "${aws_s3_bucket.s3_old_mirror_bucket.arn}/*"
          ],
        }
      ]
    }
  )
}

# The policy to allow the EC2 to be managed
resource "aws_iam_policy" "EXAMPLE_ec2_policy" {
  name = "EXAMPLE_ec2_policy"
  tags = var.tags


  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "ec2:*",
          "Effect" : "Allow",
          "Resource" : "EXAMPLE"
        },
      ]
    }
  )
}

# The IAM role
resource "aws_iam_role" "ssm_role" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  description           = "Contains policy exceptions for use on the EC2, s3 buckets and using the SSM role"
  force_detach_policies = false
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", # SSM policy (AWS managed)
    "${aws_iam_policy.EXAMPLE_ec2_policy.arn}",             # Using my EC2 policy (Full control over that EC2)
    "${aws_iam_policy.EXAMPLE_policy.arn}"                  # Using my S3 policy (Full control over my buckets)
  ]
  max_session_duration = 3600
  name                 = "ssm-service-role"
  path                 = "/"
  permissions_boundary = "EXAMPLE"
  tags                 = var.tags
}