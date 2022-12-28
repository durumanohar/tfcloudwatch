terraform {
  backend "s3" {
    bucket   = "syapse-terraform"
    key      = "dev/cloudwatch-ec2-dashboard/terraform.tfstate"
    encrypt  = "true"
    region   = "us-west-2"
    role_arn = "arn:aws:iam::304614349146:role/Admin"
  }

  required_version = "1.2.4"

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


resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "CE-EC2-Dashboard"
  
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "EC2|CPU Utilization"
      }
    },
    {
      "type": "metric",
      "x": 8,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkIn"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "EC2|Network In"
      }
    },
    {
      "type": "metric",
      "x": 16,
      "y": 0,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkOut"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "EC2|Network Out"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "DiskReadOps"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "EC2|Disk Read Ops"
      }
    },
    {
      "type": "metric",
      "x": 8,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "DiskWriteOps"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "EC2|Disk Write Ops"
      }
    },
    
    {
      "type": "metric",
      "x": 16,
      "y": 12,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/VPN",
            "TunnelState"
          ],
          [
             "AWS/VPN",
            "TunnelDataIn"
          ],
          [
            "AWS/VPN",
            "TunnelDataOut"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "VPN|Main Stats"
      }
    },
    
    {
      "type": "metric",
      "x": 8,
      "y": 18,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ApplicationELB",
            "ActiveConnectionCount"
          ],
          [
            "AWS/ApplicationELB",
            "HTTP_Redirect_Count"
          ],
          [
            "AWS/ApplicationELB",
            "HTTPCode_ELB_4XX_Count"
          ],
          [
            "AWS/ApplicationELB",
            "HTTPCode_ELB_5XX_Count"
          ],
          [
            "AWS/ApplicationELB",
            "NewConnectionCount"
          ],
          [
            "AWS/ApplicationELB",
            "RejectedConnectionCount"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "Application ELB|Main Stats"
      }
    },
    {
      "type": "metric",
      "x": 16,
      "y": 18,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ELB",
            "BackendConnectionErrors"
          ],
          [
            "AWS/ELB",
            "HTTPCode_Backend_4XX"
          ],
          [
            "AWS/ELB",
            "HTTPCode_Backend_5XX"
          ],
          [
            "AWS/ELB",
            "Latency"
          ],
          [
            "AWS/ELB",
            "RequestCount"
          ],
          [
            "AWS/ELB",
            "UnHealthyHostCount"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "ELB|Main Stats"
      }
    },
    {
      "type": "metric",
      "x": 8,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/RDS",
            "FreeStorageSpace"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "RDS|Storage"
      }
    },
    {
      "type": "metric",
      "x": 8,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/RDS",
            "FreeableMemory"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "us-west-2",
        "title": "RDS|Memory"
      }
    }
   
  ]
}
EOF

}





