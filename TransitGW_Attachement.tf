# Attach PROD_VPC to the Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "prod_vpc_attachment" {
  # ID of the Transit Gateway
  transit_gateway_id = aws_ec2_transit_gateway.example.id
  subnet_ids         = aws_subnet.public_subnetProd[*].id # Reference the created subnet ID

  # VPC ID to be attached
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "prod_vpc"
  }
}
# Attach DEV_VPC to the Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "dev_vpc_attachment" {
  # ID of the Transit Gateway
  transit_gateway_id = aws_ec2_transit_gateway.example.id
  subnet_ids         = aws_subnet.private_subnet[*].id # Reference the created subnet ID

  # VPC ID to be attached
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev_vpc"
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "test_vpc_attachment" {
  # ID of the Transit Gateway
  transit_gateway_id = aws_ec2_transit_gateway.example.id
  subnet_ids         = aws_subnet.private_subnettest[*].id # Reference the created subnet ID

  # VPC ID to be attached
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_vpc"
  }
}
