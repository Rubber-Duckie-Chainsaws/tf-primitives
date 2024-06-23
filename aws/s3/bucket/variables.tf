variable "name" {
  description = "The name of the bucket (do not include namespace/prefix)"
}

variable "prefix" {
  description = "Prefix to put before name <prefix>-<name>-<uuid>"
  default     = "rdc"
}

variable "tags" {
  description = "Additional tags to apply to s3 bucket"
  default = {}
}
