//1. creat the vpc
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.230.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Dev VPC"
  }
}

//2.Create subnet put your AZ here

variable "vpc_availability_zone" {
  type        = list(string)
  description = "Availability zone"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}



resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  count             = length(var.vpc_availability_zone)
  cidr_block        = cidrsubnet(aws_vpc.dev_vpc.cidr_block, 8, count.index + 11)
  availability_zone = element(var.vpc_availability_zone, count.index)
  tags = {
    Name = "Custom Private Subnet${count.index + 1}",
  }
}

//3. Create internet gateway and attach it to the vpc

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "Custom Internet Gateway",
  }
}




//8. RT for private Subnet
resource "aws_route_table" "custom_route_table_private_subnet" {

  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.example.id
  }
 

  tags = {
    Name = "Route Table for Private Subnet",
  }


}



//9. RT Association Private
resource "aws_route_table_association" "private_subnet_association" {
  route_table_id = aws_route_table.custom_route_table_private_subnet.id
  count          = length((var.vpc_availability_zone))
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
}

resource "aws_instance" "Linux_instance" {
  ami             = "ami-06b21ccaeff8cd686"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ec2_sg.id]
  subnet_id       = aws_subnet.private_subnet[0].id
  


}
