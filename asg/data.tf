data "aws_availability_zones" "av-azs" {
  state = "available"
}
data "aws_availability_zones" "all" {}

output "AZ" {
  value = data.aws_availability_zones.all.names
}




data "aws_ami" "image" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
 
  owners = ["amazon"] # Canonical
}

output "AMI_ID" {
  value = data.aws_ami.image.id
}
