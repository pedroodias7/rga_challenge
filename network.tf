
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


resource "google_compute_address" "jenkins_static_ip" {
    project = var.project_id
  name   = "jenkins-instace-static-ip"
  region = var.region
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

# resource "google_compute_router_nat" "jenkinsnat" {
#   project                           = var.project_id
#   name                              = "jenkins-nat"
#   router                            = google_compute_router.jenkins_router.id
#   region                            = var.region
#   nat_ip_allocate_option            = "MANUAL_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
#   nat_ips                           = [google_compute_address.jenkins_static_ip.id]

#   log_config {
#     enable = true
#     filter = "ERRORS_ONLY"
#   }

#   # Add the specific subnetwork
#   subnetwork {
#     name                    = google_compute_subnetwork.jenkins_subnetwork.name
#     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#   }
# }

# resource "google_compute_router" "jenkins_router" {
#     region = var.region
#     project = var.project_id
#   name    = "jenkins-router"
#   network = google_compute_network.rga-network.self_link

# }
