terraform {
  backend "s3" {
    bucket       = "tfstate-terraform-santos"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }
}