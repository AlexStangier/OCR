resource "google_pubsub_topic" "image_placed_in_bucket" {
  name    = "image_placed_in_bucket"
  project = var.google_project_id
}

resource "google_pubsub_subscription" "subscription" {
  name  = "image_was_placed_in_bucket_subscription"
  topic = google_pubsub_topic.image_placed_in_bucket

  push_config {
    push_endpoint = google_cloud_run_v2_service.cloud_run_ocr.uid
    oidc_token {
      service_account_email = google_service_account.service_account_pubsub.email
    }
  }
}