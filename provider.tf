terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket                      = "bucket-tf-rga"
    prefix                      = "rga"
    # impersonate_service_account = "tf-alticept-apim-nonprod-sa@alticept-apim-nonprod.iam.gserviceaccount.com"
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


resource "google_storage_bucket" "rga_bucket" {
  project = var.project_id
  name          = "rga-challenge"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true

}


locals {
  iac_terraform_roles = [
    #"iam.organizationRoleAdmin" -> Organization Scope IAM Role
    "compute.googleapis.com",
    
  ]
}

# resource "google_project_iam_member" "terraform_iac_deploy" {
#   for_each = toset(local.iac_terraform_roles)
#   member   = "user:itzargy@gmail.com"
#   project  = var.project_id
#   role     = "roles/${each.key}"

#   lifecycle {
#     create_before_destroy = true
#   }
# }