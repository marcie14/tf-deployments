terraform {
  backend "gcs" {
    bucket = "marciedev-tf-state-gcp"
    prefix = "dev/gcp"
  }
}