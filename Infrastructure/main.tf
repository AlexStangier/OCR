provider "google" {

  project = var.google_project_id
  region  = var.google_region
  zone    = var.google_zone
}