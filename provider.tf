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

locals {
  iac_terraform_roles = [
    #"iam.organizationRoleAdmin" -> Organization Scope IAM Role
    "compute.googleapis.com",
    
  ]
}
