resource "aws_launch_template" "frontend" {
  name_prefix   = "frontend-template-"
  image_id      = "ami-0f5ee92e2d63afc18" 
  instance_type = "t3.micro"
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.frontend_sg_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "project4-frontend"
    }
  }
}

resource "aws_lb" "frontend_alb" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.frontend_sg_id]
  subnets            = var.public_subnets
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_autoscaling_group" "frontend_asg" {
  name_prefix         = "frontend-asg-"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = var.public_subnets

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.frontend_tg.arn]

  tag {
    key                 = "Name"
    value               = "project4-frontend"
    propagate_at_launch = true
  }
}
