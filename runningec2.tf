# Retrieve a list of all running EC2 instances in the region
data "aws_instances" "ec2_instances" {
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

# Create a CloudWatch dashboard for the running EC2 instances
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
        "stacked": false,
        "metrics": [
          [ "AWS/EC2", "CPUUtilization", "InstanceId", "${join(",", data.aws_instances.ec2_instances.ids)}" ]
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
        "stacked": false,
        "metrics": [
          [ "AWS/EC2", "NetworkIn", "InstanceId", "${join(",", data.aws_instances.ec2_instances.ids)}" ]
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
        "stacked": false,
        "metrics": [
          [ "AWS/EC2", "NetworkOut", "InstanceId", "${join(",", data.aws_instances.ec2_instances.ids)}" ]
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
        "stacked": false,
        "metrics": [
          [ "AWS/EC2", "Disk
