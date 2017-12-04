output "launch_configuration" {
  value = "${aws_launch_configuration.pramerica-lc.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.pramerica-asg.id}"
}

output "elb_name" {
  value = "${aws_elb.pramerica-elb.dns_name}"
}
