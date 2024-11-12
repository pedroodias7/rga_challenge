resource "google_compute_global_address" "static_ip" {
  project = var.project_id
  name = "xlb-ip"
}


resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  project = var.project_id
  name       = "https-fw-rule"
  port_range = "443"
  target     = google_compute_target_https_proxy.https_proxy.id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_address = google_compute_global_address.static_ip.address
}


resource "google_compute_target_https_proxy" "https_proxy" {
  project = var.project_id
  name             = "proxy-target-https"
  ssl_certificates = [data.google_compute_ssl_certificate.existing_ssl_cert.name]
  url_map          = google_compute_url_map.url_map.id
}

data "google_compute_ssl_certificate" "existing_ssl_cert" {
  project = var.project_id
  name = "pedrodias-ssl"
}


resource "google_compute_url_map" "url_map" {
  project = var.project_id
  name            = "xlb-pedro-webpage"
  default_service = google_compute_backend_bucket.backend_bucket.id
}


resource "google_storage_bucket" "backend_bucket" {
  project = var.project_id
  name     = "backend-bucket-rga-challenge"
  location = "EU"
  uniform_bucket_level_access = false

}

resource "google_storage_bucket_iam_binding" "public_bucket" {
  bucket = google_storage_bucket.backend_bucket.name
  role   = "roles/storage.objectViewer"

  members = ["allUsers"]
}

resource "google_compute_backend_bucket" "backend_bucket" {
  project = var.project_id
  name        = "backend-bucket"
  bucket_name = google_storage_bucket.backend_bucket.name
}

resource "google_storage_object_access_control" "public_rule" {
  object = "index.html"
  bucket = google_storage_bucket.backend_bucket.name
  role   = "READER"
  entity = "allUsers"
}


resource "google_compute_firewall" "allow_https" {
  project = var.project_id
  name    = "allow-https-to-load-balancer"
  network = google_compute_network.rga-network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_ranges = ["0.0.0.0/0"]  

}

resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  project = var.project_id
  name = "pedrowebpage-ssl-cert"
  managed {
    domains = [ "pedrodiaswebpage.pt", "www.pedrodiaswebpage.pt"]
  }
}


resource "google_storage_bucket_object" "index_html" {
  name   = "index.html"   
  bucket = google_storage_bucket.backend_bucket.name  
  source = "./index.html"  
}