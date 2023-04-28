# general terraform configuration
terraform {
  required_version = ">= 1.4.4"
  required_providers {
    google = ">= 4.63.0"
  }
}

# Create a Google Compute Firewall
resource "google_compute_firewall" "instance" {
  name    = var.name
  network = "default"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

# Create a Google Compute instance
resource "google_compute_instance" "example" {
  name         = var.name
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

  #### 
  metadata_startup_script = "echo 'Hello, ${var.name}' > index.html ; nohup busybox httpd -f -p 8080 &"
}