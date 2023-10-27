resource "google_pubsub_topic" "default" {
  name = "${var.environment}_pubsub_topic"
}

resource "google_pubsub_subscription" "subscription" {
  name  = "${var.environment}_pubsub_subscription"
  topic = google_pubsub_topic.default.name
  push_config {
    push_endpoint = google_cloud_run_v2_service.cloud_run_ocr.uri
    oidc_token {
      service_account_email = google_service_account.sa.email
    }
  }
  depends_on = [google_cloud_run_v2_service.cloud_run_ocr]
}