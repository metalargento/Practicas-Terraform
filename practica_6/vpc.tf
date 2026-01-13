resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
   tags = var.tags

}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true
   tags = {
    Name = "Public Subnet"
   }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
   tags = {
    Name = "Private Subnet"
   }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id
   tags = {
    Name = "igw vpcv virginia"
   }
}

# tabla de enrutamiento publica
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

   tags = {
    Name = "public crt"
   }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
  
}
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.sg_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # semantically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Instance SG"
  }
  
}
# asociacion de la tabla de enrutamiento publica con el subnet publico
# resource "aws_route_table_association" "crta_public_subnet" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_crt.id
# }

# resource "aws_security_group" "sg_public_instance" {
#   name        = "Public Instance SG"
#   description = "Allow SSH inbound traffic and all outbound traffic"
#   vpc_id      = aws_vpc.vpc_virginia.id

#   tags = {
#     Name = "allow_tls"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.sg_public_instance.id
#   cidr_ipv4         = var.sg_ingress_cidr
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }


# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.sg_public_instance.id
#   cidr_ipv4         = ["0.0.0.0/0"]
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }


# resource "aws_vpc" "vpc_ohio" {
#   cidr_block = var.vpc_ohio_cidr
#    tags = var.tags
#     provider = aws.vpc_ohio
# }

# variable "vpc_virginia_cidr" {
#   description = "CIDR block for Virginia VPC"
#   type        = string
#   default     = "10.10.0.0/16"
# }

# variable "vpc_ohio_cidr" {
#   description = "CIDR block for Ohio VPC"
#   type        = string
#   default     = "10.20.0.0/16" 
# }

# variable "tags" {
#   description = "Tags to apply to resources"
#   type        = map(string)
#   default = {
#     Name = "My_VPC"
#     env  = "Dev"
#   }
  
# }