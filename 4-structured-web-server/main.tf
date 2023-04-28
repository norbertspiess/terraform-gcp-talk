# general terraform configuration
terraform {
  required_version = ">= 1.4.4"
  required_providers {
    google = ">= 4.63.0"
  }
}

module "compute_instance" {
  source = "./modules/compute-instance"

  name = var.name # passing down values
}

# Output with module reference
output "public_ip" {
  value = module.compute_instance.public_ip
}

terraform {
  backend "gcs" {
    bucket = "aaap-terraform-admin"
    prefix = "terraform/state/foundera"
  }
}