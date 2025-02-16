resource "aws_instance" "wordpress" {
  ami           = "data.aws_ami.image.id"  # Use the latest Amazon Linux AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  security_groups = [aws_security_group.ec2_sg.id]

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

