data "azuredevops_project" "kc" {
  name = var.proj-name
}

resource "aws_iam_user" "azdevops-another-tf-ansible-pj" {
  name = "azdevops-${var.proj-name}"
}

resource "aws_iam_access_key" "azdevops-another-tf-ansible-pj-key" {
  user = aws_iam_user.azdevops-another-tf-ansible-pj.name
}
