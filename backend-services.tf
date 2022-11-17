resource "aws_db_subnet_group" "nitesh-rds-subgroup" {
  subnet_ids = module.vpc.private_subnets
  name       = "main"
  tags = {
    Name    = "Subnet group for RDS"
    Project = var.projectName
  }
}

resource "aws_elasticache_subnet_group" "nitesh-ecache-subgroup" {
  name       = "nitesh-ecache-subgroup"
  subnet_ids = module.vpc.private_subnets
  tags = {
    Name    = "Subnet group for ElastiCache"
    Project = var.projectName
  }
}

resource "aws_db_instance" "nitesh-rds" {
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.33"
  username               = var.dbuser
  password               = var.dbpass
  db_name                = var.dbname
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.nitesh-rds-subgroup.name
  vpc_security_group_ids = [aws_security_group.nitesh-backend-sg.id]
}

resource "aws_elasticache_cluster" "nitesh-ecache" {
  cluster_id           = "nitesh-ecache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.nitesh-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.nitesh-ecache-subgroup.name
}

resource "aws_mq_broker" "nitesh-rmq" {
  broker_name        = "nitesh-rmq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.nitesh-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    password = var.rmqpass
    username = var.rmquser
  }
}