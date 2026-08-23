# RDS Subnet - Second Availability Zone
# RDS Private Subnet A
resource "aws_subnet" "rds_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "${var.project_name}-rds-subnet-a"
  }
}

# RDS Private Subnet B
resource "aws_subnet" "rds_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1b"

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
    from_port   = 5432
    to_port     = 5432
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
  name = "aws-grocery-db-subnet-group-v2"

  subnet_ids = [
    aws_subnet.rds_a.id,
    aws_subnet.rds_b.id
  ]

  tags = {
    Name = "aws-grocery-db-subnet-group-v2"
  }

  lifecycle {
    create_before_destroy = true
  }
}


# PostgreSQL RDS Instance
resource "aws_db_instance" "postgres" {

  identifier = "grocerymate-db"

  engine         = "postgres"
  engine_version = "15"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "grocerymate_db"
  username = "grocery_user"
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