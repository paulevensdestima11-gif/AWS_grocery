variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "db_password" {
  description = "Password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones used by the infrastructure"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "rds_subnet_a_cidr" {
  description = "CIDR block for RDS private subnet A"
  type        = string
}

variable "rds_subnet_b_cidr" {
  description = "CIDR block for RDS private subnet B"
  type        = string
}

variable "app_port" {
  description = "Port used by the Flask application"
  type        = number
}

variable "db_port" {
  description = "Port used by PostgreSQL"
  type        = number
}

variable "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  type        = string
}

variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "db_engine" {
  description = "Database engine"
  type        = string
}

variable "db_engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated RDS storage in GB"
  type        = number
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_username" {
  description = "PostgreSQL database username"
  type        = string
}

variable "avatars_bucket_name" {
  description = "Name of the S3 bucket used for user avatars"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "avatars_bucket_display_name" {
  description = "Deployment environment"
  type        = string
}

variable "sns_notification_email" {
  description = "Endpoint"
  type        = string
}

variable "profile_admin" {
  description = "AWS CLI profile used by Terraform"
  type        = string
}