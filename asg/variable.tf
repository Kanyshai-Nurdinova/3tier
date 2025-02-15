variable "region" {
    description = "AWS region"
    default = "us-east-2"
}

variable "instancetype" {
     default = "t3.micro"
}


variable "state_bucket" {
   default  = "3tier-app-oct24"
}