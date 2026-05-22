terraform {
  backend "s3" {
    bucket         = "marciedev-tf-state"
    key            = "staging/aws/terraform.tfstate"
    region         = "us-east-2"
    use_lockfile   = true
    encrypt        = true
  }
}
