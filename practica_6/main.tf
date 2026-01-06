data "aws_region" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket"
  
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  
  tags = {
    Name = "webserver"
    Environment = "local"
  }
}

resource "aws_route53_zone" "primary" {
   name = "devops.sh"
  
}

resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.primary.id
  name    = "devops.sh"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]
}

