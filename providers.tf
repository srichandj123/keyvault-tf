terraform {
  required_version = "~> 1.7"
  cloud {
    organization = "jakka"
    workspaces {
      name = "keyvault-wkspc"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.105"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false # This is to handle MCAPS or other policy driven resource creation.
    }
  }
}

#RAndom Provider
provider "random" {
  # Configuration options
}
