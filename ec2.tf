# creating two instances 

resource "aws_instance" "test-instance1" {
    ami = "ami-097a2df4ac947655f"
    instance_type = "t2.micro"
    key_name = "test-key"
    subnet_id = aws_subnet.testsubnet-1.id
    security_groups = [aws_security_group.test-sg.id]
    associate_public_ip_address = true
    user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF 
  tags = {
    "Name" = "test-instance1"
  }
}


#second instance
resource "aws_instance" "test-instance2" {
    ami = "ami-097a2df4ac947655f"
    instance_type = "t2.micro"
    key_name = "test-key"
    subnet_id = aws_subnet.testsubnet-2.id
    security_groups = [aws_security_group.test-sg.id]
    associate_public_ip_address = true
    user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed "
  EOF 
  tags = {
    "Name" = "test-instance2"
  }
}


