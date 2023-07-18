terraform {
  cloud {
    organization = "taj-20230326"

    workspaces {
      name = "ecs-cluster"
    }
  }
}
