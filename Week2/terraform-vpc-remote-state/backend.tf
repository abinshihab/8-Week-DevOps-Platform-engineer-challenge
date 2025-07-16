terraform {
  backend "s3" {
    bucket         = "Dev-s3-backend-bucket"
    key            = "terraform/state/week2/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
