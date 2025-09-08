resource "aws_launch_template" "backend" {
  name_prefix   = "backend-template-"
  image_id      = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.backend_sg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "project4-backend"
    }
  }
}

resource "aws_lb" "backend_alb" {
  name               = "backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.backend_sg_id]  
  subnets            = var.private_subnets 
}


resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

resource "aws_autoscaling_group" "backend_asg" {
  name_prefix         = "backend-asg-"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = var.private_subnets

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.backend_tg.arn]

  tag {
    key                 = "Name"
    value               = "project4-backend"
    propagate_at_launch = true
  }
}
