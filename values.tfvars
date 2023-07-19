
name                      = "ecs-test"
enable_logs               = true
enable_encryption         = true
enable_container_insights = true
runtime                   = "FARGATE"
task_definitions = [
  {
    family = "task-definition-test"
    task_definition = {
      name   = "task-definition-test-image"
      image  = "siba920429/todo-service-image"
      cpu    = 1
      memory = 512
      portMappings = [
        {
          "containerPort" : 5500
          "hostPort" : 5500
        }
      ]
      environment = [
        {
          "name" : "API_URL"
          "value" : "http://localhost"
        }
      ]
      log_options = {
        logs_group = "test"
        region     = "us-east-1"
      }
    }
  }
]
