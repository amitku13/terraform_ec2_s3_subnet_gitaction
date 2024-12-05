provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "main" {
  count      = var.create_vpc ? 1 : 0
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Action-VPC"
  }
}
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}


# Subnet
resource "aws_subnet" "main" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "Action-Subnet"
  }
}
resource "aws_instance" "example" {
  # Other config
  lifecycle {
    prevent_destroy = true
  }
}


# EC2 Instance
resource "aws_instance" "main" {
  count         = var.create_ec2 ? 1 : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.create_vpc ? aws_subnet.main[0].id : var.subnet_id
  key_name      = var.key_pair_name
  tags = {
    Name = "Action-EC2"
  }
}

# Random S3 Bucket Suffix
resource "random_id" "bucket_suffix" {
  count       = var.create_s3 ? 1 : 0
  byte_length = 8
}

# S3 Bucket
resource "aws_s3_bucket" "main" {
  count  = var.create_s3 ? 1 : 0
  bucket = var.create_s3 ? "${var.s3_bucket_name}-${random_id.bucket_suffix[0].hex}" : null
  tags = {
    Name = "Action-S3"
  }
  
}

# Launch Template for Autoscaling
resource "aws_launch_template" "main" {
  count         = var.create_autoscaling ? 1 : 0
  name          = "asg-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG-Instance"
    }
  }
}

# Autoscaling Group
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

  tag {
    key                 = "Name"
    value               = "ASG-Instance"
    propagate_at_launch = true
  }
}
