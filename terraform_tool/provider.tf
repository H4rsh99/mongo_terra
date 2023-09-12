terraform {
  backend "s3" {
    bucket = "ot-mohit-1"
    dynamodb_table = "state-lock"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    
  }
}

provider "aws" {
  region = "us-east-1"
}
