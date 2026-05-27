resource "aws_lb" "threatcomposer_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  drop_invalid_header_fields = true

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "threatcomposer_alb_tg" {
  name        = "${var.alb_name}-tg"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/health.json"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = "30"
    timeout             = "5"
    healthy_threshold   = "2"
    unhealthy_threshold = "3"
  }
}

resource "aws_lb_listener" "threatcomposer_alb_listener" {
  load_balancer_arn = aws_lb.threatcomposer_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "threatcomposer_alb_https_listener" {
  load_balancer_arn = aws_lb.threatcomposer_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.threatcomposer_alb_tg.arn
  }
}