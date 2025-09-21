variable "project" {
  description = "Project name"
  type        = string
}
variable "environment" {}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "private_subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "engine" {
  default = "mysql"
}
variable "engine_version" {
  default = "8.0"
}
variable "instance_class" {
  default = "db.t3.medium"
}

variable "allocated_storage" {
  default = 20
}
variable "max_allocated_storage" {
  default = 100
}

variable "username" {}
variable "password" {
  sensitive = true
}

variable "backup_retention_period" {
  default = 7
}

