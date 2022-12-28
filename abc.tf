# Define a list of metrics to include in the dashboard
variable "metrics" {
  default = [
    {
      name = "CPUUtilization"
      title = "CPU Utilization"
    },
    {
      name = "NetworkIn"
      title = "Network In"
    },
    {
      name = "NetworkOut"
      title = "Network Out"
    },
    {
      name = "DiskReadBytes"
      title = "Disk Read Bytes"
    }
  ]
}

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
        for metric in var.metrics :
        {
          "type": "metric",
          "x": ${for i, _ in var.metrics : i % 2 == 0 ? 0 : 6},
          "y": ${for i, _ in var.metrics : i // 2 * 6},
          "width": 6,
          "height": 6,
          "properties": {
            "view": "timeSeries",
            "stacked": false,
            "metrics": [
              [ "AWS/EC2", metric.name, "InstanceId", instance.id ]
            ],
            "region": instance.region,
            "title": "${metric.title} - ${instance.id}"
          }
        }
      }
    }
  ]
}
EOF
}
