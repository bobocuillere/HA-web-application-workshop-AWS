AWS_REGION = "us-east-1"

AWS_PROFILE = "default"

vpc_cidr = "192.168.0.0/16"

subnets_cidr = "192.168.0.0/20"

azs = ["us-east-1a", "us-east-1b"]

AB = ["A", "B"]

igw_routes = ["0.0.0.0/0"]

nat_routes = ["0.0.0.0/0"]

dbuser = "wpadmin"

dbpass = "xxxxxxxxxxxxxxxxxxx"

memcached_node = "cache.t2.medium"

linux_ami = "ami-0ba7c4110ca9bfe0b" #"ami-096fda3c22c1c990a"
############################################## LAB 2: RDS -------------------------------------------------------------------------------
sg_database_client = "WPDatabaseClientSG"

sg_database = "WPDatabaseSG"

aurora_port = "3306"

db_subnet_group = "wp-db-sub-group"

cluster_identifier = "wordpress-workshop"

engine = "aurora-mysql"

engine_version_rds = "5.7.mysql_aurora.2.07.2"

database_name = "wordpress"

rds_instance_class = "db.t3.small"
############################################## LAB 3: ElastiCache ------------------------------------------------------------------------

sg_cache_client = "WP Cache Client SG"

sg_cache = "WP Cache SG"

memcached_port = "11211"

elastic_memcached_subnet = "memcached-subnet-wordpress"

cluster_id = "wordpress-memcached"

cluster_engine = "memcached"

num_cache_nodes = "1"

memcached_parameter = "default.memcached1.6"
##################################################### LAB 4: File System -------------------------------------------------------------------

sg_fs_client = "WP FS Client SG"

sg_fs = "WP FS SG"

fs_port = "2049"

creation_token = "File System"
##################################################### LAB 5: Load balancer

sg_load_balancer = "WP Load Balancer SG"

http_port = "80"

loadbalancer_name = "wordpreess-workshop-ALB"

loadbalancer_type = "application"

http_protocol = "HTTP"

default_action_type = "forward"

lb_target_group_name = "targetgroup"
##################################################### LAB 6: Launch Configuration ---------------------------------------------------------------

sg_wordpress = "WP Wordpress SG"

https_port = "443"

launch_configuration_prefix = "launchConf"

ec2_instance_type = "t2.small"
##################################################### LAB 7: AUTO Scalling Group

asg_name = "wordpress-workshop-ASG"

max_size = "3"

min_size = "1"








