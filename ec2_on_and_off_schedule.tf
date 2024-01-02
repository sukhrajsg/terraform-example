// On and Off Scheduler 
# This will turn the EC2 on and off at given times (using cron expressions) which will trigger the diffs-checking application

## The schedule group
resource "aws_scheduler_schedule_group" "ec2_on_off_group" {
  name = "SAI-DIP-REP-scheduler-group"
  tags = var.tags
}

## The on schedule
resource "aws_scheduler_schedule" "ec2_on_schedule" {
  # Starts the instance
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression          = "cron(0 1 ? * SUN *)" # First Sunday of the month at 1AM
  schedule_expression_timezone = "GMT"
  description                  = "Start instances"
  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = aws_iam_role.scheduler-ec2-role.arn
    input = jsonencode({
      "InstanceIds" : [
        "${aws_instance.mirror_ec2.id}"
      ]
    })
  }
  name       = "turn-ec2-on"
  group_name = aws_scheduler_schedule_group.ec2_on_off_group.id

  state = "DISABLED"

}

## The off schedule
resource "aws_scheduler_schedule" "ec2_off_schedule" {
  # Stops the instance
  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression          = "cron(15 8 ? * SUN *)" # First Sunday of the month at 8:15 AM
  schedule_expression_timezone = "GMT"
  description                  = "Stop instances"
  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.scheduler-ec2-role.arn
    input = jsonencode({
      "InstanceIds" : [
        "${aws_instance.mirror_ec2.id}"
      ]
    })
  }
  name       = "turn-ec2-off"
  group_name = aws_scheduler_schedule_group.ec2_on_off_group.id

  state = "DISABLED"

}

