resource "aws_security_group" "linux_web_server" {
  name        = "linux_web_security_group"
  description = "Allow TLS inbound traffic"
  # vpc_id      = aws_vpc.main.id - #we can commenting because will be Default vpc-2472c659

# incoming traffic. HTTP,https,SSH,UNIX-systems access from anywhere"
  dynamic "ingress" {

    for_each = ["80","443","22","3000","9090"] #3000 for Unix system
    
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["46.242.14.150/32"] #--0.0.0.0/0 from anyway internet
    }
  }

  egress { # rules for out traffic from server
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # mean all of port and protocol
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Linux Serv SG"    # Name of Security Group because it in this resourse
  }
}