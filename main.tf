provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

provider "github" {
  token        = var.github_token
  organization = var.github_organization
  version = "2.7.0"
}

terraform {
  required_version = "0.12.24"
}