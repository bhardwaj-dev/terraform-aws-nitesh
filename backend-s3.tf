terraform {
  backend "s3" {
  bucket = "nitesh-terra-backend"
    key = "terraform/backend"
    region = "us-east-2"
  }
}