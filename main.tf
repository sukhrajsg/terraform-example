// Provider configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.26"
    }
  }
  backend "s3" {
    bucket         = "EXAMPLE"
    key            = "state/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "EXAMPLE"
  }

}

provider "aws" {
  region = "eu-west-2"
}

