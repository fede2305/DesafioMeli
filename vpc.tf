# Defino VPC Infra1
resource "aws_vpc" "vpc-infraestructura-1" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Infraestructura-1"
  }
}

# Define the private subnet
resource "aws_subnet" "web-subnet" {
  vpc_id = "${aws_vpc.vpc-infraestructura-1.id}"
  cidr_block = "${var.private_web_cidr}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Web Services Private Subnet"
  }
}

resource "aws_subnet" "middleware-subnet" {
  vpc_id = "${aws_vpc.vpc-infraestructura-1.id}"
  cidr_block = "${var.private_middleware_cidr}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Middleware Private Subnet"
  }
}
resource "aws_subnet" "db-subnet" {
  vpc_id = "${aws_vpc.vpc-infraestructura-1.id}"
  cidr_block = "${var.private_db_cidr}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Database Private Subnet"
  }
}




# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc-infraestructura-1.id}"

  tags {
    Name = "VPC Inet-GW"
  }
}

# Define the route table
resource "aws_route_table" "infra-route-dw" {
  vpc_id = "${aws_vpc.vpc-infraestructura-1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public 0.0.0.0/0 - Ruta Default Gateway"
  }
}

# Asigno ruta Default a los subnets
resource "aws_route_table_association" "dw" {
  subnet_id = "${aws_subnet.web-subnet.id}"
  route_table_id = "${aws_route_table.infra-route-dw.id}"
}
resource "aws_route_table_association" "dw" {
  subnet_id = "${aws_subnet.middleware-subnet.id}"
  route_table_id = "${aws_route_table.infra-route-dw.id}"
}
resource "aws_route_table_association" "dw" {
  subnet_id = "${aws_subnet.db-subnet.id}"
  route_table_id = "${aws_route_table.infra-route-dw.id}"
}



# Defino  security groups
resource "aws_security_group" "sgweb" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & HTTPS access"
  vpc_id="${aws_vpc.vpn-infraestructura-1.id}"

# Politicas Inbound a web servers

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.private_web_cidr}"]
  }

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.private_web_cidr}"]  
}

# Politicas de salida a Internet

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["private_web_cidr"]
  }

   egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["private_middleware_cidr"]
  }

# No menciono el subnet de base de datos para que no tenga salida a internet

  tags {
    Name = "Web Server Inbound and Outbound Policy"
  }
}


#Interfaz con IP del subnet de Web server

resourse "aws_network_interface" "web-server-nic" {
 subnet_id   	 = aws_subnet.web-subnet.id
 private_ips 	 = ["10.0.0.50"]
 security_groups = [aws_seacurity_group.sgweb.id]

}

#Elastic IP para publicar server web

resource "aws_eip" "one"{
 vpc 			= true
 network_interface 	= aws_network_interface.web-server-nic.id
 associate_with_private_ip = "10.0.0.50"
 depends_on 		= aws_interet_gateway.gw
}


#Defino VPC Infra2

resource "aws_vpc" "vpc-infraestructura-2" {
  cidr_block = "${var.vpc2_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Infraestructura-2"
  }
}

# Define the private subnet
resource "aws_subnet" "infra2-subnet" {
  vpc_id = "${aws_vpc.vpc-infraestructura-2.id}"
  cidr_block = "${var.private_infra2_cidr}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Infra 2 Private Subnet"
  }
}


#VPC Peering
resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.vpc-infraestructura-1.id
  vpc_id        = aws_vpc.vpc-infraestructura-2.id
}

tags = {
	Name = "infra1-to-infra2"
}

