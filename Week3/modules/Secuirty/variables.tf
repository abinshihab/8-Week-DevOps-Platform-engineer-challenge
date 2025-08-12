variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {}
}
