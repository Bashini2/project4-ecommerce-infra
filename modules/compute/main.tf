resource "aws_instance" "frontend" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.frontend_sg_id]
  key_name      = var.key_name

  tags = {
    Name = "${var.project}-frontend"
  }
}

resource "aws_instance" "backend" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"   
  subnet_id     = var.private_subnet_id
  vpc_security_group_ids = [var.backend_sg_id]
  key_name      = var.key_name

  tags = {
    Name = "${var.project}-backend"
  }
}

