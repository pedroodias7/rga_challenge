resource "google_storage_bucket" "my-bucket" {
  name                     = "bucket-tf-rga"
  project                  = var.project_id
  location                 = "EU"
  force_destroy            = true
  public_access_prevention = "enforced"
}

