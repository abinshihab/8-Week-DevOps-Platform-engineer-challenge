terraform {
  backend "s3" {
    bucket         = "abinshihab-my-tf-state-dev-us-east-1"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "abinshihab-my-tf-locks-dev"
    encrypt        = true
  }
}
