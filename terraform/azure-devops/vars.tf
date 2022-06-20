terraform {
  backend "s3" {
    bucket         = "420995033334-terraform-states"
    key            = "azuredevops/another-tf-ansible-pj/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "420995033334-terraform-state-lock"
  }
}



variable "proj-name" {
  default = "another-tf-ansible-pj"
}
