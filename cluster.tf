/* ECS Cluster */
resource "aws_ecs_cluster" "this" {
  name = var.name
  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }
  configuration {
    execute_command_configuration {
      kms_key_id = var.enable_encryption == true ? aws_kms_key.this[0].arn : null
      logging    = var.enable_logs == true ? "OVERRIDE" : "DEFAULT"
      dynamic "log_configuration" {
        for_each = var.enable_logs == true ? [1] : []
        content {
          cloud_watch_encryption_enabled = var.enable_encryption == true ? true : false
          cloud_watch_log_group_name     = aws_cloudwatch_log_group.this[0].name
        }
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.enable_logs == true ? 1 : 0
  name  = "/ecs/${var.name}"
}


resource "aws_kms_key" "this" {
  count                   = var.enable_encryption == true ? 1 : 0
  deletion_window_in_days = 30
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  count        = var.runtime == "FARGATE" ? 1 : 0
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
