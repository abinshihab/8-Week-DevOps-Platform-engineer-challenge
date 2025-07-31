variable "ami_id" {}
variable "instance_type" {}
variable "user_data_path" {}
variable "private_subnet_ids" { type = list(string) }
variable "sg_id" {}
variable "target_group_arn" {}
variable "environment" {}
variable "tags" { default = {} }
