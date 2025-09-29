############################################
# Provider Configuration
############################################
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

############################################
# S3 Bucket for Terraform State
############################################
resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
  tags = {
    Name = var.bucket_name
    Env  = "bootstrap"
  }

  force_destroy = true
}

############################################
# Enable Versioning for State File Safety
############################################
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

############################################
# DynamoDB Table for State Locking
############################################
resource "aws_dynamodb_table" "tf_locks" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = var.dynamodb_table
    Env  = "bootstrap"
  }
}
