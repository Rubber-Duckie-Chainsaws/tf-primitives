locals {
  name = var.prefix != "" ? "${var.prefix}-${var.name}" : "${var.name}"
  tags = merge({
      Terraform = "true",
      Name      = local.name
    }, var.tags)
}

resource "aws_s3_bucket" "this" {
  bucket_prefix = "${local.name}-"
  force_destroy = true

  tags = local.tags
}
