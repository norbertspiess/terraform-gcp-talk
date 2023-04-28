# Configure the Google Cloud provider
provider "google" {
  credentials = file("../aaapedia-terraform-1234-84976e2f6524.json") # SA key
  project     = "aaapedia-terraform-1234"                            # project name
  region      = "europe-west6"
}