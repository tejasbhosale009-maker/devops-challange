provider "local" {}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
