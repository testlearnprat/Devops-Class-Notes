provider "aws" {
  region = "ap-south-1"
}

data "aws_instance" "data-instance" {
  instance_tags = {
    "Name" = "data-source-example"
  }
}

output "instance-id" {
  value = data.aws_instance.data-instance.id
}

output "public-ip" {
  value = data.aws_instance.data-instance.public_ip
}

output "private-ip" {
  value = data.aws_instance.data-instance.private_ip
}