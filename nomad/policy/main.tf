resource "nomad_acl_policy" "this" {
  count = var.rules_hcl != "" ? 1 : 0

  name        = var.name
  description = var.description

  rules_hcl = var.rules_hcl

  job_acl {
    namespace = var.namespace
    job_id    = var.job_id
    group     = var.group
    task      = var.task
  }
}
