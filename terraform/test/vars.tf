terraform {
  backend "s3" {
    bucket         = "420995033334-terraform-states"
    key            = "another-tf-ansible-pj/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "420995033334-terraform-state-lock"
  }
}

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "420995033334-terraform-states"
    key    = "global/terraform.tfstate"
    region = "eu-west-1"
  }
}

variable "proj-name" {
  default = "another-tf-ansible-pj"
}

variable "centos-ami-id" {
  #default = "ami-09e310d4361a3b13a" #Centos 9
  default = "ami-0e0669c0b39d3a79f"
}

variable "instance-type" {
  default = "t2.small"
}

variable "region" {
  default = "eu-west-1"
}


variable "warmup-path" {
  description = "Warmup script"
  default     = "./scripts/warmup.sh"
}