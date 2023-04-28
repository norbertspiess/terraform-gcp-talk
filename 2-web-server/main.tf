# general terraform configuration
terraform {
  required_version = ">= 1.4.4"
  required_providers {
    google = ">= 4.63.0"
  }
}

# Configure the Google Cloud provider
provider "google" {
  credentials = file("../aaapedia-terraform-1234-84976e2f6524.json") # SA key
  project     = "aaapedia-terraform-1234"                            # project name
  region      = "europe-west6"
}

# Create a Google Compute Firewall
resource "google_compute_firewall" "instance" {
  name    = ""
  network = "default"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

# Create a Google Compute instance
resource "google_compute_instance" "example" {
  name         = ""
  machine_type = "f1-micro"
  zone         = "europe-west6-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "echo 'Hello, World' > index.html ; nohup busybox httpd -f -p 8080 &"
}

# Output variable: Public IP address
output "public_ip" {
  value = google_compute_instance.example.network_interface.0.access_config.0.nat_ip
}