resource "aws_instance" "public_instance" {
  ami           = "ami-068c0051b15cdb816" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data = <<EOF
              #!/bin/bash
              echo "este es un mensaje" > ~/mensaje.txt
              EOF

  provisioner "local-exec" {
    command = "echo instancia creada con IP ${aws_instance.public_instance.public_ip} > datos_instancia.txt"
  }

  provisioner "local-exec" {
    when = destroy
    command = "echo instancia ${self.public_ip} destruida >> datos_instancia.txt"
  }

#   provisioner "remote-exec" {
#     inline = [
#       "echo'hola mundo' > ~/hola_mundo.txt"
#     ]

#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       private_key = file("mykey.pem")
#       host        = self.public_ip
#     }
    
#   }
#   tags = {
#     Name = "Public_Instance"
#   }
  
}