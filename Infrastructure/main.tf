provider "google" {
  credentials = file("./tf-sa-key.json")

  project = var.google_project_id
  region  = var.google_region
  zone    = var.google_zone
}