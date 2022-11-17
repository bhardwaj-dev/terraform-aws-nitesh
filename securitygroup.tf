resource "aws_security_group" "nitesh-bean-elb-sg" {
  name        = "nitesh-bean-elb-sg"
  description = "security group for bean-elb"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "nitesh-bastion-sg" {
  name        = "nitesh-bastion-sg"
  description = "security group for bastion server"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.myIP]
  }
}

resource "aws_security_group" "nitesh-prod-sg" {
  name        = "nitesh-prod-sg"
  description = "security group for beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.nitesh-bastion-sg.id]
  }
}

resource "aws_security_group" "nitesh-backend-sg" {
  name        = "nitesh-backend-sg"
  description = "security group for RDS, active mq, elastic cache"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    protocol        = "-1"
    to_port         = 0
    security_groups = [aws_security_group.nitesh-prod-sg.id]
  }
}

resource "aws_security_group_rule" "sec_group_rule_allow_itself" {
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nitesh-backend-sg.id
  to_port                  = 65535
  type                     = "ingress"
  source_security_group_id = aws_security_group.nitesh-backend-sg.id
}
