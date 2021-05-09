locals {
  aws_role_app   = "arn:aws:iam::${local.aws_account_id}:role/aviatrix-role-app"
  aws_role_ec2   = "arn:aws:iam::${local.aws_account_id}:role/aviatrix-role-ec2"
  aws_account_id = data.terraform_remote_state.controller_data.outputs.cloudformation["AccountId"]
}

data "terraform_remote_state" "controller_data" {
  backend = "local"

  config = {
    path = "../controller-bootstrap/terraform.tfstate"
  }
}

// Add AWS account
resource "aviatrix_account" "aws_account" {
  account_name = var.aws_account_name
  // Cloud type:
  // AWS	"1"
  // Azure (Azure Classic)	"2"
  // Gcloud	"4"
  // ARM (Azure Resource Manager)	"8"
  // Azure Government	"32"
  // AWS GovCloud	"256"
  // Azure China	"512"
  // AWS China	"1024
  // ARM China	"2048"
  cloud_type         = 1
  aws_iam            = true
  aws_account_number = local.aws_account_id
  aws_role_app       = local.aws_role_app
  aws_role_ec2       = local.aws_role_ec2
}

//Add Azure account
resource "aviatrix_account" "azure_account" {
  account_name        = var.azure_account_name
  cloud_type          = 8
  arm_subscription_id = var.azure_subscription_id
  arm_directory_id    = var.azure_directory_id
  arm_application_id  = var.azure_app_id
  arm_application_key = var.azure_app_key
}

//Add Google Cloud account
resource "aviatrix_account" "gcp_account" {
  account_name                        = var.gcp_account_name
  cloud_type                          = 4
  gcloud_project_id                   = var.gcp_project_id
  gcloud_project_credentials_filepath = var.gcp_project_creds_path
}