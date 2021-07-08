

provider "aws" {
  region = "us-west-1"
}


resource "aws_instance" "demoinstance" {
  ami = "ami-0ad42f4f66f6c1cc9"
  instance_type = "t2.micro"
  key_name = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  user_data = <<-EOF
             #!/bin/bash
             sudo yum install httpd -y
             service httpd restart
             echo "Hello, World" > /var/www/html/index.html  
             EOF

  tags {
    Name = "terraform-example"
  }
}


resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Inbound HTTP from anywhere
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

