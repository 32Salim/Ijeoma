provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUVW3VNQ6BGHGKMV4"
  secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "queen001"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PublicSub"
  }
}

resource "aws_subnet" "mainb" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.16.0/20"

  tags = {
    Name = "PrivteSub"
  }
}

resource "aws_instance" "Instance" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main.id

  tags = {
    Name = "Safari"
  }
}

resource "aws_instance" "Instanceb" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.mainb.id

  tags = {
    Name = "Oasis"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "DemoGW"
  }
}