virginia_cidr = "10.10.0.0/16"
# public_subnet = "10.10.1.0/24"
# private_subnet = "10.10.2.0/24"

subnets = ["10.10.0.0/24","10.10.0.1/24"]

tags = {
  "env" = "desa"
  "owner" = "Aliaga"
  "clowd" = "aws"
  "IAC" = "terraform"
  "IAC_Version" = "v1.14.3"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t2.micro"
}