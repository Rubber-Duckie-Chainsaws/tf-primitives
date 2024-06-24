variable "name" {
  description = "Name of ecr repo"
}

variable "image_tag_mutability" {
  description = "Whether or not tags can be pushed over once uploaded"

  validation {
    condition = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "Can only be MUTABLE or IMMUTABLE"
  }
}

variable "tags" {
  default = {}
  description = "Tags to add to ecr repo"
}
