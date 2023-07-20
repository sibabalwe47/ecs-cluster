resource "aws_ecs_task_definition" "this" {
  for_each                 = { for index, task in var.task_definitions : task.family => task }
  family                   = each.value.family
  requires_compatibilities = [var.runtime]
  network_mode             = var.runtime == "FARGATE" ? "awsvpc" : "brigde"
  task_role_arn            = var.runtime == "FARGATE" ? "${data.aws_iam_role.ecs_task_execution_role.arn}" : null
  execution_role_arn       = var.runtime == "FARGATE" ? "${data.aws_iam_role.ecs_task_execution_role.arn}" : null
  cpu                      = var.runtime == "FARGATE" ? each.value.task_definition.cpu : null
  memory                   = var.runtime == "FARGATE" ? each.value.task_definition.memory : null
  container_definitions = templatefile("./td.json.tpl", {
    name               = each.value.task_definition.name
    image              = each.value.task_definition.image
    cpu                = each.value.task_definition.cpu
    memory             = each.value.task_definition.memory
    essential          = true
    portMappings       = jsonencode(each.value.task_definition.portMappings)
    environments       = jsonencode(each.value.task_definition.environment)
    log_options_name   = each.value.task_definition.log_options.logs_group
    log_options_region = each.value.task_definition.log_options.region
  })

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
