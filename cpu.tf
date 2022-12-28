# Get a list of all EC2 instances
data "aws_instances" "ec2_instances" {
  ownership = "self"
}

resource "aws_cloudwatch_dashboard" "ec2_dashboard" {
  name        = "EC2 Dashboard"
  dashboard_body = <<EOF
{
  "widgets": [
    ${
      for instance in data.aws_instances.ec2_instances.instances :
      {
        "type": "metric",
        "x": 0,
        "y": 0,
        "width": 6,
        "height": 6,
        "properties": {
          "view": "timeSeries",
          "stacked": false,
          "metrics": [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", instance.id ]
          ],
          "region": instance.region,
          "title": "CPU Utilization - ${instance.id}"
        }
      }
    }
  ]
}
EOF
}
