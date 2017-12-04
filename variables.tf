variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-1"
}

# Amazon Machine Images(AMI's) to associate with the launch configuration
variable "aws_amis" {
  default = {
    "eu-west-1" = "ami-5f709f34"
    "eu-west-2" = "ami-7f675e4f"
  }
}

variable "availability_zones" {
  default     = "eu-west-1, eu-west-2"
  description = "List of availability zones"
}

variable "key_name" {
  description = "Name of AWS key pair"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "3"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "5"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "3"
}
