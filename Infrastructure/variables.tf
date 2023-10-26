variable "google_project_id" {
  type        = string
  description = "ID of the GCP project"
}

variable "google_region" {
  type        = string
  default     = "europe-west1"
  description = "Default region"
}

variable "google_zone" {
  type        = string
  default     = "europe-west1-b"
  description = "Default zone"
}