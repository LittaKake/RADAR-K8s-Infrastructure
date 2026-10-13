terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "8.7.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "8.7.0"
    }
  }
}

provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}