terraform {
  required_version = ">= 1.6.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.45"   # check for the latest stable when you start
    }
  }

  backend "local" {}        # change to remote if you like (e.g. s3, terraform cloud)
}

