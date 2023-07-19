[
  {
    "name": ${name},
    "image": ${image},
    "cpu": ${hostPort},
    "memory": ${cpu},
    "essential": ${essential},
    "portMappings": ${portMappings},
    "environment": ${environment},
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${name}",
        "awslogs-region": "${log_options.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]