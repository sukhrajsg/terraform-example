// IAM role for the Scheduler 
# This makes the IAM role that will be assumed by aws scheduler schedules/

## The policy
resource "aws_iam_policy" "scheduler_ec2_policy" {
  name = "scheduler_ec2_policy"
  tags = var.tags


  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "ec2:StartInstances",
            "ec2:StopInstances"
          ],
          "Resource" : [
            "${aws_instance.mirror_ec2.arn}:*",
            "${aws_instance.mirror_ec2.arn}"
          ],
        }
      ]
    }
  )
}

## The IAM role
resource "aws_iam_role" "scheduler-ec2-role" {
  name                = "scheduler-ec2-role"
  tags                = var.tags
  managed_policy_arns = [aws_iam_policy.scheduler_ec2_policy.arn]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      },
    ]
  })
  permissions_boundary = "EXAMPLE"
}
