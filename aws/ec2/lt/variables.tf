variable "name" {}
variable "env" {}

variable "class" {}

variable "instance_type" {
  default = "t3a.small"
}

variable "vpc_security_group_ids" {
  type = list
}
variable "instance_profile" {}
variable "update_default_version" {}

variable "instance_initiated_shutdown_behavior" {
  type    = string
  default = "stop"
  validation {
    condition     = contains(["stop", "terminate"], var.instance_initiated_shutdown_behavior)
    error_message = "Shutdown behaviour only supports 'stop' or 'terminate'"
  }
}

variable "spot_instance_options" {
  default = []
}

variable "root_volume_size" {
  default = 16
}
