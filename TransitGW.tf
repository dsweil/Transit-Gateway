resource "aws_ec2_transit_gateway" "example" {
  description = "example"
 
  tags = {
    Name = "example"
  }
}
resource "aws_ec2_transit_gateway_route_table" "example" {
  transit_gateway_id = aws_ec2_transit_gateway.example.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "devexample" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.dev_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.example.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "prodexample" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.prod_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.example.id
}
resource "aws_ec2_transit_gateway_route_table_propagation" "testexample" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.test_vpc_attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.example.id
}