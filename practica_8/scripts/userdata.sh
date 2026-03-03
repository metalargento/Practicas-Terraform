#!/bin/bash
echo "Este es un mensaje" > ~/mensaje.txt
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd