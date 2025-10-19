terraform {
  backend "s3" {
    bucket = "tfstate-thaim-sandbox"
    key    = "sample-terraform-aws/gh-actions-tfcmt"
    region = "ap-northeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
