variable "name" {}
variable "vpc_id" {}
variable "cidr_block" {}
variable "ipv6_cidr_block" {
  type     = string
  nullable = true
}
variable "public" {
  type = bool
  default = false
}
