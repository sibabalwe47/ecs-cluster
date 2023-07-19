resource "aws_ecs_task_definition" "this" {
  for_each                 = { for index, task in var.task_definitions : task.family => task }
  family                   = each.value.family
  requires_compatibilities = [var.runtime]
  network_mode             = var.runtime == "FARGATE" ? "awsvpc" : "brigde"
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
}
