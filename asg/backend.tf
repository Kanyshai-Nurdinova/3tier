terraform {
  backend "s3" {
    bucket         = "3tier-app-oct2024"
    key            = "terraform/statefile.tfstate"
    region         = "us-east-2"
    encrypt        = true
    
  }
}