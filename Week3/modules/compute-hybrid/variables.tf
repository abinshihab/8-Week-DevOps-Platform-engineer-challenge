variable "environment" {}
variable "deployment_mode" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "user_data" {
  type = string
}
