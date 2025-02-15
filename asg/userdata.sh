#!/bin/bash
sudo apt-get install apache2 -y
sudo systemctl start apache2 
sudo systemctl enable apache2 

sudo yum update -y
sudo yum install -y httpd php php-mysqlnd
sudo systemctl start httpd
sudo systemctl enable httpd