resource "aws_ecr_repository" "this" {
  #   for_each             = { for index, repository in var.ecr_repositories : repository.name => repository }
  count                = length(var.ecr_repositories) > 0 ? var.ecr_repositories : 0
  name                 = var.ecr_repositories[count.index]
  force_delete         = false
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
