resource "google_service_account" "cr" {
  account_id   = "cloud-run-sa"
  display_name = "${var.environment} Cloud Run Service Account"
}

resource "google_project_iam_binding" "cr-storage" {
  project = var.google_project_id
  role    = "roles/storage.objectUser"
  members = ["serviceAccount:${google_service_account.cr.email}"]
}

resource "google_service_account" "sa" {
  account_id   = "cloud-run-pubsub-invoker"
  display_name = "${var.environment} Cloud Run Pub/Sub Invoker"
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = google_cloud_run_v2_service.cloud_run_ocr.location
  service  = google_cloud_run_v2_service.cloud_run_ocr.name
  role     = "roles/run.invoker"
  members  = ["serviceAccount:${google_service_account.sa.email}"]
}

resource "google_project_service_identity" "pubsub_agent" {
  provider = google-beta
  project  = var.google_project_id
  service  = "pubsub.googleapis.com"
}

resource "google_project_iam_binding" "project_token_creator" {
  project = var.google_project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = ["serviceAccount:${google_project_service_identity.pubsub_agent.email}"]
}