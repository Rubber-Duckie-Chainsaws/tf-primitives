resource "aws_ecr_repository" "this" {
  name = var.name

  image_tag_mutability = var.image_tag_mutability
  tags = var.tags

  force_delete = true
}
