
variable "name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}
variable "runtime" {
  type = string
}

variable "enable_logs" {
  type = bool
}

variable "enable_container_insights" {
  type = bool
}

variable "enable_encryption" {
  type = bool
}

variable "task_definitions" {
  type = list(object({
    family = string
    task_definition = object({
      name   = string
      image  = string
      cpu    = number
      memory = number
      portMappings = list(object({
        containerPort = number
        hostPort      = number
      }))
      environment = list(object({
        name  = string
        value = string
      }))
      log_options = object({
        logs_group = string
        region     = string
      })
    })
  }))
}

variable "services" {
  type = list(object({
    task_definition_family = string
    name                   = string
    desired_count          = number
  }))
}

variable "ecr_repositories" {
  type = list(string)
}