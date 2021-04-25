variable "AWS_REGION" {
  description = "AWS region"
  type        = string
}

variable "AWS_PROFILE" {
  description = "The profile terraform going to use on AWS"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR of the VPC"

}

variable "subnets_cidr" {
  type        = string
  description = "The CIDR for the 5 subnets"

}

variable "azs" {
  type        = list(any)
  description = "Availabilty zones"

}

variable "AB" {
  type        = list(any)
  description = "The name for subnet A and B"
}

variable "igw_routes" {
  type        = list(any)
  description = "All the routes in the Internet Gateway"
}
variable "nat_routes" {
  type        = list(any)
  description = "All the routes of the Nat gateway"
}
/* variable "EIPs" {
  type = list
} */
variable "dbuser" {
  type        = string
  description = "Username for the RDS DB"
}

variable "dbpass" {
  type        = string
  sensitive   = true
  description = "Password for the Aurora DB"
}

variable "memcached_node" {
  type = string
}
variable "linux_ami" {
  type        = string
  description = "The REDHAT AMI in the Region of North Virginia (us-east-1)"
}
############################################ LAB 2 : RDS -------------------------------------------------------------------------------------
variable "sg_database_client" {
  type        = string
  description = "The Client Database Security Group"
}

variable "sg_database" {
  type        = string
  description = "The Database Security Group"
}

variable "aurora_port" {
  type        = string
  description = "The port for the SQL/Aurora DB"
}

variable "db_subnet_group" {
  type        = string
  description = "The name of the subnet group for the RDS"
}

variable "cluster_identifier" {
  type        = string
  description = "The cluster Identifier"
}

variable "engine" {
  type        = string
  description = "The enfine of the cluster"
}

variable "engine_version_rds" {
  type        = string
  description = "The engine versionr"
}

variable "database_name" {
  type        = string
  description = "The database name"
}

variable "rds_instance_class" {
  type        = string
  description = "The RDS Instance Class"
}
############################################################## LAB 3: ELASTICACHE --------------------------------------------------------------------

variable "sg_cache_client" {
  type        = string
  description = "The Security Group for the Cache Client"
}

variable "sg_cache" {
  type        = string
  description = "The Security Group for the Cache"
}

variable "memcached_port" {
  type        = string
  description = "The memcached port"
}

variable "elastic_memcached_subnet" {
  type        = string
  description = "The name of the subnet group for the elasticache"
}

variable "cluster_id" {
  type        = string
  description = "The memcached cluster id"
}

variable "cluster_engine" {
  type        = string
  description = "The engine cluster"
}

variable "num_cache_nodes" {
  type        = string
  description = "number of node for the ElastiCache"
}

variable "memcached_parameter" {
  type        = string
  description = "The memcached parameter group name"
}
############################################################ LAB 4: FILE SYSTEM -----------------------------------------------------

variable "sg_fs_client" {
  type        = string
  description = "The security group for the Client File System"
}

variable "sg_fs" {
  type        = string
  description = "The security group for the File System"
}

variable "fs_port" {
  type        = string
  description = "The file system port"
}

variable "creation_token" {
  type        = string
  description = "The creation token for the FS"
}
####################################################### LAB 5 : Load Balancer -------------------------------------------------------------

variable "sg_load_balancer" {
  type        = string
  description = "Security group for the load balancer"
}

variable "http_port" {
  type        = string
  description = "The http port"
}

variable "loadbalancer_name" {
  type        = string
  description = "The LB name"
}

variable "loadbalancer_type" {
  type        = string
  description = "The LB type"
}

variable "http_protocol" {
  type        = string
  description = "The http protocol"
}

variable "default_action_type" {
  type        = string
  description = "Where the listeners is going to send the traffic"
}


variable "lb_target_group_name" {
  type        = string
  description = "The load balancer target group name"
}

##################################################### LAB 6:  Launch Configuration -------------------------------------------------------------------------------

variable "sg_wordpress" {
  type        = string
  description = "The security group for wordpress"
}

variable "https_port" {
  type        = string
  description = "The http port"
}

variable "launch_configuration_prefix" {
  type        = string
  description = "The Launch Configuration profile name"
}

variable "ec2_instance_type" {
  type        = string
  description = "The instance type launch with launch configuration type"
}
################################################## LAB 7: Auto Scalling Group ---------------------------------------------------------

variable "asg_name" {
  type        = string
  description = "Auto Scalling Group Name"
}

variable "max_size" {
  type        = string
  description = "The maximun of Instance that can run concurrently"
}

variable "min_size" {
  type        = string
  description = "The minimum of Instance that need to be up at all time"
}
