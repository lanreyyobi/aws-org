# Create org-org
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}

# Org creation
resource "aws_organizations_organizational_unit" "workloads" {
  for_each = toset(local.workload_ous)

  name      = each.value
  parent_id = local.root_ou
}

# Create accounts
resource "aws_organizations_account" "dev" {
  name = "dev"

  email     = "email+2@gmail.com"
  parent_id = local.target_id
}

resource "aws_organizations_account" "staging" {
  name = "staging"

  email     = "email+3@gmail.com"
  parent_id = local.target_id
}

resource "aws_organizations_account" "prod" {
  name = "prod"

  email     = "email+4@gmail.com"
  parent_id = local.target_id
}

resource "aws_organizations_account" "sandbox" {
  name  = "sandbox"

  email = "email+1@gmail.com"
  parent_id = local.target_id
}






