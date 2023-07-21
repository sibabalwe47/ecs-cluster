
name                      = "ecs-test"
enable_logs               = true
enable_encryption         = true
enable_container_insights = true
runtime                   = "FARGATE"
subnets                   = ["subnet-049c863f3f16d2342"]
security_groups           = ["sg-0b9d22845128875ce"]
ecr_repositories          = ["test"]
task_definitions = [
  {
    family = "task-definition-test"
    task_definition = {
      name   = "task-definition-test-image"
      image  = "siba920429/todo-service-image"
      cpu    = 256
      memory = 512
      portMappings = [
        {
          "containerPort" = 5500
          "hostPort"      = 5500
        },
        {
          "containerPort" = 80
          "hostPort"      = 80
        }
      ]
      environment = [
        {
          "name"  = "API_URL"
          "value" = "http://localhost"
        }
      ]
      log_options = {
        logs_group = "test"
        region     = "us-east-1"
      }
    }
  },
  {
    family = "ts-1"
    task_definition = {
      name   = "task-definition-test-image"
      image  = "siba920429/todo-service-image"
      cpu    = 256
      memory = 512
      portMappings = [
        {
          "containerPort" = 5500
          "hostPort"      = 5500
        },
        {
          "containerPort" = 80
          "hostPort"      = 80
        }
      ]
      environment = [
        {
          "name"  = "API_URL"
          "value" = "http://localhost"
        }
      ]
      log_options = {
        logs_group = "ts-1"
        region     = "us-east-1"
      }
    }
  }
]

services = [
  {
    task_definition_family = "task-definition-test"
    name                   = "service-1"
    desired_count          = 1
  },
  {
    task_definition_family = "ts-1"
    name                   = "service-2"
    desired_count          = 1
  }
]
