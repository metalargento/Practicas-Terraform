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

  # ingress {
  #   description = "Allow SSH from specific CIDR block"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  #   ingress {
  #   description = "Allow HTTP from specific CIDR block"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  #   ingress {
  #   description = "Allow HTTPS from specific CIDR block"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

dynamic "ingress" {
  for_each = var.ingres_port_list
  content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = [var.sg_ingress_cidr]
  }
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # semantically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }
  
}

module "mybucket" {
  source = "./Modules/S3"
  bucket_name = "nombreunico12345678"
}

output "name" {
  value = module.mybucket.s3_bucket_arn
}

module "terraform_state_backend" {
     source = "cloudposse/tfstate-backend/aws"
     version     = "1.8.0"
     namespace  = "example"
     stage      = "env"
     name       = "terraform"
     environment = "us-east-1"
     attributes = ["state"]

     terraform_backend_config_file_path = "."
     terraform_backend_config_file_name = "backend.tf"
     force_destroy                      = false
   }