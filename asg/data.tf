data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = "path/to/my/key"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = "path/to/my/db"
    region = "us-east-2"
  }
}
