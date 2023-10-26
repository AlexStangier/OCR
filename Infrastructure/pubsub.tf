resource "google_pubsub_topic" "image_placed_in_bucket" {
  name    = "image_placed_in_bucket"
  project = var.google_project_id
}

resource "google_pubsub_subscription" "subscription" {
  name  = "pubsub_subscription"
  topic = google_pubsub_topic.image_placed_in_bucket.name
  push_config {
    push_endpoint = google_cloud_run_v2_service.cloud_run_ocr.uri
    oidc_token {
      service_account_email = google_service_account.service_account_cloud_run.email
    }
    attributes = {
      x-goog-version = "v1"
    }
  }
  depends_on = [google_cloud_run_v2_service.cloud_run_ocr]
}