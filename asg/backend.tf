terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.my_bucket
    key            = "terraform/statefile.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}