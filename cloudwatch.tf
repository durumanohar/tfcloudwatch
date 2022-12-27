resource "aws_cloudwatch_dashboard" "ec2_dashboard" {
  name        = "EC2 Dashboard"
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "metrics": [
          [ "AWS/EC2", "CPUUtilization", "InstanceId", "*" ]
        ],
        "region": "us-east-1",
        "title": "CPU Utilization"
      }
    }
  ]
}
EOF
}
