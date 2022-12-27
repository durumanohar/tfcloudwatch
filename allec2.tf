resource "aws_cloudwatch_dashboard" "ec2_dashboard" {
  name        = "EC2 Dashboard"
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 6,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "metrics": [
          [ "AWS/EC2", "CPUUtilization", "InstanceId", "*" ]
        ],
        "region": "us-east-1",
        "title": "CPU Utilization"
      }
    },
    {
      "type": "metric",
      "x": 6,
      "y": 0,
      "width": 6,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "metrics": [
          [ "AWS/EC2", "NetworkIn", "InstanceId", "*" ]
        ],
        "region": "us-east-1",
        "title": "Network In"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 6,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "metrics": [
          [ "AWS/EC2", "NetworkOut", "InstanceId", "*" ]
        ],
        "region": "us-east-1",
        "title": "Network Out"
      }
    },
    {
      "type": "metric",
      "x": 6,
      "y": 6,
      "width": 6,
      "height": 6,
      "properties": {
        "view": "timeSeries",
        "metrics": [
          [ "AWS/EC2", "DiskReadBytes", "InstanceId", "*" ]
        ],
        "region": "us-east-1",
        "title": "Disk Read Bytes"
      }
    }
  ]
}
EOF
}
