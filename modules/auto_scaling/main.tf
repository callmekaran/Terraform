resource "aws_autoscaling_group" "asg" {
  availability_zones = data.aws_availability_zones.az.names
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {

    id      =  var.launch_template_id_source
    version = "$Latest"
  }
}