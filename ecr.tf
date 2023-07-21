resource "aws_ecr_repository" "this" {
  for_each             = { for index, repository in var.ecr_repositories : repository.name => repository }
  name                 = each.value.name
  force_delete         = false
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}
