terraform {
  backend "s3" {
    # Your S3 bucket for storing Terraform state
    bucket = "cc8weeks-terraform-state"

    # Environment-specific state path (keeps dev/stage/prod isolated)
    #key    = "state/${var.env}/terraform.tfstate"

    # AWS region of your bucket
    region = "us-east-1"

    # ⚙️ Optional cost-related settings
    # encrypt        = true             # Disable for lab use to avoid unnecessary features
    # dynamodb_table = "terraform-locks" # Skip locking for now to save cost
  }
}

