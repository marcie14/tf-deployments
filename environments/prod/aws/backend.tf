terraform {
  backend "s3" {
    bucket         = "marciedev-tf-state"
    key            = "prod/aws/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tf-state-lock"
    encrypt        = true
  }
}
