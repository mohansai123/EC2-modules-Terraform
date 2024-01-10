terraform {
  backend "s3" {
    bucket         = "automated-s3-backend"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "automate-dynamodb"
  }
}
