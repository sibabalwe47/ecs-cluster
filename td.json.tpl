[
  {
    "name": ${name},
    "image": ${image},
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": ${essential},
    "portMappings": ${jsonencode(portMappings)},
    "environment": ${jsonencode(environment)},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${log_options_name}",
        "awslogs-region": "${log_options_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]