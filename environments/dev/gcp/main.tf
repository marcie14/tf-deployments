terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "app_assets" {
  name          = "marciedev-app-assets-${var.environment}"
  location      = "US"
  force_destroy = true
  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true

  labels = {
    environment = var.environment
    team        = "marciedev"
    managed_by  = "terraform"
  }
}

module "cloud-run-service" {
  source              = "github.com/marcie14/tf-modules//modules/gcp/cloud-run-service?ref=cloud-run-service-v1.1.0"
  project_id          = var.project_id
  region              = var.region
  environment         = var.environment
  image               = var.image
  allow_public_access = var.allow_public_access
}
