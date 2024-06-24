resource "github_repository" "example" {
  name = var.name
  description = var.description
  visibility = var.visibility

  has_issues      = var.has_issues
  has_discussions = var.has_discussions
  has_projects    = var.has_projects
  has_wiki        = var.has_wiki

  allow_merge_commit = var.allow_merge
  allow_squash_merge = var.allow_squash
  allow_rebase_merge = var.allow_rebase
  allow_auto_merge   = var.allow_auto_merge

  delete_branch_on_merge = var.delete_branch

  gitignore_template = var.gitignore_template
  license_template = var.license_template

  archive_on_destroy = var.archive_on_destroy

  topics = var.topics

  #TODO: Templates, eventually, for project golden path
  #template
  #is_template
}
