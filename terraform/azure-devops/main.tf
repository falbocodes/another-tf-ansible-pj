terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
    }
  }
}

# AWS provider
provider "aws" {
  region = "eu-west-1"
}
