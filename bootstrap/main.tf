resource "aws_s3_bucket" "tfstate" {
  bucket        = "tfstate-terraform-santos"
  force_destroy = true

  tags = {
    Environment = "dev"
    ManageBy    = "Terraform"
  }
}