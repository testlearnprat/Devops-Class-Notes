provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "terraform-vpc"
  }
}

resource "aws_subnet" "terraform-public-subnet" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Terraform-public-subnet"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "Terraform-igw"
  }
}

resource "aws_route_table" "terraform-RT" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    Name = "Terraform-RT"
  }
}

resource "aws_route_table_association" "terraform-rt-association" {
  subnet_id      = aws_subnet.terraform-public-subnet.id
  route_table_id = aws_route_table.terraform-RT.id
}

resource "aws_security_group" "terraform-sg" {
  vpc_id = aws_vpc.terraform-vpc.id

  ingress {
    description      = "SSH Port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform-SG"
  }
}

resource "aws_instance" "terraform-instance" {
  subnet_id              = aws_subnet.terraform-public-subnet.id
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]
  ami                    = "ami-062df10d14676e201"
  instance_type          = "t2.micro"
  key_name               = "oct-2022"
  tags = {
    Name = "Terraform-EC2"
  }
}








