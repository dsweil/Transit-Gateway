//1. create the vpc
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.231.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Prod VPC"
  }
}

//2.Create subnet put your AZ here

variable "vpc_availability_zoneProd" {
  type        = list(string)
  description = "Availability zone"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

resource "aws_subnet" "public_subnetProd" {
  vpc_id            = aws_vpc.prod_vpc.id
  count             = length(var.vpc_availability_zoneProd)
  cidr_block        = cidrsubnet(aws_vpc.prod_vpc.cidr_block, 8, count.index + 1)
  availability_zone = element(var.vpc_availability_zoneProd, count.index)
  tags = {
    Name = "Custom Public Subnet${count.index + 1}",
  }
}

resource "aws_subnet" "private_subnetProd" {
  vpc_id            = aws_vpc.prod_vpc.id
  count             = length(var.vpc_availability_zoneProd)
  cidr_block        = cidrsubnet(aws_vpc.prod_vpc.cidr_block, 8, count.index + 11)
  availability_zone = element(var.vpc_availability_zoneProd, count.index)
  tags = {
    Name = "Custom Private Subnet${count.index + 1}",
  }
}

//3. Create internet gateway and attach it to the vpc

resource "aws_internet_gateway" "pinternet_gatewayProd" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "Custom Internet Gateway",
  }
}

//4. RT for the public subnet
resource "aws_route_table" "custom_route_table_public_subnetProd" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pinternet_gatewayProd.id
  }
    route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.example.id
  }

  tags = {
    Name = "Route Table for Public Subnet",
  }

}


//5. Association between RT and IG
resource "aws_route_table_association" "public_subnetProd_associationProd" {
  route_table_id = aws_route_table.custom_route_table_public_subnetProd.id
  count          = length((var.vpc_availability_zoneProd))
  subnet_id      = element(aws_subnet.public_subnetProd[*].id, count.index)
}





//8. RT for private Subnet
resource "aws_route_table" "custom_route_table_private_subnetProd" {
  vpc_id = aws_vpc.prod_vpc.id




  tags = {
    Name = "Route Table for Private Subnet",
  }


}

//9. RT Association Private
resource "aws_route_table_association" "private_subnetProd_association" {
  route_table_id = aws_route_table.custom_route_table_private_subnetProd.id
  count          = length((var.vpc_availability_zoneProd))
  subnet_id      = element(aws_subnet.private_subnetProd[*].id, count.index)
}

resource "aws_instance" "windows_instance" {
  ami             = "ami-0324a83b82023f0b3"
  instance_type   = "t2.medium"
  security_groups = [aws_security_group.ec2_sgW.id]
  subnet_id       = aws_subnet.public_subnetProd[0].id
  associate_public_ip_address = true
  key_name      = "win"
 

}
variable "win-pair" {
  description = "Value of AWS SSH key-pair name"
  type        = string
  default     = "win"
}
resource "tls_private_key" "win" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "win-pair" {
  key_name = "win"
 public_key = tls_private_key.win.public_key_openssh
}
output "instance_public_key" {
  description = "Public key of oe-key-pair"
  value       = tls_private_key.win.public_key_openssh
  sensitive   = true
}
output "instance_private_key" {
  description = "Private key of oe-key-pair"
  value       =  tls_private_key.win.private_key_pem
  sensitive   = true
}
// use the following command to generate the keys
//terraform output -raw instnacce_private_key
//terraform output -raw instnacce_public_key