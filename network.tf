
resource "google_compute_network" "rga-network" {
    project = var.project_id
  name = "rga-network"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "jenkins_subnetwork" {
    region = var.region
    project = var.project_id
    network = google_compute_network.rga-network.self_link
    name = "jenkins-subnet"
    ip_cidr_range = "192.168.1.0/24"
}


resource "google_compute_firewall" "jenkins-firewall" {
    project = var.project_id
  name    = "allow-http-ssh"
  network = google_compute_network.rga-network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}


import {
  id = "projects/liquid-polygon-441116-m4/managedZones/rga"
  to = google_dns_managed_zone.rga_zone
}

resource "google_dns_managed_zone" "rga_zone" {
        dns_name         = "lbdemo.eu."
        name             = "rga"
        project          = var.project_id
        visibility       = "public"

        cloud_logging_config {
            enable_logging = false
        }
    }