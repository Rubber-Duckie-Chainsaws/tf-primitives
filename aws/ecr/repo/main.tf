locals {
  policy = var.policy != "" ? var.policy : data.local_file.default_policy.content
}

data "local_file" "default_policy" {
  filename = "${path.module}/policy.json"
}

resource "aws_ecr_repository" "this" {
  name = var.name

  image_tag_mutability = var.image_tag_mutability
  tags = var.tags

  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = local.policy
}
