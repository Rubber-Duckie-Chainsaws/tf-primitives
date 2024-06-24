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

variable "policy" {
  default = ""
  description = "Lifecycle policy to apply to ecr repo"
}

variable "tags" {
  default = {}
  description = "Tags to add to ecr repo"
}
