resource "aws_instance" "wordpress" {
  ami           = "ami-0c55b159cbfafe1f0" # Use the latest Amazon Linux AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-1.id
  security_groups = [aws_security_group.asg-sec-group.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable php8.0
              yum install -y httpd php php-mysqlnd
              systemctl start httpd
              systemctl enable httpd
              cd /var/www/html
              wget https://wordpress.org/latest.tar.gz
              tar -xzf latest.tar.gz
              cp -r wordpress/* .
              rm -rf wordpress latest.tar.gz
              chown -R apache:apache /var/www/html
              chmod -R 755 /var/www/html
              systemctl restart httpd
              EOF
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
