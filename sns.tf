resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "example"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This alarm will trigger when the average CPU utilization of the EC2 instance exceeds 80%."
  alarm_actions       = [aws_sns_topic.example.arn]
  dimensions = {
    InstanceId = aws_instance.example.id
  }
}

resource "aws_sns_topic" "example" {
  name = "example"
}

resource "aws_sns_topic_subscription" "example" {
  topic_arn = aws_sns_topic.example.arn
  protocol = "email"
  endpoint = "youremail@example.com"
}
