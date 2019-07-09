provider "google" {
  project = "${var.project_id}"
  region  = "asia-northeast1"
}

terraform {
  backend "gcs" {
    bucket = "terraform-root-state"
    prefix = "virtual-assitant/initialize"
  }
}

resource "google_project_services" "apis" {
  project = "${var.project_id}"
  services = [
    "datastore.googleapis.com",
    "sql-component.googleapis.com",
    "storage-component.googleapis.com",
    "cloudapis.googleapis.com",
    "storage-api.googleapis.com",
    "servicemanagement.googleapis.com",
    "serviceusage.googleapis.com",
    "clouddebugger.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "cloudtrace.googleapis.com",

    # "iamcredentials.googleapis.com",
    # "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    # "cloudbuild.googleapis.com",
  ]
}
