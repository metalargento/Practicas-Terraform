output "ec2_public_ip" {
  description = "ip publica de la instancia EC2"
  value       = aws_instance.public_instance.public_ip
  
}