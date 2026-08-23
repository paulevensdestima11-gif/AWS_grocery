output "ec2_instance_id" {
  description = "ID of the GroceryMate EC2 instance"
  value       = aws_instance.web.id
}

output "ec2_private_ip" {
  description = "Private IP address of the GroceryMate EC2 instance"
  value       = aws_instance.web.private_ip
}

output "rds_endpoint" {
  description = "Endpoint of the PostgreSQL RDS instance"
  value       = aws_db_instance.postgres.endpoint
}

output "s3_avatars_bucket" {
  description = "Name of the S3 bucket used for avatars"
  value       = aws_s3_bucket.avatars.id
}