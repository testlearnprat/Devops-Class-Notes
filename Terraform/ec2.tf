provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "terraform-instance" {
  ami = "ami-062df10d14676e201"
  instance_type = "t2.micro"
  key_name = "oct-2022"
  tags = {
    Name = "My-ec2-Instance"
  }
  availability_zone = "ap-south-1a"
}
