terraform {
  required_version = "1.10.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.60.0, <= 5.76.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "fake"
  secret_key                  = "fake"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  # skip_get_ec2_platforms      = true

  endpoints {
    ec2             = "http://localhost:4566"
    route53         = "http://localhost:4566"
    route53resolver = "http://localhost:4566"
    s3              = "http://localhost:4566"
    s3control       = "http://localhost:4566"
  }

  default_tags {
    tags = {
      Environment = "Local"
      Service     = "LocalStack"
  }
 }
}

