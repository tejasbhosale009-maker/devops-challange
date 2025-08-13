terraform {
  required_version = ">= 1.9.6"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
  }
}
