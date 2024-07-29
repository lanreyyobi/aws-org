locals {
  sso_instance_id       = tolist(data.aws_ssoadmin_instances.instance.arns)[0]
  sso_identity_store_id = tolist(data.aws_ssoadmin_instances.instance.identity_store_ids)[0]
  aws_org_id            = data.aws_organizations_organization.current.id
  root_ou               = ""
  target_id = data.aws_organizations_organization.current.roots[0].id

  target_accounts = [
    data.aws_organizations_organization.current.accounts[0].id,
    data.aws_organizations_organization.current.accounts[1].id,
    data.aws_organizations_organization.current.accounts[2].id,
    data.aws_organizations_organization.current.accounts[3].id,
  ]

  workload_ous = [
    "sandbox",
    "staging",
    "prod",
    "dev"
  ]

  eks_permission_policy_statement = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:List*",
          "eks:Describe*",
          "eks:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

#https://d-9167288ba3.awsapps.com/start
/*
data "aws_iam_policy_document" "eks_policy_document" {
  statement {
    effect = "allow"
    actions = [
      "eks:List*",
      "eks:Describe*",
      "eks:Get*"
    ]
    resources = ["*"]
  }
}
 */