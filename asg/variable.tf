variable "region" {
    description = "AWS region"
    default = "us-east-2"
}

variable "instancetype" {
     default = "t2.micro"
}


variable "state_bucket" {
   default  = "3tier-app-oct24"
}


variable "my_zone"{
  default = "octdevops.click"
}

variable "identifier"{
  default = "static-member-1"

}
variable "engine"{
  default = "aurora-mysql"

}
variable "engine_version"{
  default = "8.0.mysql_aurora.3.04.0"

}
variable "database_name"{
  default = "db"

}
variable "db_username"{
  default = "master"

}


variable "instance_class" {
  default = "db.r6g.large"
}




variable "writer_name"{
   default = "writer"
}
variable "reader1_name"{
   default = "reader1"
}
variable "reader2_name"{
   default = "reader2"
}
variable "reader3_name"{
   default = "reader3"
}
