resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.vpc_virginia_cidr
   tags = var.tags

}

resource "aws_vpc" "vpc_ohio" {
  cidr_block = var.vpc_ohio_cidr
   tags = var.tags
    provider = aws.vpc_ohio
}

variable "vpc_virginia_cidr" {
  description = "CIDR block for Virginia VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "vpc_ohio_cidr" {
  description = "CIDR block for Ohio VPC"
  type        = string
  default     = "10.20.0.0/16" 
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Name = "My_VPC"
    env  = "Dev"
  }
  
}