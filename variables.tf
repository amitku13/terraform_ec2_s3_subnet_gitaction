variable "create_vpc" {
  description = "Set to true to create a VPC"
  type        = bool
  default     = true
}

variable "create_ec2" {
  description = "Set to true to create an EC2 instance"
  type        = bool
  default     = true
}

variable "create_s3" {
  description = "Set to true to create an S3 bucket"
  type        = bool
  default     = true
}

variable "create_autoscaling" {
  description = "Set to true to create an Auto Scaling group"
  type        = bool
  default     = true
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "172.31.32.0/20"
}

variable "availability_zone" {
  description = "Availability zone for resources"
  type        = string
  default     = "us-east-1a"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Key pair name for EC2"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name prefix for the S3 bucket"
  type        = string
}

variable "autoscaling_desired_capacity" {
  description = "Desired capacity for the Auto Scaling group"
  type        = number
  default     = 1
}

variable "autoscaling_max_size" {
  description = "Maximum size for the Auto Scaling group"
  type        = number
  default     = 2
}

variable "autoscaling_min_size" {
  description = "Minimum size for the Auto Scaling group"
  type        = number
  default     = 1
}

variable "security_group_id" {
  description = "Security Group ID for EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}

variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}
