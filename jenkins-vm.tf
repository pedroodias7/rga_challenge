# resource "google_compute_instance" "jenkins-instance" {
#     project = var.project_id
#   name         = "jenkins-runner-instance"
#   machine_type = "e2-medium"
#   zone         = "europe-west1-c"
#   tags         = ["http-server", "ssh", "jenkins"]
#   allow_stopping_for_update = true
  

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"  # Debian is a stable choice for Jenkins
#     }
#   }
#  network_interface {
#     network    = google_compute_network.rga-network.self_link
#     subnetwork = google_compute_subnetwork.jenkins_subnetwork.self_link
#     access_config {
#       # Assign the reserved static IP to this V
#     }
#  }

# service_account {
#     email  = "94201750594-compute@developer.gserviceaccount.com" 
#     scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
#   }
#  metadata = {
#     startup-script = "sudo apt update\nsudo apt install git -y\nsudo apt install openjdk-11-jre -y\ncurl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \\\n  /usr/share/keyrings/jenkins-keyring.asc > /dev/null\necho deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \\\n  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \\\n  /etc/apt/sources.list.d/jenkins.list > /dev/null\nsudo apt-get update\nsudo apt-get install jenkins -y"
#   }

    
# }



# This code is compatible with Terraform 4.25.0 and versions that are backward compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

# resource "google_compute_instance" "jenkins-server-1" {
#   boot_disk {
#     auto_delete = true
#     device_name = "instance-template-1"

#     initialize_params {
#       image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230411"
#       size  = 10
#       type  = "pd-balanced"
#     }

#     mode = "READ_WRITE"
#   }

#   can_ip_forward      = false
#   deletion_protection = false
#   enable_display      = false

#   labels = {
#     ec-src = "vm_add-tf"
#   }

#   machine_type = "e2-medium"

#   metadata = {
#     startup-script = "sudo apt update\nsudo apt install git -y\nsudo apt install openjdk-11-jre -y\ncurl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \\\n  /usr/share/keyrings/jenkins-keyring.asc > /dev/null\necho deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \\\n  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \\\n  /etc/apt/sources.list.d/jenkins.list > /dev/null\nsudo apt-get update\nsudo apt-get install jenkins -y"
#   }

#   name = "jenkins-server-1"

#   network_interface {
#     access_config {
#       network_tier = "PREMIUM"
#     }

#     subnetwork = "projects/${var.project_id}/regions/us-central1/subnetworks/default"
#   }

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#     preemptible         = false
#     provisioning_model  = "STANDARD"
#   }

#   service_account {
#     email  = "1008566890267-compute@developer.gserviceaccount.com"
#     scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
#   }

#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot          = false
#     enable_vtpm                 = true
#   }

#   tags = ["http-server", "https-server", "jenkins"]
#   zone = "us-central1-a"
# }


# resource "google_project_iam_member" "project" {
#   project = var.project_id
#   role    = "roles/iap.tunnelResourceAccessor"
#   member  = "user:itzargy@gmail.com"
# }