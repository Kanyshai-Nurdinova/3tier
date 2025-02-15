terraform {
  backend "s3" {
    bucket         = "3tier-app-oct24"
    key            = "terraform/statefile.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}