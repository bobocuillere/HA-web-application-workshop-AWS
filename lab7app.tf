resource "aws_autoscaling_group" "auto-scaling-group" {

  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.launch-conf.name
  max_size             = var.max_size
  min_size             = var.min_size
  target_group_arns    = [aws_lb_target_group.lb-target-group.arn]
  vpc_zone_identifier  = [aws_subnet.Application-Subnets[0].id, aws_subnet.Application-Subnets[1].id]

}

/*resource "aws_autoscaling_policy" "scaling-policy" {
  name               = "Scale Group Size"
  scaling_adjustment = 3
  adjustment_type    = "ChangeInCapacity"

  autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
} */
