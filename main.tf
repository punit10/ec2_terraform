#Terraform file to create basic EC2 instance
# to create amazon linux machine with user ec2-user
data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Nginx security group 
resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  vpc_id      = var.aws_vpc_id
  description = "Allow SSH and Django port"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# INSTANCES #
# resource "aws_instance" "nginx1" {
#   ami                         = var.os_to_deploy == "ubuntu" ? var.ubuntu_ami : nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
#   instance_type               = "t2.micro"
#   subnet_id                   = var.aws_public_subnet_id
#   vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
#   key_name                    = var.keypair
#   associate_public_ip_address = true

#   provisioner "file" {
#     source      = local.install_jenkins
#     destination = "/home/${local.OS_user}/${local.install_jenkins}"

#     connection {
#       type        = "ssh"
#       user        = local.OS_user
#       private_key = file("${path.module}/${var.keypair}.pem")
#       host        = self.public_ip
#     }
#   }
#   tags = {
#     Name = "Jenkins server"
#   }
# }

# INSTANCES #
resource "aws_instance" "docker_instance" {
  ami                         = var.os_to_deploy == "ubuntu" ? var.ubuntu_ami : nonsensitive(data.aws_ssm_parameter.amzn2_linux.value)
  instance_type               = "t2.micro"
  subnet_id                   = var.aws_public_subnet_id
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  key_name                    = var.keypair
  associate_public_ip_address = true

  tags = {
    Name = "Docker Server"
  }
}

# resource "aws_eip" "first_eip" {
#   instance = aws_instance.nginx1.id
#   domain   = "vpc"
# }

