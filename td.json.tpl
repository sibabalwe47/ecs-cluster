[
  {
    "name": "${name}",
    "image": "${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "portMappings": [
      {
        "name": "kia-dms-staging-3000-tcp",
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "NEXT_PUBLIC_DMS_URL",
        "value": "https://staging.dms.kiaretail.co.za"
      },
      {
        "name": "NEXT_CONVERSION_LT_TARGET",
        "value": "8"
      },
      {
        "name": "NEXT_CONVERSION_GT_TARGET",
        "value": "12"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/kia-dms-staging",
        "awslogs-region": "af-south-1",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]