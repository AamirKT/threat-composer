resource "aws_ecs_cluster" "threatcomposer_ecs_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "threatcomposer_task_definition" {
  family                   = "threatcomposer-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_iam_role.arn
  container_definitions = jsonencode([
    {
      name      = "threatcomposer-container"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]

    }
    ]
  )
}

resource "aws_ecs_service" "threatcomposer_ecs_service" {
  name            = "threatcomposer-ecs-service"
  cluster         = aws_ecs_cluster.threatcomposer_ecs_cluster.id
  task_definition = aws_ecs_task_definition.threatcomposer_task_definition.arn
  desired_count   = 2

  load_balancer {
    target_group_arn = var.alb_tg_arn
    container_name   = "threatcomposer-container"
    container_port   = 3000

  }

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [var.ecs_security_group_id]
  }
  launch_type = "FARGATE"
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_iam_role" {
  name = "threatcomposer-ecs-task-execution-role"
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
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}