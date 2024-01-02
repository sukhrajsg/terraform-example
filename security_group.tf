// Security group 
# locked down to allow devs with certain IPs only

resource "aws_security_group" "allow_ssh" {
  name        = "Allow EXAMPLE only"
  description = "Allow ssh inbound traffic for devs"
  vpc_id      = "EXAMPLE"

  ingress { # Allow only certain IP addresses for inbound traffic with ssh
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["EXAMPLE"]
  }

  egress { # Allow all outband - don't need/want to lock this down
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}
