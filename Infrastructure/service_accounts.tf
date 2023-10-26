resource "google_service_account" "service_account_cloud_run" {
  account_id   = "cloud-run-service-account"
  display_name = "${var.environment} Cloud Run Service Account"
}

resource "google_project_service_identity" "pubsub_agent" {
  provider = google-beta
  project  = var.google_project_id
  service  = "pubsub.googleapis.com"
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_v2_service.cloud_run_ocr.location
  service  = google_cloud_run_v2_service.cloud_run_ocr.name
  role     = "roles/run.invoker"
  members  = ["serviceAccount:${google_service_account.service_account_cloud_run.email}"]
}

resource "google_project_iam_binding" "project_token_creator" {
  project = var.google_project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_project_service_identity.pubsub_agent.email}"]
}