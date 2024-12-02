variable "ami_id" {}
variable "instance_type" {}
variable "key_pair_name" {}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
}
