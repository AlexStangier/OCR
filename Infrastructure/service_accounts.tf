resource "google_service_account" "service_account_pubsub" {
  account_id   = "pubsub-service-account"
  display_name = "PubSub Service Account"
}

resource "google_service_account" "service_account_cloud_run" {
  account_id   = "cloud-run-service-account"
  display_name = "Cloud Run Service Account"
}

