resource "aws_security_group" "WPCacheClientSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_cache_client

  tags = {
    Name = "WP Cache Client SG"
  }
}

resource "aws_security_group" "WPCacheSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_cache

  ingress {
    description = "Mem Cached Rule"
    from_port   = var.memcached_port
    to_port     = var.memcached_port
    protocol    = "tcp"

    security_groups = [aws_security_group.WPCacheClientSG.id]

  }
  egress {
    from_port = var.memcached_port
    to_port   = var.memcached_port
    protocol  = "tcp"

    security_groups = [aws_security_group.WPCacheClientSG.id]
  }


  tags = {
    Name = "WP Cache SG"
  }
}

resource "aws_elasticache_subnet_group" "memcached-subnet-group" {
  name       = var.elastic_memcached_subnet
  subnet_ids = [aws_subnet.Data-Subnets[1].id, aws_subnet.Data-Subnets[0].id]

}

resource "aws_elasticache_cluster" "memcached" {
  subnet_group_name    = aws_elasticache_subnet_group.memcached-subnet-group.id
  cluster_id           = var.cluster_id
  engine               = var.cluster_engine
  node_type            = var.memcached_node
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.memcached_parameter
  port                 = var.memcached_port
  security_group_ids   = [aws_security_group.WPCacheSG.id]

  tags = {
    "Name" = "Memcached Wordpress"
  }
}