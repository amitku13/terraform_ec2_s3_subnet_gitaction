variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "key_pair" {
  description = "The key pair name for SSH access."
  type        = string
}
