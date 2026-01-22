resource "aws_ecs_cluster" "threatcomposer_ecs_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "threatcomposer_task_definition" {
  family                   = var.family_name
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_iam_role.arn
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

    }
    ]
  )
}

resource "aws_ecs_service" "threatcomposer_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.threatcomposer_ecs_cluster.id
  task_definition = aws_ecs_task_definition.threatcomposer_task_definition.arn
  desired_count   = var.desired_count

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = var.container_name
    container_port   = var.container_port

  }

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.ecs_security_group_id]
  }
  launch_type = var.launch_type
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_iam_role" {
  name = var.aws_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_iam_role.name
  policy_arn = var.policy_arn
}