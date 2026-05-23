output "google_storage_bucket_name" {
  description = "name of google storage bucket"
  value       = google_storage_bucket.app_assets.name
}

output "cloud_run_name" {
  description = "name of cloud run"
  value       = module.cloud-run-service.cloud_run_name
}

output "cloud_run_id" {
  description = "ID of cloud run"
  value       = module.cloud-run-service.cloud_run_id
}

output "cloud_run_url" {
  description = "url of cloud run service"
  value = module.cloud-run-service.cloud_run_url
}

output "cloud_run_iam_member" {
  description = "iam member data"
  value       = module.cloud-run-service.cloud_run_iam_member
}