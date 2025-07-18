provider "aws" {
  region = "us-east-1" # or your region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "dev-s3-backend-bucket"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform Remote State Bucket"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = "Dev"
  }
}
