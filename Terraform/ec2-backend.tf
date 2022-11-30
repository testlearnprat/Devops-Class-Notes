terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "s3bucket-for-backend-123987"
    region = "ap-south-1"
    key = "terraform/backend/terraform.tfstate"

    dynamodb_table = "dynamodb-for-backend" 
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "terraform-instance" {
  ami                    = "ami-062df10d14676e201"
  instance_type          = "t2.micro"
  key_name               = "oct-2022"
  tags = {
    Name = "Terraform-Instance"
  }
}