terraform {
  backend "s3" {
    bucket         = "dev-s3-backend-bucket"
    key            = "envs/stage/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
