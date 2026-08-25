# RDS Subnet - Second Availability Zone
# RDS Private Subnet A
resource "aws_subnet" "rds_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.rds_subnet_a_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.project_name}-rds-subnet-a"
  }
}

# RDS Private Subnet B
resource "aws_subnet" "rds_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.rds_subnet_b_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.project_name}-rds-subnet-b"
  }
}

# RDS Security Group
resource "aws_security_group" "rds" {

  name        = "${var.project_name}-rds-sg"
  description = "Allow PostgreSQL access from EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "PostgreSQL from EC2"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"

    security_groups = [
      aws_security_group.ec2.id
    ]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "${var.project_name}-rds-security-group"
  }
}


# RDS Subnet Group
resource "aws_db_subnet_group" "postgres" {
  name = var.db_subnet_group_name

  subnet_ids = [
    aws_subnet.rds_a.id,
    aws_subnet.rds_b.id
  ]

  tags = {
    Name = var.db_subnet_group_name
  }

  lifecycle {
    create_before_destroy = true
  }
}


# PostgreSQL RDS Instance
resource "aws_db_instance" "postgres" {

  identifier = var.db_identifier

  engine         = var.db_engine
  engine_version = var.db_engine_version

  instance_class = var.rds_instance_class

  allocated_storage = var.db_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  db_subnet_group_name = aws_db_subnet_group.postgres.name

  publicly_accessible = false

  storage_encrypted = true

  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-postgres"
  }
}