# general terraform configuration
terraform {
  required_version = ">= 1.4.4"
  required_providers {
    google = ">= 4.63.0"
  }
}

# Configure the Google Cloud provider
# https://registry.terraform.io/providers/hashicorp/google/latest
provider "google" {
  # service account key (not! how you should do it for real)
  credentials = file("../aaapedia-terraform-1234-84976e2f6524.json")
  project     = "aaapedia-terraform-1234" # gcp project to work int
  region      = "europe-west6"            # the region to use
}

# Create a Google Compute instance
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
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
}