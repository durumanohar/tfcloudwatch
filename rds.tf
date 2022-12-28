# Get a list of all RDS PostgreSQL instances
data "aws_rds_cluster_instance" "rds_instances" {
  engine = "postgres"
}

resource "aws_cloudwatch_dashboard" "rds_dashboard" {
  name        = "RDS Dashboard"
  dashboard_body = jsonencode({
    widgets = [
      for instance in data.aws_rds_cluster_instance.rds_instances.instances :
      {
        type = "metric"
        x = 0
        y = 0
        width = 6
        height = 6
        properties = {
          view = "timeSeries"
          stacked = false
          metrics = [
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", instance.id],
            ["AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", instance.id]
          ]
          region = instance.region
          title = "Utilization - ${instance.id}"
        }
      }
    ]
  })
}
