variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "project-60ac09b3-de72-47ae-99c"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
variable "image" {
  description = "Container image URI to deploy"
  type        = string
  default = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "allow_public_access" {
  description = "whether to allow unauthenticated access"
  type        = bool
  default     = true
}