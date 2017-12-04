# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_elb" "pramerica-elb" {
  name = "pramerica-test-elb"

  availability_zones = ["${split(",", var.availability_zones)}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

resource "aws_autoscaling_group" "pramerica-asg" {
  availability_zones   = ["${split(",", var.availability_zones)}"]
  name                 = "pramerica-test-asg"
  max_size             = "${var.asg_max}"
  min_size             = "${var.asg_min}"
  desired_capacity     = "${var.asg_desired}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.pramerica-lc.name}"
  load_balancers       = ["${aws_elb.pramerica-elb.name}"]

  tag {
    key                 = "Name"
    value               = "pramerica-asg"
    propagate_at_launch = "true"
  }
}

resource "aws_launch_configuration" "pramerica-lc" {
  name          = "pramerica-test-lc"
  image_id      = "${lookup(var.aws_amis, var.aws_region)}"
  instance_type = "${var.instance_type}"

  # initialization data for the hosts/servers
  user_data       = "${file("userdata.sh")}"
  key_name        = "${var.key_name}"
}
