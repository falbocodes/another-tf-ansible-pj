resource "aws_vpc" "another-tf-ansible-pj" {
  cidr_block = "10.43.0.0/16"
  tags = {
    Name = "another-tf-ansible-pj"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.another-tf-ansible-pj.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.another-tf-ansible-pj.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_subnet" "swarm_nodes" {
  cidr_block              = "10.43.3.0/24"
  vpc_id                  = aws_vpc.another-tf-ansible-pj.id
  map_public_ip_on_launch = true
}