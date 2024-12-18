#Installing the dependencied
terraform {
  required_version = ">= 1.0.1"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}