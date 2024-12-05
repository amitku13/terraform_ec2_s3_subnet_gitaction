variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance."
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ami-0453ec754f44f9a4a"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "key_pair" {
  description = "The key pair name for SSH access."
  type        = string
  default     = "mykeypair"
}
