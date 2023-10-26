resource "google_storage_bucket" "bucket_image_source" {
  name          = "${var.environment}-image-bucket-${var.google_project_id}"
  location      = var.google_region
  force_destroy = true
}

resource "google_storage_bucket" "bucket_text_persistence" {
  name          = "${var.environment}-text-bucket-${var.google_project_id}"
  location      = var.google_region
  force_destroy = true
}
