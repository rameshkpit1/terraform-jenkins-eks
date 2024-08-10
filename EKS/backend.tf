terraform {
  backend "s3" {
    bucket = "ram-cicd-bucket"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}
