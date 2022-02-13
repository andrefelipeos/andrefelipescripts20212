#!/bin/bash

# devem ser modificadas pelo script principal!
DBUSER=andre
DBPASSWORD=senha
IP_DBSERVER=172.31.83.25

amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum update -y
yum install -y httpd mariadb wget

systemctl start httpd.service
systemctl enable httpd.service

wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r ./wordpress/* /var/www/html/

systemctl restart httpd.service
