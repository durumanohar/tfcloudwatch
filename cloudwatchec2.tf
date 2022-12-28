terraform {
  backend "s3" {
    bucket   = "syapse-terraform"
    key      = "dev/cloudwatch-ec2new-dashboard/terraform.tfstate"
    encrypt  = "true"
    region   = "us-west-2"
    role_arn = "arn:aws:iam::304614349146:role/Admin"
  }

  

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region = "us-west-2"
  allowed_account_ids = [var.acct_num]

  assume_role {
    role_arn = var.role_arn
  }
}



resource "aws_cloudwatch_dashboard" "EC2_Dashboard" {
  dashboard_name = "EC2-TEST-EC2-Dashboard"

  dashboard_body = <<EOF

{
   "start": "-PT9H",
   "periodOverride": "inherit",
   "widgets": [
      
      {
         "type":"metric",
         "x":0,
         "y":0,
         "width":12,
         "height":6,
         "properties":{
            "metrics":[
               [ { "expression": "SEARCH('{AWS/EC2,InstanceId} MetricName=\"NetworkIn\"', 'Average', 300)", "id": "e1" } ]
            ],
            "view": "timeSeries",
            "stacked": false,
            "region":"us-west-2",
            "title":"EC2 Network In"
         }
      },
      {
         "type":"metric",
         "x":0,
         "y":0,
         "width":12,
         "height":6,
         "properties":{
            "metrics":[
               [ { "expression": "SEARCH('{AWS/EC2,InstanceId} MetricName=\"CPUUtilization\"', 'Average', 300)", "id": "e1" } ]
            ],
            "view": "timeSeries",
            "stacked": false,
            "region":"us-west-2",
            "title":"EC2 CPU Utilization"
         }
      },
      {
         "type":"metric",
         "x":0,
         "y":0,
         "width":12,
         "height":6,
         "properties":{
            "metrics":[
               [ { "expression": "SEARCH('{AWS/EC2,InstanceId} MetricName=\"NetworkOut\"', 'Average', 300)", "id": "e1" } ]
            ],
            "view": "timeSeries",
            "stacked": false,
            "region":"us-west-2",
            "title":"EC2 Network Out"
         }
      },
      {
         "type":"metric",
         "x":0,
         "y":0,
         "width":12,
         "height":6,
         "properties":{
            "metrics":[
               [ { "expression": "SEARCH('{AWS/EC2,InstanceId} MetricName=\"DiskReadBytes\"', 'Average', 300)", "id": "e1" } ]
            ],
            "view": "timeSeries",
            "stacked": false,
            "region":"us-west-2",
            "title":"EC2 Disk Read Bytes "
         }
      }
   ]
}
EOF
}
    
