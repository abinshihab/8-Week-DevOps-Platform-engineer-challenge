variable "aws_region" {
  type        = string
  description = "AWS region to deploy the backend"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform state"
}

variable "dynamodb_table" {
  type        = string
  description = "DynamoDB table name for state locking"
}
