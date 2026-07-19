resource "aws_s3_bucket" "grocery_bucket" {

  bucket = "grocerymate-paul-terraform-demo-2026"

  tags = {
    Name        = "grocerymate-storage"
    Environment = "dev"
  }

}