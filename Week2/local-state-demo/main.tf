provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "state_test" {
  bucket = "abinshihab-terraform-state-test"  
  force_destroy = true


}

