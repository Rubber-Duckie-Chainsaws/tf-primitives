variable "name" {
  type = string
  description = "The name of the repo"
}
variable "description" {
  type = string
  description = "Desciption of what the repo should be used for"
}
variable "visibility" {
  default = "private"

  validation {
    condition = contains(["public", "private", "internal"], var.visibility)
    error_message = "Must be public, private, or internal (for enterprise)"
  }
}

variable "gitignore_template" {
  default = null
  type = string

# TODO: Add validation rules, the list is kinda massive though
#  validation {
#    condition = contains([""], var.gitignore_template)
#    error_message = ""
#  }
}
variable "license_template" {
  default = null
  type = string

# TODO: Add validation rules, the list is kinda massive though
#  validation {
#    condition = contains([], var.license_template)
#    error_message = ""
#  }
}
variable "topics" {
  default = []
}

variable "has_discussions" {
  default = false
}
variable "has_issues" {
  default = false
}
variable "has_projects" {
  default = false
}
variable "has_wiki" {
  default = false
}

variable "allow_merge" {
  default = true
}
variable "allow_rebase" {
  default = true
}
variable "allow_squash" {
  default = true
}
variable "allow_auto_merge" {
  default = false
}
variable "delete_branch" {
  default = true
}

variable "archive_on_destroy" {
  default = true
}
