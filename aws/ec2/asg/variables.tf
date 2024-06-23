variable "name" {}

variable "desired_capacity" {
  default = 1
}

variable "max_size" {
  default = 5
}

variable "min_size" {
  default = 0
}

variable "max_instance_lifetime" {
  # TODO: Add validation (86400 - 31536000)
  default = 0
}

variable "mixed_instances" {
  default = []
}

variable "distribution_percentage" {
  default = 100
}

variable "launch_template_id" {}

variable "launch_template_version" {
  default = "$Default"
}

variable "vpc_zone_identifier" {
  type = list
}

variable "tags" {
  default = []
}
