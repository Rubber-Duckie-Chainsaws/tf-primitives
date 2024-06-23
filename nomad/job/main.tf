resource "nomad_job" "this" {
  jobspec = var.jobspec
}

variable "jobspec" {}
