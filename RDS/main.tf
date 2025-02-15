resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  database_name          = var.database_name
  master_username        = var.db_username
  master_password        = random_password.password.result
  skip_final_snapshot    = true
  backup_retention_period = 7
}

# Writer instance
resource "aws_rds_cluster_instance" "writer" {
  identifier         = "aurora-writer"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.instance_class
  engine            = aws_rds_cluster.aurora_cluster.engine
  engine_version    = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true
}

# Reader instances
resource "aws_rds_cluster_instance" "reader1" {
  identifier         = "aurora-reader1"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.instance_class
  engine            = aws_rds_cluster.aurora_cluster.engine
  engine_version    = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true
}

resource "aws_rds_cluster_instance" "reader2" {
  identifier         = "aurora-reader2"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.instance_class
  engine            = aws_rds_cluster.aurora_cluster.engine
  engine_version    = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true
}

resource "aws_rds_cluster_instance" "reader3" {
  identifier         = "aurora-reader3"
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.instance_class
  engine            = aws_rds_cluster.aurora_cluster.engine
  engine_version    = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = true
}

resource "random_password" "password" {
  length  = 16
  special = false
}