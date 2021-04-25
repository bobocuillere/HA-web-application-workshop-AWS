# Security Groups
resource "aws_security_group" "WPDatabaseClientSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_database_client

  tags = {
    Name = "WPDatabaseClientSG"
  }
}

resource "aws_security_group" "WPDatabaseSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_database

  ingress {
    description = "MySQL / Aurora"
    from_port   = var.aurora_port
    to_port     = var.aurora_port
    protocol    = "tcp"

    security_groups = [aws_security_group.WPDatabaseClientSG.id]

  }
  egress {
    from_port       = var.aurora_port
    to_port         = var.aurora_port
    protocol        = "tcp"
    security_groups = [aws_security_group.WPDatabaseClientSG.id]

  }

  tags = {
    Name = "WPDatabaseSG"
  }
}

# DB subnet group
resource "aws_db_subnet_group" "dbSubnetGroup" {


  name        = var.db_subnet_group
  description = "RDS subnet group used by Wordpress"
  subnet_ids  = [aws_subnet.Data-Subnets[0].id, aws_subnet.Data-Subnets[1].id]


  tags = {
    Name = "Aurora-Wordpress"
  }
}
# Aurora RDS cluster mySql
resource "aws_rds_cluster" "rds-cluster" {
  cluster_identifier     = var.cluster_identifier
  engine                 = var.engine
  engine_version         = var.engine_version_rds
  database_name          = var.database_name
  db_subnet_group_name   = aws_db_subnet_group.dbSubnetGroup.name
  availability_zones     = [var.azs[0], var.azs[1]]
  master_username        = var.dbuser
  master_password        = var.dbpass
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.WPDatabaseSG.id]

  tags = {
    "Name" = "WORDPRESS CLUSTER RDS"
  }
}
#RDS Cluster Instance
resource "aws_rds_cluster_instance" "rds-instances" {
  count = 2

  identifier           = "database-1-instance-${count.index + 1}"
  db_subnet_group_name = aws_db_subnet_group.dbSubnetGroup.name
  cluster_identifier   = aws_rds_cluster.rds-cluster.id
  instance_class       = var.rds_instance_class
  engine               = aws_rds_cluster.rds-cluster.engine
  engine_version       = aws_rds_cluster.rds-cluster.engine_version

} 