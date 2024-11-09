resource "google_storage_bucket" "my-bucket" {
  name                     = "bucket-1-PedroDias-Demo"
  project                  = "tt-dev-001"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}