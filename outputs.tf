# Output for VPC ID
output "vpc_id" {
  value       = aws_vpc.main[0].id
  description = "The ID of the created VPC (if created)."
  condition   = var.create_vpc
}

# Output for Subnet ID
output "subnet_id" {
  value       = aws_subnet.main[0].id
  description = "The ID of the created Subnet (if created)."
  condition   = var.create_vpc
}

# Output for EC2 Instance ID
output "ec2_instance_id" {
  value       = aws_instance.main[0].id
  description = "The ID of the created EC2 instance (if created)."
  condition   = var.create_ec2
}

# Output for S3 Bucket Name
output "s3_bucket_name" {
  value       = aws_s3_bucket.main[0].bucket
  description = "The name of the created S3 bucket (if created)."
  condition   = var.create_s3
}

# Output for Auto Scaling Group Name
output "autoscaling_group_name" {
  value       = aws_autoscaling_group.main[0].name
  description = "The name of the created Auto Scaling group (if created)."
  condition   = var.create_autoscaling
}
