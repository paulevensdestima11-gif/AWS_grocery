resource "aws_s3_bucket" "avatars" {
  bucket = "grocerymate-paul-avatars-2026"

  tags = {
    Name        = "grocerymate-avatars"
    Environment = "Dev"
  }
}