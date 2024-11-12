terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket                      = "bucket-tf-rga"
    prefix                      = "rga"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.0"
    }
  }
}

locals {
  iac_terraform_roles = [
    "compute.googleapis.com",
    
  ]
}
