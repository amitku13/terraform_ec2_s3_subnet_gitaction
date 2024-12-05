provider "aws" {
  region = var.aws_region
}


resource "aws_vpc" "main" {
  count      = var.create_vpc ? 1 : 0
  cidr_block = var.vpc_cidr
  tags       = { Name = "Action-VPC" }
}

resource "aws_subnet" "main" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  tags              = { Name = "Action-Subnet" }
}

resource "aws_instance" "main" {
  count         = var.create_ec2 ? 1 : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.create_vpc ? aws_subnet.main[0].id : var.subnet_id 
  key_name      = var.key_pair_name
  tags          = { Name = "Action-EC2" }
}

resource "random_id" "bucket_suffix" {
  count = var.create_s3 ? 1 : 0
  byte_length = 8
}

resource "aws_s3_bucket" "main" {
  count  = var.create_s3 ? 1 : 0
  bucket = "${var.s3_bucket_name}-${random_id.bucket_suffix[0].hex}"
  tags   = { Name = "Action-S3" }
}

resource "aws_launch_template" "main" {
  count          = var.create_autoscaling ? 1 : 0
  name           = "asg-launch-template"
  image_id       = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_pair_name
  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "ASG-Instance" }
  }
}

resource "aws_autoscaling_group" "main" {
  count             = var.create_autoscaling ? 1 : 0
  desired_capacity  = var.autoscaling_desired_capacity
  max_size          = var.autoscaling_max_size
  min_size          = var.autoscaling_min_size

  launch_template {
    id      = aws_launch_template.main[0].id
    version = "$Latest"
  }

  vpc_zone_identifier = var.create_vpc ? [aws_subnet.main[0].id] : [var.subnet_id]
}
