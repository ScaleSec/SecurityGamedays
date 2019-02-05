resource "aws_vpc" "main" {
  cidr_block = "10.42.0.0/16"
  tags = {
    Name = "tmp_dpg_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "tmp_dpg_igw"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "tmp_dpg_rt"
  }
}

# Create one subnets for each provided AZ
resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.42.${count.index}.0/24"
  availability_zone = "${var.region}${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "tmp_dpg_subnet_${count.index}"
  }
  count = "${length(var.availability_zones)}"
}

resource "aws_route_table_association" "assoc" {
  subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.r.id}"
  count          = "${length(var.availability_zones)}"
}

resource "aws_security_group" "dpg" {
  name        = "tmp_dpg_sg"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
