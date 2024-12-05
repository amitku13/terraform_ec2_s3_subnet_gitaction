output "vpc_id" {
  value       = var.create_vpc ? aws_vpc.main[0].id : null
  description = "The ID of the created VPC (if created)."
}

output "subnet_id" {
  value       = var.create_vpc ? aws_subnet.main[0].id : null
  description = "The ID of the created Subnet (if created)."
}

output "ec2_instance_id" {
  value       = var.create_ec2 ? aws_instance.main[0].id : null
  description = "The ID of the created EC2 instance (if created)."
}

output "s3_bucket_name" {
  value       = var.create_s3 ? aws_s3_bucket.main[0].bucket : null
  description = "The name of the created S3 bucket (if created)."
}

output "autoscaling_group_name" {
  value       = var.create_autoscaling ? aws_autoscaling_group.main[0].name : null
  description = "The name of the created Auto Scaling group (if created)."
}
