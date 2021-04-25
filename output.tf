

output "LoadBalancer_DNS_OUTPUT" {
  value       = aws_lb.lb.dns_name
  description = "The load balancer DNS Name"
}

output "DataBase_Name_OUTPUT" {
  value       = aws_rds_cluster.rds-cluster.database_name
  description = "The DB name"
}

output "FileSystem_OUTPUT" {
  value       = aws_efs_mount_target.fs-mount-target[0].dns_name
  description = "File System endpoint"
}

output "DataBase_HOSTNAME_OUTPUT" {
  value       = aws_rds_cluster.rds-cluster.endpoint
  description = "The writer DB Instance"
}

output "DataBase_USERNAME_OUTPUT" {
  value       = aws_rds_cluster.rds-cluster.master_username
  description = "DB Username"

}
