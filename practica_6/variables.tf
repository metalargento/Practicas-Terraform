variable "virginia_cidr" {
    description = "CIDR block for Virginia VPC"
    type        = string
}

variable "subnets" {
  description = "Lista de subnets"
  type = string
}
# variable "public_subnet" {
#     description = "CIDR public subnet"
#     type        = string
  
# }

# variable "private_subnet" {
#     description = "CIDR private subnet"
#     type        = string
  
# }

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    name = "My_VPC"
    env  = "Dev"
  }
  
}

variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string
  
}

variable "ec2_specs" {
  description = "Specifications for EC2 instance"
  type = map(string)

}
  