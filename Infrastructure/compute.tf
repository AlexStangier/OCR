resource "google_cloud_run_v2_service" "cloud_run_ocr" {
  name     = "cloudrun-service"
  location = var.google_region

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}