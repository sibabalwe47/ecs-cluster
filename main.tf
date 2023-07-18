/* ECS Cluster */
resource "aws_ecs_cluster" "this" {
  name = var.name

  configuration {

    execute_command_configuration {
      kms_key_id = var.enable_encryption == true ? aws_kms_key.this.arn : null
      logging    = "OVERRIDE"
      dynamic "log_configuration" {
        for_each = var.enable_logs == true ? [1] : []
        content {
          cloud_watch_encryption_enabled = true
          cloud_watch_log_group_name     = aws_cloudwatch_log_group.this.name
        }
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.enable_logs == true ? 1 : 0
  name  = "${var.name}-logs"
}


resource "aws_kms_key" "this" {
  count                   = var.enable_encryption == true ? 1 : 0
  deletion_window_in_days = 365
}
