resource "aws_ecs_service" "this" {
  for_each        = { for index, service in var.services : service.name => service }
  name            = each.value.name
  cluster         = each.value.cluster_id
  desired_count   = each.value.desired_count
  launch_type     = var.runtime == "FARGATE" ? "FARGATE" : "EC2"
  task_definition = aws_ecs_task_definition.this[each.value.task_definition_index].arn
}
