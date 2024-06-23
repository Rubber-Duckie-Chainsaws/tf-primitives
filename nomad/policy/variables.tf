variable "name" {
  type        = string
  description = "The short name for the policy"
}

variable "description" {
  type        = string
  description = "The short description for what the policy does"
}

variable "group" {
  default     = null
  description = "The group ID this ACL applies to"
}

variable "job_id" {
  default     = null
  description = "The job ID this ACL applies to"
}

variable "namespace" {
  type        = string
  default     = "default"
  description = "The namespace that the ACL should apply too"
}

variable "rules_hcl" {}

variable "task" {
  default = null
  description = "The task ID this ACL applies to"
}
