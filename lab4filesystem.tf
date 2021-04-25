resource "aws_security_group" "WPFSClientSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_fs_client

  tags = {
    Name = "WP FS Client SG"
  }
}

resource "aws_security_group" "WP-FS-SG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_fs
  ingress {
    description = "NFS rule"
    from_port   = var.fs_port
    to_port     = var.fs_port
    protocol    = "tcp"

    security_groups = [aws_security_group.WPFSClientSG.id]

  }

  egress {
    from_port = var.fs_port
    to_port   = var.fs_port
    protocol  = "tcp"

    security_groups = [aws_security_group.WPFSClientSG.id]
  }


  tags = {
    Name = "WP FS SG"
  }
}

resource "aws_efs_file_system" "FS" {
  creation_token = var.creation_token

  tags = {
    Name = "File System"
  }
}

resource "aws_efs_mount_target" "fs-mount-target" {
  count           = length(var.azs)
  file_system_id  = aws_efs_file_system.FS.id
  subnet_id       = aws_subnet.Application-Subnets[count.index].id
  security_groups = [aws_security_group.WP-FS-SG.id]
}


