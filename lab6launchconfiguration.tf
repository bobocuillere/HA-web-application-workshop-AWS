resource "aws_security_group" "WPWordpressSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_wordpress

  ingress {
    description = "HTTP rule"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"

    security_groups = [aws_security_group.WPLoadBalancerSG.id]
  }
  ingress {
    description = "HTTPS rule"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"

    security_groups = [aws_security_group.WPLoadBalancerSG.id]
  }

  egress {
    from_port = var.http_port
    to_port   = var.http_port
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = var.https_port
    to_port   = var.https_port
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "WP Wordpress SG"
  }
}
data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")
  vars = {
    EFS_MOUNT   = aws_efs_mount_target.fs-mount-target[0].dns_name
    DB_NAME     = aws_rds_cluster.rds-cluster.database_name
    DB_HOSTNAME = aws_rds_cluster.rds-cluster.endpoint
    DB_USERNAME = aws_rds_cluster.rds-cluster.master_username
    DB_PASSWORD = aws_rds_cluster.rds-cluster.master_password
    LB_HOSTNAME = aws_lb.lb.dns_name
  }
}

resource "aws_launch_configuration" "launch-conf" {
  name_prefix     = var.launch_configuration_prefix
  image_id        = var.linux_ami
  instance_type   = var.ec2_instance_type
  security_groups = [aws_security_group.WPDatabaseClientSG.id, aws_security_group.WPFSClientSG.id, aws_security_group.WPWordpressSG.id, aws_security_group.WPCacheClientSG.id]
  #key_name        = "HaWorkshop"
  user_data = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }


}
